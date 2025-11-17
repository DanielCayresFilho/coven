import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding database...');

  // Criar usuários
  const hashedPasswordJuliana = await bcrypt.hash('Jd2409', 10);
  
  // Usuário Administrador
  const adminUser = await prisma.user.upsert({
    where: { username: 'juliana.admin' },
    update: {},
    create: {
      username: 'juliana.admin',
      password: hashedPasswordJuliana,
      name: 'Juliana Marques',
      email: 'juliana.admin@covenos.com.br',
      role: 'ADMIN',
    },
  });

  console.log('Usuário administrador criado:', adminUser);

  // Usuário Cabeleireiro
  const hairdresserUser = await prisma.user.upsert({
    where: { username: 'juliana.cabeleireiro' },
    update: {},
    create: {
      username: 'juliana.cabeleireiro',
      password: hashedPasswordJuliana,
      name: 'Juliana Marques',
      email: 'juliana.cabeleireiro@covenos.com.br',
      role: 'CABELEIREIRO',
    },
  });

  console.log('Usuário cabeleireiro criado:', hairdresserUser);

  // Criar alguns procedimentos básicos
  const procedures = [
    {
      name: 'Corte Feminino',
      description: 'Corte de cabelo feminino estilo gótico',
      category: 'Cortes',
      duration: 60,
      price: 80.00,
    },
    {
      name: 'Coloração',
      description: 'Coloração inspirada em tons sombrios',
      category: 'Química',
      duration: 180,
      price: 150.00,
    },
    {
      name: 'Escova Progressiva',
      description: 'Alisamento com produtos naturais',
      category: 'Química',
      duration: 240,
      price: 200.00,
    },
    {
      name: 'Hidratação',
      description: 'Tratamento capilar nutritivo',
      category: 'Tratamentos',
      duration: 90,
      price: 60.00,
    },
    {
      name: 'Corte Masculino',
      description: 'Corte de cabelo masculino',
      category: 'Cortes',
      duration: 45,
      price: 50.00,
    },
  ];

  for (const procedure of procedures) {
    const existing = await prisma.procedure.findFirst({
      where: { name: procedure.name }
    });
    
    if (!existing) {
      await prisma.procedure.create({
        data: procedure,
      });
    }
  }

  console.log('Procedimentos básicos criados');

  // Criar alguns produtos de exemplo
  const products = [
    {
      name: 'Shampoo Hidratante',
      description: 'Shampoo para cabelos ressecados',
      category: 'Higiene',
      type: 'USO_INTERNO' as const,
      stock: 3,
      minStock: 1,
      unit: 'un',
      unitQuantity: 1000,
      unitMeasurement: 'ml',
      price: 25.00,
      addToCost: true,
    },
    {
      name: 'Condicionador Reparador',
      description: 'Condicionador para cabelos danificados',
      category: 'Higiene',
      type: 'USO_INTERNO' as const,
      stock: 2,
      minStock: 1,
      unit: 'un',
      unitQuantity: 1000,
      unitMeasurement: 'ml',
      price: 30.00,
      addToCost: true,
    },
    {
      name: 'Máscara Capilar Dark',
      description: 'Máscara intensiva para cabelos góticos',
      category: 'Tratamentos',
      type: 'VENDA_DIRETA' as const,
      price: 45.00,
      stock: 20,
      minStock: 5,
      unit: 'un',
      addToCost: false,
    },
    {
      name: 'Óleo Capilar Gothic',
      description: 'Óleo finalizador com essência sombria',
      category: 'Finalizadores',
      type: 'VENDA_DIRETA' as const,
      price: 35.00,
      stock: 15,
      minStock: 3,
      unit: 'un',
      addToCost: false,
    },
    {
      name: 'Tinta Preta Intensa',
      description: 'Coloração permanente preta profunda',
      category: 'Coloração',
      type: 'USO_INTERNO' as const,
      stock: 5,
      minStock: 2,
      unit: 'un',
      unitQuantity: 60,
      unitMeasurement: 'g',
      price: 15.00,
      addToCost: true,
    },
  ];

  for (const product of products) {
    const existing = await prisma.product.findFirst({
      where: { name: product.name }
    });
    
    if (!existing) {
      await prisma.product.create({
        data: product,
      });
    }
  }

  console.log('Produtos básicos criados');

  // Criar alguns clientes de exemplo
  const clients = [
    {
      name: 'Ana Silva',
      email: 'ana.silva@example.com',
      phone: '(11) 99999-0001',
      birthDate: new Date('1990-03-15'),
      address: 'Rua das Sombras, 123',
      observations: 'Prefere tons escuros',
    },
    {
      name: 'Carlos Dark',
      email: 'carlos.dark@example.com',
      phone: '(11) 99999-0002',
      birthDate: new Date('1985-10-31'),
      address: 'Avenida Gótica, 456',
      observations: 'Cliente VIP, sempre pede coloração',
    },
    {
      name: 'Luna Morena',
      email: 'luna.morena@example.com',
      phone: '(11) 99999-0003',
      birthDate: new Date('1995-12-21'),
      address: 'Travessa Misteriosa, 789',
      observations: 'Cabelo cacheado, cuidados especiais',
    },
  ];

  for (const client of clients) {
    const existing = await prisma.client.findFirst({
      where: { name: client.name }
    });
    
    if (!existing) {
      await prisma.client.create({
        data: client,
      });
    }
  }

  console.log('Clientes de exemplo criados');

  // Vincular produtos aos procedimentos
  const procedureProductLinks = [
    // Coloração usa Shampoo + Condicionador + Tinta
    { procedureName: 'Coloração', productName: 'Shampoo Hidratante' },
    { procedureName: 'Coloração', productName: 'Condicionador Reparador' },
    { procedureName: 'Coloração', productName: 'Tinta Preta Intensa' },
    
    // Hidratação usa Shampoo + Máscara
    { procedureName: 'Hidratação', productName: 'Shampoo Hidratante' },
    { procedureName: 'Hidratação', productName: 'Máscara Capilar Dark' },
    
    // Escova Progressiva usa todos os produtos
    { procedureName: 'Escova Progressiva', productName: 'Shampoo Hidratante' },
    { procedureName: 'Escova Progressiva', productName: 'Condicionador Reparador' },
    { procedureName: 'Escova Progressiva', productName: 'Óleo Capilar Gothic' },
  ];

  for (const link of procedureProductLinks) {
    const procedure = await prisma.procedure.findFirst({
      where: { name: link.procedureName }
    });
    
    const product = await prisma.product.findFirst({
      where: { name: link.productName }
    });

    if (procedure && product) {
      const existing = await prisma.procedureProduct.findFirst({
        where: {
          procedureId: procedure.id,
          productId: product.id,
        }
      });

      if (!existing) {
        await prisma.procedureProduct.create({
          data: {
            procedureId: procedure.id,
            productId: product.id,
          },
        });
      }
    }
  }

  console.log('Produtos vinculados aos procedimentos');

  console.log('🎉 Seed concluído com sucesso!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });