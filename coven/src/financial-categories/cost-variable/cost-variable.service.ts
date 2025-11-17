import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateCostVariableCategoryDto } from './dto/create-cost-variable-category.dto';
import { UpdateCostVariableCategoryDto } from './dto/update-cost-variable-category.dto';

@Injectable()
export class CostVariableService {
  constructor(private prisma: PrismaService) {}

  async create(createDto: CreateCostVariableCategoryDto) {
    const existing = await this.prisma.costVariableCategory.findUnique({
      where: { name: createDto.name },
    });

    if (existing) {
      throw new ConflictException('Categoria já existe');
    }

    return this.prisma.costVariableCategory.create({
      data: createDto,
    });
  }

  async findAll() {
    return this.prisma.costVariableCategory.findMany({
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const category = await this.prisma.costVariableCategory.findUnique({
      where: { id },
    });

    if (!category) {
      throw new NotFoundException('Categoria não encontrada');
    }

    return category;
  }

  async update(id: string, updateDto: UpdateCostVariableCategoryDto) {
    await this.findOne(id);

    if (updateDto.name) {
      const existing = await this.prisma.costVariableCategory.findFirst({
        where: {
          name: updateDto.name,
          NOT: { id },
        },
      });

      if (existing) {
        throw new ConflictException('Categoria já existe');
      }
    }

    return this.prisma.costVariableCategory.update({
      where: { id },
      data: updateDto,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.costVariableCategory.delete({
      where: { id },
    });
  }
}

