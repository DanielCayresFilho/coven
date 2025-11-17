import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateEntryMoneyCategoryDto } from './dto/create-entry-money-category.dto';
import { UpdateEntryMoneyCategoryDto } from './dto/update-entry-money-category.dto';

@Injectable()
export class EntryMoneyService {
  constructor(private prisma: PrismaService) {}

  async create(createDto: CreateEntryMoneyCategoryDto) {
    const existing = await this.prisma.entryMoneyCategory.findUnique({
      where: { name: createDto.name },
    });

    if (existing) {
      throw new ConflictException('Categoria já existe');
    }

    return this.prisma.entryMoneyCategory.create({
      data: createDto,
    });
  }

  async findAll() {
    return this.prisma.entryMoneyCategory.findMany({
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const category = await this.prisma.entryMoneyCategory.findUnique({
      where: { id },
    });

    if (!category) {
      throw new NotFoundException('Categoria não encontrada');
    }

    return category;
  }

  async update(id: string, updateDto: UpdateEntryMoneyCategoryDto) {
    await this.findOne(id);

    if (updateDto.name) {
      const existing = await this.prisma.entryMoneyCategory.findFirst({
        where: {
          name: updateDto.name,
          NOT: { id },
        },
      });

      if (existing) {
        throw new ConflictException('Categoria já existe');
      }
    }

    return this.prisma.entryMoneyCategory.update({
      where: { id },
      data: updateDto,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.entryMoneyCategory.delete({
      where: { id },
    });
  }
}

