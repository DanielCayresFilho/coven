import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateTransactionDto } from './dto/create-transaction.dto';
import { UpdateTransactionDto } from './dto/update-transaction.dto';

@Injectable()
export class FinancialService {
  constructor(private prisma: PrismaService) {}

  async create(createTransactionDto: CreateTransactionDto) {
    return this.prisma.financialTransaction.create({
      data: createTransactionDto,
    });
  }

  async findAll(startDate?: string, endDate?: string, type?: string, category?: string) {
    const where: any = {};

    if (startDate && endDate) {
      where.date = {
        gte: new Date(startDate),
        lte: new Date(endDate),
      };
    }

    if (type) {
      where.type = type;
    }

    if (category) {
      where.category = category;
    }

    return this.prisma.financialTransaction.findMany({
      where,
      orderBy: { date: 'desc' },
    });
  }

  async findOne(id: string) {
    const transaction = await this.prisma.financialTransaction.findUnique({
      where: { id },
    });

    if (!transaction) {
      throw new NotFoundException('Transação não encontrada');
    }

    return transaction;
  }

  async update(id: string, updateTransactionDto: UpdateTransactionDto) {
    await this.findOne(id);

    return this.prisma.financialTransaction.update({
      where: { id },
      data: updateTransactionDto,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.financialTransaction.delete({
      where: { id },
    });
  }

  async getDashboard(startDate: string, endDate: string) {
    const start = new Date(startDate);
    const end = new Date(endDate);

    const [transactions, appointments] = await Promise.all([
      this.prisma.financialTransaction.findMany({
        where: {
          date: { gte: start, lte: end },
        },
      }),
      this.prisma.appointment.findMany({
        where: {
          date: { gte: start, lte: end },
          status: 'CONCLUIDO',
        },
        include: {
          procedures: {
            include: { procedure: true },
          },
        },
      }),
    ]);

    // Agrupar receitas por categoria
    const receitasAtendimentos = transactions
      .filter((t) => t.type === 'RECEITA' && t.category === 'Atendimentos')
      .reduce((sum, t) => sum + parseFloat(t.amount.toString()), 0);

    const receitasVendas = transactions
      .filter((t) => t.type === 'RECEITA' && t.category === 'Vendas')
      .reduce((sum, t) => sum + parseFloat(t.amount.toString()), 0);

    const receitasOutras = transactions
      .filter((t) => t.type === 'RECEITA' && t.category !== 'Atendimentos' && t.category !== 'Vendas')
      .reduce((sum, t) => sum + parseFloat(t.amount.toString()), 0);

    // Agrupar despesas por categoria
    const despesasUsoInterno = transactions
      .filter((t) => t.type === 'DESPESA' && t.category === 'Uso Interno')
      .reduce((sum, t) => sum + parseFloat(t.amount.toString()), 0);

    const despesasOutras = transactions
      .filter((t) => t.type === 'DESPESA' && t.category !== 'Uso Interno')
      .reduce((sum, t) => sum + parseFloat(t.amount.toString()), 0);

    const totalReceitas = receitasAtendimentos + receitasVendas + receitasOutras;
    const totalDespesas = despesasUsoInterno + despesasOutras;
    const lucroLiquido = totalReceitas - totalDespesas;

    return {
      periodo: { inicio: start, fim: end },
      receitas: {
        atendimentos: receitasAtendimentos,
        vendas: receitasVendas,
        outras: receitasOutras,
        total: totalReceitas,
      },
      despesas: {
        usoInterno: despesasUsoInterno,
        outras: despesasOutras,
        total: totalDespesas,
      },
      lucro: {
        bruto: receitasAtendimentos + receitasVendas,
        liquido: lucroLiquido,
      },
      agendamentos: {
        total: appointments.length,
        valor_medio:
          appointments.length > 0
            ? receitasAtendimentos / appointments.length
            : 0,
      },
    };
  }

  async getOverdueTransactions() {
    const today = new Date();

    return this.prisma.financialTransaction.findMany({
      where: {
        type: 'DESPESA',
        isPaid: false,
        dueDate: {
          lt: today,
        },
      },
      orderBy: { dueDate: 'asc' },
    });
  }

  async markAsPaid(id: string) {
    await this.findOne(id);

    return this.prisma.financialTransaction.update({
      where: { id },
      data: { isPaid: true },
    });
  }
}
