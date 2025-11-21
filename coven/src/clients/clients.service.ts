import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateClientDto } from './dto/create-client.dto';
import { UpdateClientDto } from './dto/update-client.dto';

@Injectable()
export class ClientsService {
  constructor(private prisma: PrismaService) {}

  async create(createClientDto: CreateClientDto) {
    try {
      if (createClientDto.email) {
        const existingClient = await this.prisma.client.findUnique({
          where: { email: createClientDto.email },
        });

        if (existingClient) {
          throw new ConflictException('Email já cadastrado');
        }
      }
      
      // Prepara os dados removendo campos undefined
      const data: any = {
        name: createClientDto.name,
      };

      if (createClientDto.email) {
        data.email = createClientDto.email;
      }

      if (createClientDto.phone) {
        data.phone = createClientDto.phone;
      }

      if (createClientDto.birthDate) {
        data.birthDate = new Date(createClientDto.birthDate);
      }

      if (createClientDto.address) {
        data.address = createClientDto.address;
      }

      if (createClientDto.observations) {
        data.observations = createClientDto.observations;
      }

      return await this.prisma.client.create({
        data,
      });
    } catch (error) {
      console.error('Erro ao criar cliente:', error);
      throw error;
    }
  }

  async findAll() {
    try {
      const clients = await this.prisma.client.findMany({
        where: { active: true },
        select: {
          id: true,
          name: true,
          email: true,
          phone: true,
          birthDate: true,
          address: true,
          observations: true,
          active: true,
          createdAt: true,
          updatedAt: true,
        },
        orderBy: { name: 'asc' },
      });

      // Se não houver clientes, retorna vazio
      if (clients.length === 0) {
        return [];
      }

      // Buscar último atendimento para cada cliente usando uma query mais simples
      const clientIds = clients.map(c => c.id);
      
      // Buscar todos os últimos atendimentos em uma única query usando raw SQL ou findMany
      const appointments = await this.prisma.appointment.findMany({
        where: {
          clientId: { in: clientIds },
          status: { not: 'CANCELADO' }
        },
        select: {
          clientId: true,
          date: true,
          startTime: true,
        },
        orderBy: {
          date: 'desc',
        },
      });

      // Agrupar por clientId e pegar o primeiro (mais recente) de cada
      const lastAppointmentMap = new Map<string, Date | null>();
      const seenClients = new Set<string>();
      
      for (const apt of appointments) {
        if (!seenClients.has(apt.clientId)) {
          lastAppointmentMap.set(apt.clientId, apt.date || apt.startTime);
          seenClients.add(apt.clientId);
        }
      }

      // Adicionar último atendimento a cada cliente
      return clients.map(client => ({
        ...client,
        lastAppointment: lastAppointmentMap.get(client.id) || null
      }));
    } catch (error) {
      console.error('Erro ao buscar clientes:', error);
      throw error;
    }
  }

  async findOne(id: string) {
    const client = await this.prisma.client.findUnique({
      where: { id },
      include: {
        appointments: {
          include: {
            user: {
              select: { name: true },
            },
            procedures: {
              include: {
                procedure: true,
              },
            },
          },
          orderBy: { date: 'desc' },
          take: 10,
        },
      },
    });

    if (!client) {
      throw new NotFoundException('Cliente não encontrado');
    }

    return client;
  }

  async update(id: string, updateClientDto: UpdateClientDto) {
    await this.findOne(id);

    if (updateClientDto.email) {
      const existingClient = await this.prisma.client.findFirst({
        where: {
          email: updateClientDto.email,
          NOT: { id },
        },
      });

      if (existingClient) {
        throw new ConflictException('Email já cadastrado');
      }
    }

    const data: any = {
      ...updateClientDto,
      birthDate: updateClientDto.birthDate
        ? new Date(updateClientDto.birthDate)
        : undefined,
    };

    return this.prisma.client.update({
      where: { id },
      data,
    });
  }

  async remove(id: string) {
    await this.findOne(id);

    return this.prisma.client.update({
      where: { id },
      data: { active: false },
    });
  }

  async getBirthdaysThisMonth() {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth();

    const startOfMonth = new Date(year, month, 1);
    const endOfMonth = new Date(year, month + 1, 0);

    return this.prisma.client.findMany({
      where: {
        active: true,
        birthDate: {
          gte: startOfMonth,
          lte: endOfMonth,
        },
      },
      orderBy: { birthDate: 'asc' },
    });
  }
}
