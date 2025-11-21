import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ClientsReportsService {
  constructor(private prisma: PrismaService) {}

  async getTopClients(limit: number = 10) {
    // Buscar todos os clientes ativos
    const clients = await this.prisma.client.findMany({
      where: { active: true },
      select: {
        id: true,
        name: true,
        email: true,
        phone: true,
        birthDate: true,
      },
    });

    // Buscar agendamentos concluídos para calcular estatísticas
    const appointments = await this.prisma.appointment.findMany({
      where: {
        status: 'CONCLUIDO',
        clientId: { in: clients.map(c => c.id) },
      },
      select: {
        clientId: true,
        totalPrice: true,
        date: true,
        finalPrice: true,
      },
    });

    // Buscar entradas analíticas vinculadas a clientes
    const entryAnalytics = await this.prisma.entryAnalytic.findMany({
      where: {
        clientId: { in: clients.map(c => c.id) },
      },
      select: {
        clientId: true,
        amount: true,
        date: true,
      },
    });

    // Calcular estatísticas por cliente
    const clientStats = clients.map(client => {
      const clientAppointments = appointments.filter(a => a.clientId === client.id);
      const clientEntries = entryAnalytics.filter(e => e.clientId === client.id);

      const totalSpent = clientAppointments.reduce((sum, apt) => {
        return sum + Number(apt.finalPrice || apt.totalPrice || 0);
      }, 0) + clientEntries.reduce((sum, entry) => {
        return sum + Number(entry.amount || 0);
      }, 0);

      const appointmentCount = clientAppointments.length;
      const lastAppointment = clientAppointments.length > 0
        ? clientAppointments.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())[0].date
        : null;

      return {
        ...client,
        appointmentCount,
        totalSpent,
        averageTicket: appointmentCount > 0 ? totalSpent / appointmentCount : 0,
        lastAppointment,
      };
    });

    // Ordenar por total gasto e retornar top N
    return clientStats
      .sort((a, b) => b.totalSpent - a.totalSpent)
      .slice(0, limit);
  }

  async getClientDetails(clientId: string) {
    const client = await this.prisma.client.findUnique({
      where: { id: clientId },
      select: {
        id: true,
        name: true,
        email: true,
        phone: true,
        birthDate: true,
        address: true,
        observations: true,
        createdAt: true,
      },
    });

    if (!client) {
      return null;
    }

    const appointments = await this.prisma.appointment.findMany({
      where: {
        clientId,
        status: 'CONCLUIDO',
      },
      select: {
        id: true,
        date: true,
        totalPrice: true,
        finalPrice: true,
        paymentMethod: true,
        procedures: {
          include: {
            procedure: {
              select: {
                name: true,
                price: true,
              },
            },
          },
        },
      },
      orderBy: { date: 'desc' },
    });

    const entryAnalytics = await this.prisma.entryAnalytic.findMany({
      where: { clientId },
      include: {
        entryMoneyCategory: {
          select: {
            name: true,
          },
        },
      },
      orderBy: { date: 'desc' },
    });

    const totalSpent = appointments.reduce((sum, apt) => {
      return sum + Number(apt.finalPrice || apt.totalPrice || 0);
    }, 0) + entryAnalytics.reduce((sum, entry) => {
      return sum + Number(entry.amount || 0);
    }, 0);

    return {
      ...client,
      appointments,
      entryAnalytics,
      totalSpent,
      appointmentCount: appointments.length,
      averageTicket: appointments.length > 0 ? totalSpent / appointments.length : 0,
    };
  }
}

