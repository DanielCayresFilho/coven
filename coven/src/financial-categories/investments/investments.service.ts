import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateInvestmentsCategoryDto } from './dto/create-investments-category.dto';
import { UpdateInvestmentsCategoryDto } from './dto/update-investments-category.dto';

@Injectable()
export class InvestmentsService {
  constructor(private prisma: PrismaService) {}

  async create(createDto: CreateInvestmentsCategoryDto) {
    const existing = await this.prisma.investmentsCategory.findUnique({
      where: { name: createDto.name },
    });

    if (existing) {
      throw new ConflictException('Categoria já existe');
    }

    return this.prisma.investmentsCategory.create({
      data: createDto,
    });
  }

  async findAll() {
    return this.prisma.investmentsCategory.findMany({
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const category = await this.prisma.investmentsCategory.findUnique({
      where: { id },
    });

    if (!category) {
      throw new NotFoundException('Categoria não encontrada');
    }

    return category;
  }

  async update(id: string, updateDto: UpdateInvestmentsCategoryDto) {
    await this.findOne(id);

    if (updateDto.name) {
      const existing = await this.prisma.investmentsCategory.findFirst({
        where: {
          name: updateDto.name,
          NOT: { id },
        },
      });

      if (existing) {
        throw new ConflictException('Categoria já existe');
      }
    }

    return this.prisma.investmentsCategory.update({
      where: { id },
      data: updateDto,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.investmentsCategory.delete({
      where: { id },
    });
  }
}

