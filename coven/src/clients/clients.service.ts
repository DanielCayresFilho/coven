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
    if (createClientDto.email) {
      const existingClient = await this.prisma.client.findUnique({
        where: { email: createClientDto.email },
      });

      if (existingClient) {
        throw new ConflictException('Email já cadastrado');
      }
    }
    const data: any = {
      ...createClientDto,
      birthDate: createClientDto.birthDate
        ? new Date(createClientDto.birthDate)
        : undefined,
    };

    return this.prisma.client.create({
      data,
    });
  }

  async findAll() {
    const clients = await this.prisma.client.findMany({
      where: { active: true },
      include: {
        appointments: {
          where: {
            status: { not: 'CANCELADO' }
          },
          orderBy: { date: 'desc' },
          take: 1,
          select: {
            date: true,
            startTime: true
          }
        }
      },
      orderBy: { name: 'asc' },
    });

    // Adiciona o último atendimento (data mais recente)
    return clients.map(client => {
      const lastAppointment = client.appointments && client.appointments.length > 0
        ? client.appointments[0].date || client.appointments[0].startTime
        : null;
      
      return {
        ...client,
        lastAppointment
      };
    });
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
