import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { StockMovementDto } from './dto/stock-movement.dto';

@Injectable()
export class ProductsService {
  constructor(
    private prisma: PrismaService,
  ) {}

  async create(createProductDto: CreateProductDto) {
    // Calcular usableAmount inicial se for produto de uso interno
    let usableAmount: number | null = null;
    if (
      createProductDto.type === 'USO_INTERNO' &&
      createProductDto.unitQuantity &&
      createProductDto.stock
    ) {
      usableAmount =
        Number(createProductDto.stock) * Number(createProductDto.unitQuantity);
    }

    const product = await this.prisma.product.create({
      data: {
        ...createProductDto,
        usableAmount,
      },
    });

    return product;
  }

  async findAll() {
    return this.prisma.product.findMany({
      where: { active: true },
      include: {
        stockMovements: {
          take: 5,
          orderBy: { createdAt: 'desc' }
        }
      },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const product = await this.prisma.product.findUnique({
      where: { id },
      include: {
        stockMovements: {
          orderBy: { createdAt: 'desc' },
          take: 20,
        },
      },
    });

    if (!product) {
      throw new NotFoundException('Produto não encontrado');
    }

    return product;
  }

  async update(id: string, updateProductDto: UpdateProductDto) {
    const product = await this.findOne(id);
    const { stock, ...safeData } = updateProductDto;

    if (stock !== undefined && stock !== product.stock) {
      throw new BadRequestException(
        'Use os endpoints /stock/add ou /stock/remove para alterar estoque.',
      );
    }

    const nextType = safeData.type ?? product.type;
    const nextUnitQty =
      safeData.unitQuantity !== undefined
        ? safeData.unitQuantity
        : product.unitQuantity;

    const data: Record<string, unknown> = { ...safeData };

    if (nextType === 'USO_INTERNO') {
      if (nextUnitQty) {
        data.usableAmount = Number(product.stock) * Number(nextUnitQty);
      }
    } else if (nextType === 'VENDA_DIRETA') {
      data.usableAmount = null;
      data.unitQuantity = null;
      data.unitMeasurement = null;
    }

    return this.prisma.product.update({
      where: { id },
      data,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.product.update({
      where: { id },
      data: { active: false },
    });
  }

  async addStock(id: string, stockMovementDto: StockMovementDto) {
    const product = await this.findOne(id);

    const result = await this.prisma.$transaction(async (prisma) => {
      await prisma.stockMovement.create({
        data: {
          productId: id,
          type: 'RECEITA',
          quantity: stockMovementDto.quantity,
          reason: stockMovementDto.reason,
        },
      });

      // Calcular novo usableAmount se for produto de uso interno
      const newStock = product.stock + stockMovementDto.quantity;
      let updateData: any = { stock: newStock };

      if (product.type === 'USO_INTERNO' && product.unitQuantity) {
        const additionalAmount = stockMovementDto.quantity * Number(product.unitQuantity);
        const currentUsable = Number(product.usableAmount) || 0;
        updateData.usableAmount = currentUsable + additionalAmount;
      }

      return prisma.product.update({
        where: { id },
        data: updateData,
      });
    });

    return result;
  }

  async removeStock(id: string, stockMovementDto: StockMovementDto) {
    const product = await this.findOne(id);

    if (product.stock < stockMovementDto.quantity) {
      throw new BadRequestException('Estoque insuficiente');
    }

    return this.prisma.$transaction(async (prisma) => {
      await prisma.stockMovement.create({
        data: {
          productId: id,
          type: 'DESPESA',
          quantity: stockMovementDto.quantity,
          reason: stockMovementDto.reason,
        },
      });

      const newStock = product.stock - stockMovementDto.quantity;
      const updateData: any = { stock: newStock };

      if (product.type === 'USO_INTERNO' && product.unitQuantity) {
        const removedAmount = stockMovementDto.quantity * Number(product.unitQuantity);
        const currentUsable = Number(product.usableAmount) || 0;
        updateData.usableAmount = Math.max(0, currentUsable - removedAmount);
      }

      return prisma.product.update({
        where: { id },
        data: updateData,
      });
    });
  }

  async getLowStockProducts() {
    // Prisma não suporta comparação entre campos diretamente
    // Busca todos os produtos ativos e filtra no JavaScript
    const products = await this.prisma.product.findMany({
      where: {
        active: true,
      },
      orderBy: { stock: 'asc' },
    });
    
    return products.filter(product => product.stock <= product.minStock);
  }

  // MÉTODO OBSOLETO: Consumo automático foi substituído pelo sistema de comandas
  // async consumeProductForProcedure(
  //   productId: string,
  //   quantity: number,
  //   reason: string,
  // ) {
  //   const product = await this.findOne(productId);
  //
  //   if (product.type !== 'USO_INTERNO') {
  //     throw new BadRequestException('Produto não é de uso interno');
  //   }
  //
  //   if (product.stock < quantity) {
  //     throw new BadRequestException(
  //       `Estoque insuficiente para ${product.name}`,
  //     );
  //   }
  //
  //   return this.prisma.$transaction(async (prisma) => {
  //     await prisma.stockMovement.create({
  //       data: {
  //         productId,
  //         type: 'DESPESA',
  //         quantity,
  //         reason,
  //       },
  //     });
  //
  //     return prisma.product.update({
  //       where: { id: productId },
  //       data: {
  //         stock: product.stock - quantity,
  //       },
  //     });
  //   });
  // }

}
