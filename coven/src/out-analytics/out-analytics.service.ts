import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateOutAnalyticDto } from './dto/create-out-analytic.dto';
import { UpdateOutAnalyticDto } from './dto/update-out-analytic.dto';

@Injectable()
export class OutAnalyticsService {
  constructor(private prisma: PrismaService) {}

  private validateCategoryIds(dto: CreateOutAnalyticDto | UpdateOutAnalyticDto) {
    const categories = [
      dto.costVariableCategoryId,
      dto.fixesAccountsCategoryId,
      dto.investmentsCategoryId,
    ].filter(Boolean);

    if (categories.length === 0) {
      throw new BadRequestException('É necessário informar uma categoria de saída');
    }

    if (categories.length > 1) {
      throw new BadRequestException('Apenas uma categoria de saída deve ser informada');
    }
  }

  async create(createDto: CreateOutAnalyticDto) {
    this.validateCategoryIds(createDto);

    // Verificar se a categoria existe
    if (createDto.costVariableCategoryId) {
      const category = await this.prisma.costVariableCategory.findUnique({
        where: { id: createDto.costVariableCategoryId },
      });
      if (!category) {
        throw new NotFoundException('Categoria de custo variável não encontrada');
      }
    }

    if (createDto.fixesAccountsCategoryId) {
      const category = await this.prisma.fixesAccountsCategory.findUnique({
        where: { id: createDto.fixesAccountsCategoryId },
      });
      if (!category) {
        throw new NotFoundException('Categoria de contas fixas não encontrada');
      }
    }

    if (createDto.investmentsCategoryId) {
      const category = await this.prisma.investmentsCategory.findUnique({
        where: { id: createDto.investmentsCategoryId },
      });
      if (!category) {
        throw new NotFoundException('Categoria de investimentos não encontrada');
      }
    }

    return this.prisma.outAnalytic.create({
      data: {
        date: new Date(createDto.date),
        description: createDto.description,
        amount: createDto.amount,
        costVariableCategoryId: createDto.costVariableCategoryId,
        fixesAccountsCategoryId: createDto.fixesAccountsCategoryId,
        investmentsCategoryId: createDto.investmentsCategoryId,
      },
      include: {
        costVariableCategory: true,
        fixesAccountsCategory: true,
        investmentsCategory: true,
      },
    });
  }

  async findAll(startDate?: string, endDate?: string, categoryId?: string, categoryType?: string) {
    const where: any = {};

    if (startDate && endDate) {
      where.date = {
        gte: new Date(startDate),
        lte: new Date(endDate),
      };
    }

    if (categoryId && categoryType) {
      switch (categoryType) {
        case 'costVariable':
          where.costVariableCategoryId = categoryId;
          break;
        case 'fixesAccounts':
          where.fixesAccountsCategoryId = categoryId;
          break;
        case 'investments':
          where.investmentsCategoryId = categoryId;
          break;
      }
    }

    return this.prisma.outAnalytic.findMany({
      where,
      include: {
        costVariableCategory: true,
        fixesAccountsCategory: true,
        investmentsCategory: true,
      },
      orderBy: { date: 'desc' },
    });
  }

  async findOne(id: string) {
    const out = await this.prisma.outAnalytic.findUnique({
      where: { id },
      include: {
        costVariableCategory: true,
        fixesAccountsCategory: true,
        investmentsCategory: true,
      },
    });

    if (!out) {
      throw new NotFoundException('Saída analítica não encontrada');
    }

    return out;
  }

  async update(id: string, updateDto: UpdateOutAnalyticDto) {
    await this.findOne(id);

    // Se está atualizando as categorias, validar
    if (updateDto.costVariableCategoryId || updateDto.fixesAccountsCategoryId || updateDto.investmentsCategoryId) {
      this.validateCategoryIds(updateDto);
    }

    const data: any = {};

    if (updateDto.date) {
      data.date = new Date(updateDto.date);
    }

    if (updateDto.description !== undefined) {
      data.description = updateDto.description;
    }

    if (updateDto.amount !== undefined) {
      data.amount = updateDto.amount;
    }

    // Verificar e atualizar categorias
    if (updateDto.costVariableCategoryId) {
      const category = await this.prisma.costVariableCategory.findUnique({
        where: { id: updateDto.costVariableCategoryId },
      });
      if (!category) {
        throw new NotFoundException('Categoria de custo variável não encontrada');
      }
      data.costVariableCategoryId = updateDto.costVariableCategoryId;
      data.fixesAccountsCategoryId = null;
      data.investmentsCategoryId = null;
    }

    if (updateDto.fixesAccountsCategoryId) {
      const category = await this.prisma.fixesAccountsCategory.findUnique({
        where: { id: updateDto.fixesAccountsCategoryId },
      });
      if (!category) {
        throw new NotFoundException('Categoria de contas fixas não encontrada');
      }
      data.fixesAccountsCategoryId = updateDto.fixesAccountsCategoryId;
      data.costVariableCategoryId = null;
      data.investmentsCategoryId = null;
    }

    if (updateDto.investmentsCategoryId) {
      const category = await this.prisma.investmentsCategory.findUnique({
        where: { id: updateDto.investmentsCategoryId },
      });
      if (!category) {
        throw new NotFoundException('Categoria de investimentos não encontrada');
      }
      data.investmentsCategoryId = updateDto.investmentsCategoryId;
      data.costVariableCategoryId = null;
      data.fixesAccountsCategoryId = null;
    }

    return this.prisma.outAnalytic.update({
      where: { id },
      data,
      include: {
        costVariableCategory: true,
        fixesAccountsCategory: true,
        investmentsCategory: true,
      },
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.outAnalytic.delete({
      where: { id },
    });
  }
}

