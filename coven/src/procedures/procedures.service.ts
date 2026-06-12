import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateProcedureDto } from './dto/create-procedure.dto';
import { UpdateProcedureDto } from './dto/update-procedure.dto';

@Injectable()
export class ProceduresService {
  constructor(private prisma: PrismaService) {}

  async create(createProcedureDto: CreateProcedureDto) {
    const procedure = await this.prisma.procedure.create({
      data: createProcedureDto,
    });

    // Sincronizar com EntryMoneyCategory
    await this.syncProcedureToEntryMoneyCategory(procedure.id, procedure.name);

    return procedure;
  }

  async findAll() {
    return this.prisma.procedure.findMany({
      where: { active: true },
      include: {
        procedureProducts: {
          include: {
            product: true,
          },
        },
      },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const procedure = await this.prisma.procedure.findUnique({
      where: { id },
      include: {
        procedureProducts: {
          include: {
            product: true,
          },
        },
        appointmentProcedures: {
          include: {
            appointment: {
              include: {
                client: { select: { name: true } },
                user: { select: { name: true } },
              },
            },
          },
          orderBy: { appointment: { date: 'desc' } },
          take: 10,
        },
      },
    });

    if (!procedure) {
      throw new NotFoundException('Procedimento não encontrado');
    }

    return procedure;
  }

  async update(id: string, updateProcedureDto: UpdateProcedureDto) {
    const procedure = await this.findOne(id);

    const updated = await this.prisma.procedure.update({
      where: { id },
      data: updateProcedureDto,
    });

    // Sincronizar com EntryMoneyCategory se o nome mudou
    if (updateProcedureDto.name && updateProcedureDto.name !== procedure.name) {
      await this.syncProcedureToEntryMoneyCategory(updated.id, updated.name);
    }

    return updated;
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.procedure.update({
      where: { id },
      data: { active: false },
    });
  }

  async addProduct(procedureId: string, productId: string) {
    await this.findOne(procedureId);

    const product = await this.prisma.product.findFirst({
      where: { id: productId, active: true },
    });

    if (!product) {
      throw new NotFoundException('Produto não encontrado');
    }

    if (product.type !== 'USO_INTERNO') {
      throw new BadRequestException(
        'Apenas produtos de uso interno podem ser vinculados a procedimentos',
      );
    }

    return this.prisma.procedureProduct.upsert({
      where: {
        procedureId_productId: {
          procedureId,
          productId,
        },
      },
      update: {},
      create: {
        procedureId,
        productId,
      },
    });
  }

  async removeProduct(procedureId: string, productId: string) {
    try {
      return await this.prisma.procedureProduct.delete({
        where: {
          procedureId_productId: {
            procedureId,
            productId,
          },
        },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2025'
      ) {
        throw new NotFoundException(
          'Vínculo procedimento-produto não encontrado',
        );
      }
      throw error;
    }
  }

  // Sincroniza um procedimento com EntryMoneyCategory
  private async syncProcedureToEntryMoneyCategory(procedureId: string, procedureName: string) {
    // Verifica se já existe uma categoria com esse nome
    const existing = await this.prisma.entryMoneyCategory.findUnique({
      where: { name: procedureName },
    });

    if (!existing) {
      // Cria a categoria se não existir
      await this.prisma.entryMoneyCategory.create({
        data: { name: procedureName },
      });
    }
  }

  // Sincroniza todos os procedimentos ativos com EntryMoneyCategory
  async syncAllProceduresToEntryMoney() {
    const procedures = await this.prisma.procedure.findMany({
      where: { active: true },
    });

    for (const procedure of procedures) {
      await this.syncProcedureToEntryMoneyCategory(procedure.id, procedure.name);
    }

    return { synced: procedures.length };
  }
}
