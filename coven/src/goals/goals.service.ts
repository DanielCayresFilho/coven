import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateGoalDto } from './dto/create-goal.dto';
import { UpdateGoalDto } from './dto/update-goal.dto';
import { GoalPeriod } from '@prisma/client';

@Injectable()
export class GoalsService {
  constructor(private prisma: PrismaService) {}

  async create(createGoalDto: CreateGoalDto) {
    return this.prisma.goal.create({
      data: {
        ...createGoalDto,
        startDate: new Date(createGoalDto.startDate),
        endDate: new Date(createGoalDto.endDate),
        currentAmount: 0,
      },
    });
  }

  async findAll() {
    const now = new Date();
    
    // Busca todas as metas e calcula o valor atual baseado em comandas finalizadas
    let goals = await this.prisma.goal.findMany({
      orderBy: { createdAt: 'desc' },
    });

    if (goals.length === 0) {
      await this.createDefaultGoals();
      goals = await this.prisma.goal.findMany({
        orderBy: { createdAt: 'desc' },
      });
    }

    // Atualiza o currentAmount de cada meta
    const updatedGoals = await Promise.all(
      goals.map(async (goal) => {
        const currentAmount = await this.calculateCurrentAmount(
          goal.startDate,
          goal.endDate,
        );
        return {
          ...goal,
          currentAmount,
        };
      }),
    );

    return updatedGoals;
  }

  async findOne(id: string) {
    const goal = await this.prisma.goal.findUnique({
      where: { id },
    });

    if (!goal) {
      throw new NotFoundException('Meta não encontrada');
    }

    const currentAmount = await this.calculateCurrentAmount(
      goal.startDate,
      goal.endDate,
    );

    return {
      ...goal,
      currentAmount,
    };
  }

  async getActiveGoals() {
    const now = new Date();
    
    let goals = await this.prisma.goal.findMany({
      where: {
        startDate: { lte: now },
        endDate: { gte: now },
      },
      orderBy: { createdAt: 'desc' },
    });

    if (goals.length === 0) {
      await this.createDefaultGoals();
      goals = await this.prisma.goal.findMany({
        where: {
          startDate: { lte: now },
          endDate: { gte: now },
        },
        orderBy: { createdAt: 'desc' },
      });
    }

    const updatedGoals = await Promise.all(
      goals.map(async (goal) => {
        const currentAmount = await this.calculateCurrentAmount(
          goal.startDate,
          goal.endDate,
        );
        return {
          ...goal,
          currentAmount,
        };
      }),
    );

    return updatedGoals;
  }

  async update(id: string, updateGoalDto: UpdateGoalDto) {
    await this.findOne(id);

    const data: any = { ...updateGoalDto };
    
    if (updateGoalDto.startDate) {
      data.startDate = new Date(updateGoalDto.startDate);
    }
    if (updateGoalDto.endDate) {
      data.endDate = new Date(updateGoalDto.endDate);
    }

    return this.prisma.goal.update({
      where: { id },
      data,
    });
  }

  async remove(id: string) {
    await this.findOne(id);
    return this.prisma.goal.delete({
      where: { id },
    });
  }

  // Atualiza automaticamente as metas quando uma comanda é finalizada
  async updateGoalsForCompletedAppointment(amount: number, appointmentDate: Date) {
    const now = new Date();
    
    // Busca metas ativas que incluem a data do agendamento
    let activeGoals = await this.prisma.goal.findMany({
      where: {
        startDate: { lte: appointmentDate },
        endDate: { gte: appointmentDate },
      },
    });

    if (activeGoals.length === 0) {
      await this.createDefaultGoals();
      activeGoals = await this.prisma.goal.findMany({
        where: {
          startDate: { lte: appointmentDate },
          endDate: { gte: appointmentDate },
        },
      });
    }

    // Atualiza cada meta
    for (const goal of activeGoals) {
      const currentAmount = await this.calculateCurrentAmount(
        goal.startDate,
        goal.endDate,
      );
      
      await this.prisma.goal.update({
        where: { id: goal.id },
        data: { currentAmount },
      });
    }

    return activeGoals;
  }

  // Calcula o valor atual baseado em comandas finalizadas
  private async calculateCurrentAmount(startDate: Date, endDate: Date) {
    const appointments = await this.prisma.appointment.findMany({
      where: {
        status: 'CONCLUIDO',
        comandaClosedAt: {
          gte: startDate,
          lte: endDate,
        },
      },
    });

    return appointments.reduce(
      (sum, apt) => sum + parseFloat((apt.finalPrice || apt.totalPrice || 0).toString()),
      0,
    );
  }

  // Cria automaticamente metas semanais e mensais
  async createDefaultGoals() {
    const now = new Date();
    
    // Meta semanal (começa na segunda-feira da semana atual)
    const startOfWeek = new Date(now);
    const dayOfWeek = startOfWeek.getDay();
    const daysToMonday = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
    startOfWeek.setDate(startOfWeek.getDate() - daysToMonday);
    startOfWeek.setHours(0, 0, 0, 0);
    
    const endOfWeek = new Date(startOfWeek);
    endOfWeek.setDate(endOfWeek.getDate() + 6);
    endOfWeek.setHours(23, 59, 59, 999);

    // Meta mensal (começa no primeiro dia do mês)
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
    const endOfMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59, 999);

    // Verifica se já existem metas para esses períodos
    const existingWeekly = await this.prisma.goal.findFirst({
      where: {
        period: 'SEMANAL',
        startDate: { lte: endOfWeek },
        endDate: { gte: startOfWeek },
      },
    });

    const existingMonthly = await this.prisma.goal.findFirst({
      where: {
        period: 'MENSAL',
        startDate: { lte: endOfMonth },
        endDate: { gte: startOfMonth },
      },
    });

    const goals = [];

    if (!existingWeekly) {
      const weeklyGoal = await this.prisma.goal.create({
        data: {
          period: 'SEMANAL',
          targetAmount: 500,
          currentAmount: 0,
          startDate: startOfWeek,
          endDate: endOfWeek,
        },
      });
      goals.push(weeklyGoal);
    }

    if (!existingMonthly) {
      const monthlyGoal = await this.prisma.goal.create({
        data: {
          period: 'MENSAL',
          targetAmount: 2000,
          currentAmount: 0,
          startDate: startOfMonth,
          endDate: endOfMonth,
        },
      });
      goals.push(monthlyGoal);
    }

    return goals;
  }
}

