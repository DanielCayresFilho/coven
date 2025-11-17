import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCashFlowConfigDto } from './dto/create-cash-flow-config.dto';
import { UpdateCashFlowConfigDto } from './dto/update-cash-flow-config.dto';

@Injectable()
export class CashFlowService {
  constructor(private prisma: PrismaService) {}

  async create(createDto: CreateCashFlowConfigDto) {
    const existing = await this.prisma.cashFlowConfig.findFirst({
      where: {
        year: createDto.year,
        month: createDto.month,
      },
    });

    if (existing) {
      throw new ConflictException('Configuração já existe para este mês/ano');
    }

    return this.prisma.cashFlowConfig.create({
      data: {
        year: createDto.year,
        month: createDto.month,
        initialBalance: createDto.initialBalance,
        prolabore: createDto.prolabore || 0,
      },
    });
  }

  async findAll(year?: number) {
    const where: any = {};
    if (year) {
      where.year = year;
    }

    return this.prisma.cashFlowConfig.findMany({
      where,
      orderBy: [{ year: 'desc' }, { month: 'asc' }],
    });
  }

  async findOne(id: string) {
    const config = await this.prisma.cashFlowConfig.findUnique({
      where: { id },
    });

    if (!config) {
      throw new NotFoundException('Configuração não encontrada');
    }

    return config;
  }

  async findByMonthYear(year: number, month: number) {
    return this.prisma.cashFlowConfig.findFirst({
      where: {
        year,
        month,
      },
    });
  }

