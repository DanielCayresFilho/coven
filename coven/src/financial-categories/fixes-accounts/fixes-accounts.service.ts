import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateFixesAccountsCategoryDto } from './dto/create-fixes-accounts-category.dto';
import { UpdateFixesAccountsCategoryDto } from './dto/update-fixes-accounts-category.dto';

@Injectable()
export class FixesAccountsService {
  constructor(private prisma: PrismaService) {}

  async create(createDto: CreateFixesAccountsCategoryDto) {
    const existing = await this.prisma.fixesAccountsCategory.findUnique({
      where: { name: createDto.name },
    });

    if (existing) {
      throw new ConflictException('Categoria já existe');
    }

    return this.prisma.fixesAccountsCategory.create({
      data: createDto,
    });
  }

  async findAll() {
    return this.prisma.fixesAccountsCategory.findMany({
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const category = await this.prisma.fixesAccountsCategory.findUnique({
      where: { id },
    });

    if (!category) {
      throw new NotFoundException('Categoria não encontrada');
    }

    return category;
  }

  async update(id: string, updateDto: UpdateFixesAccountsCategoryDto) {
    await this.findOne(id);

    if (updateDto.name) {
      const existing = await this.prisma.fixesAccountsCategory.findFirst({
        where: {
          name: updateDto.name,
          NOT: { id },
        },
      });

      if (existing) {
        throw new ConflictException('Categoria já existe');
      }
    }

    return this.prisma.fixesAccountsCategory.update({
      where: { id },
      data: updateDto,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.fixesAccountsCategory.delete({
      where: { id },
    });
  }
}

