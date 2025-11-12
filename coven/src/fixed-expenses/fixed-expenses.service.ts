import { Injectable, NotFoundException, Logger } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import {
  FixedExpense,
  Prisma,
  ReminderPriority,
  ReminderType,
} from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { CreateFixedExpenseDto } from './dto/create-fixed-expense.dto';
import { UpdateFixedExpenseDto } from './dto/update-fixed-expense.dto';
import { RemindersService } from '../reminders/reminders.service';

@Injectable()
export class FixedExpensesService {
  private readonly logger = new Logger(FixedExpensesService.name);

  constructor(
    private prisma: PrismaService,
    private remindersService: RemindersService,
  ) {}

  async create(createFixedExpenseDto: CreateFixedExpenseDto) {
    const expense = await this.prisma.fixedExpense.create({
      data: {
        name: createFixedExpenseDto.name,
        amount: new Prisma.Decimal(createFixedExpenseDto.amount),
        dueDay: createFixedExpenseDto.dueDay,
        description: createFixedExpenseDto.description,
      },
    });

    await this.ensureReminderForExpense(expense);
    return this.serializeExpense(expense);
  }

  async findAll() {
    const expenses = await this.prisma.fixedExpense.findMany({
      where: { active: true },
      orderBy: { dueDay: 'asc' },
    });

    return expenses.map((expense) => this.serializeExpense(expense));
  }

  async findOne(id: string) {
    const expense = await this.getExpenseOrThrow(id);
    return this.serializeExpense(expense);
  }

  async update(id: string, updateFixedExpenseDto: UpdateFixedExpenseDto) {
    const existing = await this.getExpenseOrThrow(id);

    const data: Prisma.FixedExpenseUpdateInput = {};

    if (updateFixedExpenseDto.name !== undefined) {
      data.name = updateFixedExpenseDto.name;
    }
    if (updateFixedExpenseDto.amount !== undefined) {
      data.amount = new Prisma.Decimal(updateFixedExpenseDto.amount);
    }
    if (updateFixedExpenseDto.dueDay !== undefined) {
      data.dueDay = updateFixedExpenseDto.dueDay;
    }
    if (updateFixedExpenseDto.description !== undefined) {
      data.description = updateFixedExpenseDto.description;
    }

    const expense = await this.prisma.fixedExpense.update({
      where: { id },
      data,
    });

    // Se nome mudou, desativa lembretes ativos antigos
    if (
      updateFixedExpenseDto.name &&
      updateFixedExpenseDto.name !== existing.name
    ) {
      await this.prisma.reminder.updateMany({
        where: {
          type: ReminderType.DESPESA_FIXA,
          isActive: true,
          title: this.buildReminderTitle(existing),
        },
        data: { isActive: false },
      });
    }

    await this.ensureReminderForExpense(expense);
    return this.serializeExpense(expense);
  }

  async remove(id: string) {
    const expense = await this.getExpenseOrThrow(id);

    const updated = await this.prisma.fixedExpense.update({
      where: { id },
      data: { active: false },
    });

    await this.prisma.reminder.updateMany({
      where: {
        type: ReminderType.DESPESA_FIXA,
        isActive: true,
        title: this.buildReminderTitle(expense),
      },
      data: { isActive: false },
    });

    return this.serializeExpense(updated);
  }

  // Retorna despesas que vencem nos próximos N dias
  async getUpcomingExpenses(days: number = 15) {
    const today = new Date();
    const expenses = await this.prisma.fixedExpense.findMany({
      where: { active: true },
    });

    return expenses
      .map((expense) => {
        const nextDueDate = this.calculateNextDueDate(expense, today);
        const daysUntilDue = this.calculateDaysUntilDue(nextDueDate, today);

        return {
          ...this.serializeExpense(expense),
          nextDueDate,
          daysUntilDue,
        };
      })
      .filter(
        (expense) =>
          expense.daysUntilDue !== null &&
          expense.daysUntilDue >= 0 &&
          expense.daysUntilDue <= days,
      )
      .sort((a, b) => a.nextDueDate.getTime() - b.nextDueDate.getTime());
  }

