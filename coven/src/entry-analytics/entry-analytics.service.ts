import {
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateEntryAnalyticDto } from './dto/create-entry-analytic.dto';
import { UpdateEntryAnalyticDto } from './dto/update-entry-analytic.dto';

@Injectable()
export class EntryAnalyticsService {
  constructor(private prisma: PrismaService) {}

  async create(createDto: CreateEntryAnalyticDto) {
    // Verificar se a categoria existe
    const category = await this.prisma.entryMoneyCategory.findUnique({
      where: { id: createDto.entryMoneyCategoryId },
    });

    if (!category) {
      throw new NotFoundException('Categoria de entrada não encontrada');
    }

    // Verificar se o cliente existe (se fornecido)
    if (createDto.clientId) {
      const client = await this.prisma.client.findUnique({
        where: { id: createDto.clientId },
      });

      if (!client) {
        throw new NotFoundException('Cliente não encontrado');
      }
    }

    return this.prisma.entryAnalytic.create({
      data: {
        date: new Date(createDto.date),
        entryMoneyCategoryId: createDto.entryMoneyCategoryId,
        clientId: createDto.clientId,
        description: createDto.description,
        amount: createDto.amount,
      },
      include: {
        entryMoneyCategory: true,
        client: {
          select: {
            id: true,
            name: true,
            email: true,
            phone: true,
          },
        },
      },
    });
  }

  async findAll(startDate?: string, endDate?: string, categoryId?: string) {
    const where: any = {};

    if (startDate && endDate) {
      where.date = {
        gte: new Date(startDate),
        lte: new Date(endDate),
      };
    }

    if (categoryId) {
      where.entryMoneyCategoryId = categoryId;
    }

    return this.prisma.entryAnalytic.findMany({
      where,
      include: {
        entryMoneyCategory: true,
        client: {
          select: {
            id: true,
            name: true,
            email: true,
            phone: true,
          },
        },
      },
      orderBy: { date: 'desc' },
    });
  }

  async findOne(id: string) {
    const entry = await this.prisma.entryAnalytic.findUnique({
      where: { id },
      include: {
        entryMoneyCategory: true,
        client: {
          select: {
            id: true,
            name: true,
            email: true,
            phone: true,
          },
        },
      },
    });

    if (!entry) {
      throw new NotFoundException('Entrada analítica não encontrada');
    }

    return entry;
  }

  async update(id: string, updateDto: UpdateEntryAnalyticDto) {
    await this.findOne(id);

    const data: any = {};

    if (updateDto.date) {
      data.date = new Date(updateDto.date);
    }

    if (updateDto.entryMoneyCategoryId) {
      // Verificar se a categoria existe
      const category = await this.prisma.entryMoneyCategory.findUnique({
        where: { id: updateDto.entryMoneyCategoryId },
      });

      if (!category) {
        throw new NotFoundException('Categoria de entrada não encontrada');
      }

      data.entryMoneyCategoryId = updateDto.entryMoneyCategoryId;
    }

    if (updateDto.clientId !== undefined) {
      if (updateDto.clientId) {
        const client = await this.prisma.client.findUnique({
          where: { id: updateDto.clientId },
        });

        if (!client) {
          throw new NotFoundException('Cliente não encontrado');
        }
      }
      data.clientId = updateDto.clientId;
    }

    if (updateDto.description !== undefined) {
      data.description = updateDto.description;
    }

    if (updateDto.amount !== undefined) {
      data.amount = updateDto.amount;
    }

    return this.prisma.entryAnalytic.update({
      where: { id },
      data,
      include: {
        entryMoneyCategory: true,
      },
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.entryAnalytic.delete({
      where: { id },
    });
  }
}

