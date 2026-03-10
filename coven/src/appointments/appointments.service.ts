import {
  Injectable,
  NotFoundException,
  BadRequestException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { ProductsService } from '../products/products.service';
import { GoalsService } from '../goals/goals.service';
import { EntryAnalyticsService } from '../entry-analytics/entry-analytics.service';
import { OutAnalyticsService } from '../out-analytics/out-analytics.service';
import { CreateAppointmentDto } from './dto/create-appointment.dto';
import { UpdateAppointmentDto } from './dto/update-appointment.dto';
import { AppointmentStatus } from '@prisma/client';

@Injectable()
export class AppointmentsService {
  constructor(
    private prisma: PrismaService,
    private productsService: ProductsService,
    private goalsService: GoalsService,
    private entryAnalyticsService: EntryAnalyticsService,
    private outAnalyticsService: OutAnalyticsService,
  ) { }

  // REESTRUTURADO: Lógica de criação otimizada e mais clara
  async create(createAppointmentDto: CreateAppointmentDto) {
    const {
      procedureIds,
      startTime: startTimeString,
      date,
      userId,
      clientId,
    } = createAppointmentDto;

    const isBlock = createAppointmentDto.status === 'BLOQUEADO';

    if (!isBlock && !clientId) {
      throw new BadRequestException('clientId é obrigatório para agendamentos.');
    }

    const procedureIdsArray = procedureIds || [];
    const procedures = procedureIdsArray.length > 0
      ? await this.prisma.procedure.findMany({
        where: { id: { in: procedureIdsArray }, active: true },
      })
      : [];

    if (procedureIdsArray.length > 0 && procedures.length !== procedureIdsArray.length) {
      throw new BadRequestException(
        'Um ou mais procedimentos são inválidos ou inativos.',
      );
    }

    // 2. Calcula duração, preço e horários
    const totalDuration = procedures.reduce(
      (sum, proc) => sum + proc.duration,
      0,
    );
    const totalPrice = procedures.reduce(
      (sum, proc) => sum + Number(proc.price),
      0,
    );
    const startTime = new Date(startTimeString);
    // Se não há procedimentos e não foi fornecido endTime, usa 1 hora como padrão
    const endTime = createAppointmentDto.endTime
      ? new Date(createAppointmentDto.endTime)
      : new Date(startTime.getTime() + (totalDuration || 60) * 60000);

    await this.validateTimeConflict(userId, startTime, endTime);

    return this.prisma.$transaction(async (tx) => {
      const appointment = await tx.appointment.create({
        data: {
          clientId: clientId || undefined,
          userId,
          date: new Date(date),
          startTime,
          endTime,
          status: createAppointmentDto.status, // Passa o status explicitamente (BLOQUEADO ou default)
          totalPrice,
          paymentMethod: createAppointmentDto.paymentMethod,
          discount: createAppointmentDto.discount,
          observations: createAppointmentDto.observations,
          procedures: procedures.length > 0 ? {
            create: procedures.map((proc) => ({
              procedureId: proc.id,
              price: proc.price,
            })),
          } : undefined,
        },
      });

      // Retorna o agendamento completo
      return tx.appointment.findUnique({
        where: { id: appointment.id },
        include: {
          client: {
            select: {
              id: true,
              name: true,
              email: true,
              phone: true,
              birthDate: true,
              address: true,
              observations: true,
              active: true,
              createdAt: true,
              updatedAt: true,
            },
          },
          user: true,
          procedures: { include: { procedure: true } },
        },
      });
    });
  }

  async update(id: string, updateAppointmentDto: UpdateAppointmentDto) {
    const originalAppointment = await this.findOne(id);

    const finalProcedureIds =
      updateAppointmentDto.procedureIds ??
      originalAppointment.procedures.map((p) => p.procedureId);

    const procedures = finalProcedureIds.length > 0
      ? await this.prisma.procedure.findMany({
          where: { id: { in: finalProcedureIds }, active: true },
        })
      : [];

    if (finalProcedureIds.length > 0 && procedures.length !== finalProcedureIds.length) {
      throw new BadRequestException(
        'Um ou mais procedimentos são inválidos ou inativos.',
      );
    }

    const totalDuration = procedures.reduce(
      (sum, proc) => sum + proc.duration,
      0,
    );
    const finalTotalPrice = procedures.reduce(
      (sum, proc) => sum + Number(proc.price),
      0,
    );

    const finalStartTime = updateAppointmentDto.startTime
      ? new Date(updateAppointmentDto.startTime)
      : originalAppointment.startTime;

    // Respeitar endTime enviado; recalcular apenas se não fornecido
    let finalEndTime: Date;
    if (updateAppointmentDto.endTime) {
      finalEndTime = new Date(updateAppointmentDto.endTime);
    } else if (updateAppointmentDto.startTime || updateAppointmentDto.procedureIds) {
      finalEndTime = totalDuration > 0
        ? new Date(finalStartTime.getTime() + totalDuration * 60000)
        : (originalAppointment.endTime ?? new Date(finalStartTime.getTime() + 60 * 60000));
    } else {
      finalEndTime = originalAppointment.endTime ?? new Date(finalStartTime.getTime() + 60 * 60000);
    }

    const finalUserId =
      updateAppointmentDto.userId ?? originalAppointment.userId;

    await this.validateTimeConflict(
      finalUserId,
      finalStartTime,
      finalEndTime,
      id,
    );

    return this.prisma.$transaction(async (tx) => {
      const updatedAppointment = await tx.appointment.update({
        where: { id },
        data: {
          clientId:
            updateAppointmentDto.clientId !== undefined
              ? updateAppointmentDto.clientId
              : originalAppointment.clientId,
          userId: finalUserId,
          date: updateAppointmentDto.date
            ? new Date(updateAppointmentDto.date)
            : originalAppointment.date,
          startTime: finalStartTime,
          endTime: finalEndTime,
          totalPrice: finalTotalPrice || originalAppointment.totalPrice,
          status:
            updateAppointmentDto.status !== undefined
              ? updateAppointmentDto.status
              : originalAppointment.status,
          paymentMethod:
            updateAppointmentDto.paymentMethod !== undefined
              ? updateAppointmentDto.paymentMethod
              : originalAppointment.paymentMethod,
          discount:
            updateAppointmentDto.discount !== undefined
              ? updateAppointmentDto.discount
              : originalAppointment.discount,
          observations:
            updateAppointmentDto.observations !== undefined
              ? updateAppointmentDto.observations
              : originalAppointment.observations,
        },
      });

      if (updateAppointmentDto.procedureIds) {
        await tx.appointmentProcedure.deleteMany({
          where: { appointmentId: id },
        });
        if (procedures.length > 0) {
          await tx.appointmentProcedure.createMany({
            data: procedures.map((proc) => ({
              appointmentId: id,
              procedureId: proc.id,
              price: proc.price,
            })),
          });
        }
      }

      return tx.appointment.findUnique({
        where: { id },
        include: {
          client: {
            select: {
              id: true,
              name: true,
              email: true,
              phone: true,
              birthDate: true,
              address: true,
              observations: true,
              active: true,
              createdAt: true,
              updatedAt: true,
            },
          },
          user: true,
          procedures: { include: { procedure: true } },
        },
      });
    });
  }

  async updateStatus(id: string, status: AppointmentStatus) {
    const appointment = await this.findOne(id);
    if (status === 'CONCLUIDO' && appointment.status !== 'CONCLUIDO') {
      await this.consumeProducts(appointment);
      await this.createFinancialTransactionForAppointment(appointment);
    }
    return this.prisma.appointment.update({
      where: { id },
      data: { status },
    });
  }

  // NENHUMA MUDANÇA ABAIXO DESTA LINHA, MÉTODOS EXISTENTES MANTIDOS
  // ... (findAll, findOne, remove, checkAvailability, etc.)

  async findAll(startDate?: string, endDate?: string, userId?: string) {
    const where: any = {
      // Não mostrar agendamentos cancelados
      status: { not: 'CANCELADO' }
    };
    if (startDate && endDate) {
      where.date = { gte: new Date(startDate), lte: new Date(endDate) };
    }
    if (userId) {
      where.userId = userId;
    }
    return this.prisma.appointment.findMany({
      where,
      include: {
        client: { select: { name: true, phone: true } },
        user: { select: { name: true } },
        procedures: {
          include: { procedure: { select: { name: true, duration: true } } },
        },
      },
      // Ordenar do mais recente para o mais antigo
      orderBy: [{ date: 'desc' }, { startTime: 'desc' }],
    });
  }

  async findOne(id: string) {
    const appointment = await this.prisma.appointment.findUnique({
      where: { id },
      include: {
        client: {
          select: {
            id: true,
            name: true,
            email: true,
            phone: true,
            birthDate: true,
            address: true,
            observations: true,
            active: true,
            createdAt: true,
            updatedAt: true,
          },
        },
        user: { select: { id: true, name: true, email: true } },
        procedures: {
          include: {
            procedure: {
              include: { procedureProducts: { include: { product: true } } },
            },
          },
        },
        productUsages: {
          include: {
            product: true,
          },
        },
      },
    });
    if (!appointment) {
      throw new NotFoundException('Agendamento não encontrado');
    }
    return appointment;
  }

  async remove(id: string) {
    await this.findOne(id);
    return this.prisma.appointment.update({
      where: { id },
      data: { status: 'CANCELADO' },
    });
  }

  async checkAvailability(
    userId: string,
    date: string,
    startTime: string,
    duration: number,
  ) {
    const start = new Date(startTime);
    const end = new Date(start.getTime() + duration * 60000);
    const conflicts = await this.prisma.appointment.findMany({
      where: {
        userId,
        date: new Date(date),
        status: { in: ['AGENDADO', 'CONFIRMADO', 'BLOQUEADO'] },
        OR: [
          { startTime: { lte: start }, endTime: { gt: start } },
          { startTime: { lt: end }, endTime: { gte: end } },
          { startTime: { gte: start }, endTime: { lte: end } },
        ],
      },
    });
    return conflicts.length === 0;
  }

  private async validateTimeConflict(
    userId: string,
    startTime: Date,
    endTime: Date,
    excludeAppointmentId?: string,
  ) {
    const where: any = {
      userId,
      status: { in: ['AGENDADO', 'CONFIRMADO', 'BLOQUEADO'] },
      OR: [
        { startTime: { lte: startTime }, endTime: { gt: startTime } },
        { startTime: { lt: endTime }, endTime: { gte: endTime } },
        { startTime: { gte: startTime }, endTime: { lte: endTime } },
      ],
    };
    if (excludeAppointmentId) {
      where.NOT = { id: excludeAppointmentId };
    }
    const conflicts = await this.prisma.appointment.findMany({ where });
    if (conflicts.length > 0) {
      throw new ConflictException(
        'Conflito de horário detectado para este profissional.',
      );
    }
  }

  private async consumeProducts(appointment: any) {
    // NOTA: Consumo automático de produtos foi desabilitado
    // Agora os produtos são consumidos manualmente através do sistema de comandas
    // A tabela ProcedureProduct agora serve apenas para vincular produtos disponíveis
    // aos procedimentos, sem quantidade específica
    console.log(`ℹ️  Produtos para agendamento ${appointment.id} devem ser consumidos via sistema de comandas`);
  }

  private async createFinancialTransactionForAppointment(appointment: any) {
    try {
      for (const ap of appointment.procedures) {
        const procedureName = ap.procedure.name;
        const amount = Number(ap.price || 0);
        if (amount <= 0) continue;

        let category = await this.prisma.entryMoneyCategory.findUnique({
          where: { name: procedureName },
        });

        if (!category) {
          category = await this.prisma.entryMoneyCategory.create({
            data: { name: procedureName },
          });
        }

        await this.entryAnalyticsService.create({
          date: (appointment.date || new Date()).toISOString(),
          entryMoneyCategoryId: category.id,
          clientId: appointment.clientId ?? undefined,
          description: `Agendamento - ${appointment.client?.name || 'Cliente'}`,
          amount,
        });
      }
    } catch (error) {
      console.error(
        'Erro ao criar transação financeira para agendamento:',
        error,
      );
    }
  }

  // ===== FUNCIONALIDADES DE COMANDA =====

  async confirmAppointment(id: string) {
    const appointment = await this.findOne(id);

    if (appointment.status !== 'AGENDADO') {
      throw new BadRequestException('Apenas agendamentos com status AGENDADO podem ser confirmados');
    }

    // Registra 50% do valor como receita parcial no financeiro
    const partialPayment = Number(appointment.totalPrice) * 0.5;

    await this.prisma.$transaction(async (tx) => {
      // Atualiza o status para CONFIRMADO
      await tx.appointment.update({
        where: { id },
        data: {
          status: 'CONFIRMADO',
          partialPayment: partialPayment
        },
      });

      // TODO: Integrar com novo sistema financeiro de categorias
      console.log(`Entrada (50%) - ${appointment.client?.name || 'Cliente'} - Agendamento ${id.substring(0, 8)} - R$ ${partialPayment}`);
    });

    return this.findOne(id);
  }

  async openComanda(id: string) {
    const appointment = await this.findOne(id);

    if (appointment.status !== 'CONFIRMADO') {
      throw new BadRequestException('Apenas agendamentos confirmados podem ter a comanda aberta');
    }

    return this.prisma.appointment.update({
      where: { id },
      data: {
        status: 'CONFIRMADO',
        comandaOpenedAt: new Date()
      },
      include: {
        client: {
          select: {
            id: true,
            name: true,
            email: true,
            phone: true,
            birthDate: true,
            address: true,
            observations: true,
            active: true,
            createdAt: true,
            updatedAt: true,
          },
        },
        user: true,
        procedures: { include: { procedure: true } },
        productUsages: { include: { product: true } }
      }
    });
  }

  async addProductToComanda(appointmentId: string, productId: string, quantity: number) {
    const appointment = await this.findOne(appointmentId);

    if (!['AGENDADO', 'CONFIRMADO'].includes(appointment.status)) {
      throw new BadRequestException('Apenas agendamentos ativos podem receber produtos');
    }

    const product = await this.prisma.product.findUnique({ where: { id: productId } });
    if (!product) {
      throw new NotFoundException('Produto não encontrado');
    }

    // Calcula custo baseado no tipo de produto
    let quantityToUse = quantity;
    let unitCost = 0;

    if (product.type === 'USO_INTERNO' && product.unitQuantity) {
      // Para produtos por medida, verifica o estoque usando usableAmount
      const remainingAvailable = Number(product.usableAmount) || 0;
      const totalCapacity = product.stock * Number(product.unitQuantity);

      if (quantity > remainingAvailable) {
        if (remainingAvailable <= 0) {
          throw new BadRequestException(`Produto esgotado. Necessário repor estoque. Total em ${product.stock} ${product.unit} já foi usado completamente.`);
        } else {
          throw new BadRequestException(`Estoque insuficiente. Disponível: ${remainingAvailable}${product.unitMeasurement} de ${totalCapacity}${product.unitMeasurement} total`);
        }
      }

      if (product.price) {
        // Custo por unidade de medida (ex: por ml)
        unitCost = Number(product.price) / Number(product.unitQuantity);
      }
    } else {
      // Para produtos de uso interno ou venda direta
      if (quantity > product.stock) {
        throw new BadRequestException(`Estoque insuficiente. Disponível: ${product.stock} ${product.unit || 'un'}`);
      }

      if (product.price) {
        unitCost = Number(product.price);
      }
    }

    const totalCost = unitCost * quantity;

    // Registra o uso do produto
    const productUsage = await this.prisma.productUsage.create({
      data: {
        appointmentId,
        productId,
        quantityUsed: quantity,
        unitCost,
        totalCost: product.addToCost ? totalCost : 0, // Só calcula custo se marcado
      }
    });

    // Atualiza o estoque
    if (product.type === 'USO_INTERNO' && product.unitQuantity) {
      // Para produtos por medida, reduz apenas o usableAmount, não o stock
      // O stock representa quantas unidades físicas temos
      // O usableAmount representa quanto ainda pode ser usado em ML
      const currentUsable = Number(product.usableAmount) || 0;
      const newUsable = Math.max(0, currentUsable - quantity);

      await this.prisma.product.update({
        where: { id: productId },
        data: { usableAmount: newUsable }
      });

      console.log(`✓ Registrado uso de ${quantity}${product.unitMeasurement} de ${product.name}. Restam ${newUsable}${product.unitMeasurement} usáveis.`);
    } else {
      // Para produtos unitários, reduz normalmente o stock
      await this.prisma.product.update({
        where: { id: productId },
        data: { stock: Math.max(0, product.stock - quantity) }
      });
    }

    return productUsage;
  }

  async addProcedureToComanda(appointmentId: string, procedureId: string, customPrice?: number) {
    const appointment = await this.findOne(appointmentId);

    if (appointment.status === 'CANCELADO' || appointment.status === 'CONCLUIDO') {
      throw new BadRequestException('Não é possível adicionar procedimentos a agendamentos cancelados ou concluídos');
    }

    if (appointment.status === 'BLOQUEADO') {
      throw new BadRequestException('Não é possível adicionar procedimentos a agendamentos bloqueados');
    }

    const procedure = await this.prisma.procedure.findUnique({ where: { id: procedureId } });
    if (!procedure) {
      throw new NotFoundException('Procedimento não encontrado');
    }

    // Verifica se o procedimento já existe no agendamento
    const existingProcedure = await this.prisma.appointmentProcedure.findUnique({
      where: {
        appointmentId_procedureId: {
          appointmentId,
          procedureId
        }
      }
    });

    if (existingProcedure) {
      throw new BadRequestException('Procedimento já adicionado ao agendamento');
    }

    // Adiciona o procedimento ao agendamento
    const finalPrice = customPrice !== undefined ? customPrice : Number(procedure.price);

    return this.prisma.$transaction(async (tx) => {
      // Cria a relação do procedimento
      const appointmentProcedure = await tx.appointmentProcedure.create({
        data: {
          appointmentId,
          procedureId,
          price: finalPrice
        }
      });

      // Atualiza o preço total do agendamento
      const currentAppointment = await tx.appointment.findUnique({ where: { id: appointmentId } });
      if (!currentAppointment) {
        throw new Error('Appointment not found');
      }
      const newTotalPrice = Number(currentAppointment.totalPrice || 0) + finalPrice;

      await tx.appointment.update({
        where: { id: appointmentId },
        data: { totalPrice: newTotalPrice }
      });

      return appointmentProcedure;
    });
  }

  async finishComanda(appointmentId: string, finishData: {
    paymentMethod: string;
    discount?: number;
    finalPrice?: number;
  }) {
    const appointment = await this.findOne(appointmentId);

    if (appointment.status !== 'CONFIRMADO') {
      throw new BadRequestException('Apenas agendamentos confirmados podem ser finalizados');
    }

    // Busca os produtos utilizados
    const productUsages = await this.prisma.productUsage.findMany({
      where: { appointmentId },
      include: { product: true }
    });

    // Calcula taxas de cartão
    let cardTax = 0;
    let finalPrice = finishData.finalPrice || Number(appointment.totalPrice);

    if (finishData.discount) {
      finalPrice -= finishData.discount;
    }

    // Aplica taxas de cartão
    switch (finishData.paymentMethod) {
      case 'CARTAO_DEBITO':
        cardTax = 0.0279; // 2.79%
        break;
      case 'CARTAO_CREDITO_1X':
        cardTax = 0.0599; // 5.99%
        break;
      case 'CARTAO_CREDITO_2X':
        cardTax = 0.1139; // 11.39%
        break;
      case 'CARTAO_CREDITO_3X':
        cardTax = 0.1249; // 12.49%
        break;
      case 'CARTAO_CREDITO_ACIMA_3X':
        // Taxa repassada ao cliente, não desconta
        cardTax = 0;
        break;
      default:
        cardTax = 0;
    }

    const taxAmount = finalPrice * cardTax;
    const finalAmountAfterTax = finalPrice - taxAmount;

    return this.prisma.$transaction(async (tx) => {
      // Atualiza o agendamento
      const updatedAppointment = await tx.appointment.update({
        where: { id: appointmentId },
        data: {
          status: 'CONCLUIDO',
          paymentMethod: finishData.paymentMethod as any,
          discount: finishData.discount,
          finalPrice: finalAmountAfterTax,
          cardTax,
          comandaClosedAt: new Date(),
          paymentData: JSON.stringify({
            originalPrice: Number(appointment.totalPrice),
            discount: finishData.discount || 0,
            priceBeforeTax: finalPrice,
            taxRate: cardTax,
            taxAmount,
            finalAmount: finalAmountAfterTax
          })
        }
      });

      if (appointment.clientId) {
        await tx.client.update({
          where: { id: appointment.clientId },
          data: { lastAppointmentAt: new Date() },
        });
      }

      // Criar receita financeira para cada procedimento da comanda
      try {
        for (const ap of appointment.procedures) {
          const procedureName = ap.procedure.name;
          const amount = Number(ap.price || 0);
          if (amount <= 0) continue;

          let category = await tx.entryMoneyCategory.findUnique({
            where: { name: procedureName },
          });
          if (!category) {
            category = await tx.entryMoneyCategory.create({
              data: { name: procedureName },
            });
          }

          await tx.entryAnalytic.create({
            data: {
              date: appointment.date || new Date(),
              entryMoneyCategoryId: category.id,
              clientId: appointment.clientId ?? undefined,
              description: `Comanda finalizada - ${appointment.client?.name || 'Cliente'}`,
              amount,
            },
          });
        }
      } catch (error) {
        console.error('Erro ao criar entrada financeira na comanda:', error);
      }

      // Registra custos dos produtos como saídas financeiras
      const costUsages = productUsages.filter(usage => usage.product.addToCost);

      if (costUsages.length > 0) {
        try {
          let costCategory = await tx.costVariableCategory.findUnique({
            where: { name: 'Produtos Utilizados' },
          });
          if (!costCategory) {
            costCategory = await tx.costVariableCategory.create({
              data: { name: 'Produtos Utilizados' },
            });
          }

          const totalProductCosts = costUsages.reduce(
            (sum, usage) => sum + Number(usage.totalCost || 0), 0,
          );

          if (totalProductCosts > 0) {
            const productDescriptions = costUsages
              .map(usage => `${usage.product.name}: ${usage.quantityUsed}${usage.product.unitMeasurement || usage.product.unit || 'un'}`)
              .join(', ');

            await tx.outAnalytic.create({
              data: {
                date: appointment.date || new Date(),
                costVariableCategoryId: costCategory.id,
                description: `Produtos usados - ${appointment.client?.name || 'Cliente'} - ${productDescriptions}`,
                amount: totalProductCosts,
              },
            });
          }
        } catch (error) {
          console.error('Erro ao criar saída financeira de produtos:', error);
        }
      }

      // Atualiza as metas automaticamente quando a comanda é finalizada
      if (finalAmountAfterTax > 0) {
        await this.goalsService.updateGoalsForCompletedAppointment(
          finalAmountAfterTax,
          appointment.date,
        );
      }

      return updatedAppointment;
    });
  }
}