  async update(id: string, updateDto: UpdateCashFlowConfigDto) {
    await this.findOne(id);

    const data: any = {};

    if (updateDto.initialBalance !== undefined) {
      data.initialBalance = updateDto.initialBalance;
    }

    if (updateDto.prolabore !== undefined) {
      data.prolabore = updateDto.prolabore;
    }

    return this.prisma.cashFlowConfig.update({
      where: { id },
      data,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.cashFlowConfig.delete({
      where: { id },
    });
  }

  // Método principal para calcular o fluxo de caixa completo
  async getCashFlow(year: number) {
    // Buscar configurações do ano
    const configs = await this.prisma.cashFlowConfig.findMany({
      where: { year },
      orderBy: { month: 'asc' },
    });

    // Buscar todas as entradas do ano
    const startDate = new Date(year, 0, 1);
    const endDate = new Date(year, 11, 31, 23, 59, 59);

    const [entries, outs, entryCategories, costVariableCategories, fixesAccountsCategories, investmentsCategories] = await Promise.all([
      // Entradas analíticas
      this.prisma.entryAnalytic.findMany({
        where: {
          date: {
            gte: startDate,
            lte: endDate,
          },
        },
        include: {
          entryMoneyCategory: true,
        },
      }),
      // Saídas analíticas
      this.prisma.outAnalytic.findMany({
        where: {
          date: {
            gte: startDate,
            lte: endDate,
          },
        },
        include: {
          costVariableCategory: true,
          fixesAccountsCategory: true,
          investmentsCategory: true,
        },
      }),
      // Categorias de entrada
      this.prisma.entryMoneyCategory.findMany({
        orderBy: { name: 'asc' },
      }),
      // Categorias de custos variáveis
      this.prisma.costVariableCategory.findMany({
        orderBy: { name: 'asc' },
      }),
      // Categorias de contas fixas
      this.prisma.fixesAccountsCategory.findMany({
        orderBy: { name: 'asc' },
      }),
      // Categorias de investimentos
      this.prisma.investmentsCategory.findMany({
        orderBy: { name: 'asc' },
      }),
    ]);

    // Estrutura do resultado
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];

    const result: any = {
      year,
      months: [],
      categories: {
        entries: [],
        outs: {
          costVariable: [],
          fixesAccounts: [],
          investments: [],
        },
      },
      totals: {
        entries: 0,
        outs: {
          costVariable: 0,
          fixesAccounts: 0,
          investments: 0,
          total: 0,
        },
        prolabore: 0,
        profit: 0,
        profitMargin: 0,
        finalBalance: 0,
      },
    };

    // Processar cada mês
    for (let month = 0; month < 12; month++) {
      const monthNumber = month + 1;
      const monthStart = new Date(year, month, 1);
      const monthEnd = new Date(year, month + 1, 0, 23, 59, 59);

      // Configuração do mês
      const config = configs.find(c => c.month === monthNumber);
      const initialBalance = config ? Number(config.initialBalance) : 0;
      const prolabore = config ? Number(config.prolabore || 0) : 0;

      // Filtrar entradas do mês
      const monthEntries = entries.filter(e => {
        const entryDate = new Date(e.date);
        return entryDate >= monthStart && entryDate <= monthEnd;
      });

      // Filtrar saídas do mês
      const monthOuts = outs.filter(o => {
        const outDate = new Date(o.date);
        return outDate >= monthStart && outDate <= monthEnd;
      });

      // Calcular totais por categoria de entrada
      const entriesByCategory: Record<string, number> = {};
      entryCategories.forEach(cat => {
        entriesByCategory[cat.id] = monthEntries
          .filter(e => e.entryMoneyCategoryId === cat.id)
          .reduce((sum, e) => sum + Number(e.amount), 0);
      });

      // Calcular totais por categoria de saída
      const costVariableByCategory: Record<string, number> = {};
      costVariableCategories.forEach(cat => {
        costVariableByCategory[cat.id] = monthOuts
          .filter(o => o.costVariableCategoryId === cat.id)
          .reduce((sum, o) => sum + Number(o.amount), 0);
      });

      const fixesAccountsByCategory: Record<string, number> = {};
      fixesAccountsCategories.forEach(cat => {
        fixesAccountsByCategory[cat.id] = monthOuts
          .filter(o => o.fixesAccountsCategoryId === cat.id)
          .reduce((sum, o) => sum + Number(o.amount), 0);
      });

      const investmentsByCategory: Record<string, number> = {};
      investmentsCategories.forEach(cat => {
        investmentsByCategory[cat.id] = monthOuts
          .filter(o => o.investmentsCategoryId === cat.id)
          .reduce((sum, o) => sum + Number(o.amount), 0);
      });

      // Totais do mês
      const totalEntries = monthEntries.reduce((sum, e) => sum + Number(e.amount), 0);
      const totalCostVariable = monthOuts
        .filter(o => o.costVariableCategoryId)
        .reduce((sum, o) => sum + Number(o.amount), 0);
      const totalFixesAccounts = monthOuts
        .filter(o => o.fixesAccountsCategoryId)
        .reduce((sum, o) => sum + Number(o.amount), 0);
      const totalInvestments = monthOuts
        .filter(o => o.investmentsCategoryId)
        .reduce((sum, o) => sum + Number(o.amount), 0);
      const totalOuts = totalCostVariable + totalFixesAccounts + totalInvestments;
      const profit = totalEntries - totalOuts;
      const profitMargin = totalEntries > 0 ? (profit / totalEntries) * 100 : 0;
      const finalBalance = initialBalance + totalEntries - totalOuts - prolabore;

      result.months.push({
        month: monthNumber,
        monthName: months[month],
        initialBalance,
        entries: {
          byCategory: entriesByCategory,
          total: totalEntries,
        },
        outs: {
          costVariable: {
            byCategory: costVariableByCategory,
            total: totalCostVariable,
          },
          fixesAccounts: {
            byCategory: fixesAccountsByCategory,
            total: totalFixesAccounts,
          },
          investments: {
            byCategory: investmentsByCategory,
            total: totalInvestments,
          },
          total: totalOuts,
        },
        prolabore,
        profit,
        profitMargin,
        finalBalance,
      });

      // Acumular totais gerais
      result.totals.entries += totalEntries;
      result.totals.outs.costVariable += totalCostVariable;
      result.totals.outs.fixesAccounts += totalFixesAccounts;
      result.totals.outs.investments += totalInvestments;
      result.totals.outs.total += totalOuts;
      result.totals.prolabore += prolabore;
    }

    // Calcular totais finais
    result.totals.profit = result.totals.entries - result.totals.outs.total;
    result.totals.profitMargin = result.totals.entries > 0 
      ? (result.totals.profit / result.totals.entries) * 100 
      : 0;

    // Adicionar informações das categorias
    result.categories.entries = entryCategories.map(cat => ({
      id: cat.id,
      name: cat.name,
    }));

    result.categories.outs.costVariable = costVariableCategories.map(cat => ({
      id: cat.id,
      name: cat.name,
    }));

    result.categories.outs.fixesAccounts = fixesAccountsCategories.map(cat => ({
      id: cat.id,
      name: cat.name,
    }));

    result.categories.outs.investments = investmentsCategories.map(cat => ({
      id: cat.id,
      name: cat.name,
    }));

    return result;
  }
}