  @Cron(CronExpression.EVERY_DAY_AT_1AM)
  async handleDailyReminderCheck() {
    const reference = new Date();
    const expenses = await this.prisma.fixedExpense.findMany({
      where: { active: true },
    });

    for (const expense of expenses) {
      await this.ensureReminderForExpense(expense, reference);
    }
  }

  private async getExpenseOrThrow(id: string) {
    const expense = await this.prisma.fixedExpense.findUnique({
      where: { id },
    });

    if (!expense || !expense.active) {
      throw new NotFoundException('Despesa fixa não encontrada');
    }

    return expense;
  }

  private serializeExpense(expense: FixedExpense) {
    return {
      ...expense,
      amount: Number(expense.amount),
    };
  }

  private calculateNextDueDate(
    expense: FixedExpense,
    referenceDate: Date = new Date(),
  ) {
    const start = new Date(referenceDate);
    start.setHours(0, 0, 0, 0);

    const getDueDateForMonth = (year: number, month: number) => {
      const lastDay = new Date(year, month + 1, 0).getDate();
      const day = Math.min(expense.dueDay, lastDay);
      const dueDate = new Date(year, month, day);
      dueDate.setHours(9, 0, 0, 0);
      return dueDate;
    };

    let dueDate = getDueDateForMonth(start.getFullYear(), start.getMonth());

    if (dueDate < start) {
      const nextMonthDate = new Date(
        start.getFullYear(),
        start.getMonth() + 1,
        1,
      );
      dueDate = getDueDateForMonth(
        nextMonthDate.getFullYear(),
        nextMonthDate.getMonth(),
      );
    }

    return dueDate;
  }

  private calculateDaysUntilDue(dueDate: Date, referenceDate: Date) {
    const diffTime = dueDate.getTime() - referenceDate.getTime();
    return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  }

  private buildReminderTitle(expense: FixedExpense) {
    return `Pagamento despesa fixa: ${expense.name}`;
  }

  private buildReminderDescription(expense: FixedExpense, amount: number) {
    const amountFormatted = amount.toLocaleString('pt-BR', {
      style: 'currency',
      currency: 'BRL',
    });

    if (expense.description) {
      return `${expense.description} • Valor: ${amountFormatted}`;
    }

    return `Valor: ${amountFormatted}`;
  }

  private determinePriority(daysUntilDue: number): ReminderPriority {
    if (daysUntilDue <= 3) {
      return ReminderPriority.IMEDIATO;
    }
    if (daysUntilDue <= 7) {
      return ReminderPriority.URGENTE;
    }
    return ReminderPriority.POUCO_URGENTE;
  }

  private async ensureReminderForExpense(
    expense: FixedExpense,
    referenceDate: Date = new Date(),
  ) {
    const nextDueDate = this.calculateNextDueDate(expense, referenceDate);
    const daysUntilDue = this.calculateDaysUntilDue(nextDueDate, referenceDate);

    if (daysUntilDue < 0 || daysUntilDue > 15) {
      return;
    }

    const reminderTitle = this.buildReminderTitle(expense);
    const existingReminder = await this.prisma.reminder.findFirst({
      where: {
        type: ReminderType.DESPESA_FIXA,
        isActive: true,
        title: reminderTitle,
        date: {
          gte: this.startOfDay(nextDueDate),
          lte: this.endOfDay(nextDueDate),
        },
      },
    });

    if (existingReminder) {
      return;
    }

    await this.remindersService.create({
      type: ReminderType.DESPESA_FIXA,
      title: reminderTitle,
      description: this.buildReminderDescription(
        expense,
        Number(expense.amount),
      ),
      date: nextDueDate.toISOString(),
      priority: this.determinePriority(daysUntilDue),
    });

    this.logger.log(
      `Lembrete criado para despesa fixa ${expense.name} com vencimento em ${nextDueDate.toISOString()}`,
    );
  }

  private startOfDay(date: Date) {
    const start = new Date(date);
    start.setHours(0, 0, 0, 0);
    return start;
  }

  private endOfDay(date: Date) {
    const end = new Date(date);
    end.setHours(23, 59, 59, 999);
    return end;
  }
}
