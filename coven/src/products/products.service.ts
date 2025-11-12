import {
  Injectable,
  NotFoundException,
  BadRequestException,
  Inject,
  forwardRef,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { FinancialService } from '../financial/financial.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { StockMovementDto } from './dto/stock-movement.dto';

@Injectable()
export class ProductsService {
  constructor(
    private prisma: PrismaService,
    @Inject(forwardRef(() => FinancialService))
    private financialService: FinancialService,
  ) {
    console.log(
      '🔧 ProductsService initialized with FinancialService:',
      !!this.financialService,
    );
  }

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

    // Se o produto tem estoque inicial e preço, criar transação financeira automaticamente
    if (product.stock > 0 && product.price && Number(product.price) > 0 && product.addToCost) {
      console.log('💰 Criando despesa automática para produto criado:', product.name);
      await this.createFinancialTransactionForProductCreation(product);
    }

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
    await this.findOne(id);

    return this.prisma.product.update({
      where: { id },
      data: updateProductDto,
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
    console.log(
      '📦 AddStock chamado para produto:',
      id,
      'quantidade:',
      stockMovementDto.quantity,
    );
    const product = await this.findOne(id);
    console.log(
      '📦 Produto encontrado:',
      product.name,
      'preço:',
      product.price,
    );

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
        console.log(`📦 Atualizando usableAmount: ${currentUsable} + ${additionalAmount} = ${updateData.usableAmount}`);
      }

      return prisma.product.update({
        where: { id },
        data: updateData,
      });
    });

    // Criar transação financeira de despesa para compra de produto
    console.log('💰 Iniciando criação de transação financeira...');
    console.log('💰 Produto:', product.name, 'preço:', product.price, 'addToCost:', product.addToCost);
    
    if (product.addToCost) {
      await this.createFinancialTransactionForStockAddition(
        product,
        stockMovementDto,
      );
      console.log('💰 Transação financeira processada.');
    } else {
      console.log('💰 Produto não marcado como custo - transação não criada.');
    }

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

      return prisma.product.update({
        where: { id },
        data: {
          stock: product.stock - stockMovementDto.quantity,
        },
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

  private async createFinancialTransactionForStockAddition(
    product: any,
    stockMovementDto: StockMovementDto,
  ) {
    try {
      console.log('🔍 Verificando FinancialService:', !!this.financialService);

      if (!this.financialService) {
        console.error('❌ FinancialService não está disponível!');
        return;
      }

      // Calcular o valor total baseado no preço do produto e quantidade
      let totalAmount = 0;
      let description = '';

      if (product.price && Number(product.price) > 0) {
        totalAmount = Number(product.price) * stockMovementDto.quantity;
        description = `Despesa - Compra de estoque - Produto: ${product.name} - Quantidade: ${stockMovementDto.quantity}${product.unit ? ` ${product.unit}` : ''} - ${stockMovementDto.reason || 'Reposição de estoque'} - Valor unitário: R$ ${Number(product.price).toFixed(2)}`;
        console.log(
          `💰 Criando despesa automática: ${product.name} - R$ ${totalAmount.toFixed(2)}`,
        );
      } else {
        // Mesmo sem preço, criar registro para controle
        description = `Despesa - Compra de estoque - Produto: ${product.name} - Quantidade: ${stockMovementDto.quantity}${product.unit ? ` ${product.unit}` : ''} - ${stockMovementDto.reason || 'Reposição de estoque'} - ATENÇÃO: Produto sem preço definido, valor a definir`;
        console.log(
          `⚠️ Criando despesa com valor 0 - Produto ${product.name} sem preço definido`,
        );
      }

      console.log('💾 Chamando financialService.create com:', {
        type: 'DESPESA',
        category: 'Produtos/Estoque',
        amount: totalAmount,
        isPaid: totalAmount > 0,
      });

      const transaction = await this.financialService.create({
        type: 'DESPESA',
        category: 'Uso Interno',
        description,
        amount: totalAmount,
        date: new Date().toISOString(),
        isPaid: totalAmount > 0, // Só marca como pago se tem valor
        recurrent: false,
      });

      console.log(
        `✅ Transação financeira criada com sucesso: ID ${transaction.id}`,
      );
      return transaction;
    } catch (error) {
      console.error(
        '❌ Erro ao criar transação financeira para adição de estoque:',
        error,
      );
      console.error('Detalhes do erro:', error.message);
      console.error('Stack trace:', error.stack);
      // Não queremos que falhe a adição de estoque por causa de erro financeiro
    }
  }

  private async createFinancialTransactionForProductCreation(product: any) {
    try {
      console.log('🔍 Verificando FinancialService para criação de produto:', !!this.financialService);

      if (!this.financialService) {
        console.error('❌ FinancialService não está disponível para criação de produto!');
        return;
      }

      // Calcular o valor total baseado no preço do produto e estoque inicial
      const totalAmount = Number(product.price) * product.stock;
      const description = `Despesa - Estoque inicial - Produto: ${product.name} - Quantidade: ${product.stock}${product.unit ? ` ${product.unit}` : ''} - Valor unitário: R$ ${Number(product.price).toFixed(2)}`;
      
      console.log(`💰 Criando despesa automática na criação: ${product.name} - R$ ${totalAmount.toFixed(2)}`);

      console.log('💾 Chamando financialService.create para produto criado com:', {
        type: 'DESPESA',
        category: 'Produtos/Estoque',
        amount: totalAmount,
        isPaid: true,
      });

      const transaction = await this.financialService.create({
        type: 'DESPESA',
        category: 'Uso Interno',
        description,
        amount: totalAmount,
        date: new Date().toISOString(),
        isPaid: true, // Considera como pago (estoque já foi adquirido)
        recurrent: false,
      });

      console.log(
        `✅ Transação financeira criada para produto novo: ID ${transaction.id}`,
      );
      return transaction;
    } catch (error) {
      console.error(
        '❌ Erro ao criar transação financeira para produto criado:',
        error,
      );
      console.error('Detalhes do erro:', error.message);
      console.error('Stack trace:', error.stack);
      // Não queremos que falhe a criação do produto por causa de erro financeiro
    }
  }
}
