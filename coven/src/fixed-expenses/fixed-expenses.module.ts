import { Module } from '@nestjs/common';
import { FixedExpensesController } from './fixed-expenses.controller';
import { FixedExpensesService } from './fixed-expenses.service';
import { PrismaModule } from '../prisma/prisma.module';
import { RemindersModule } from '../reminders/reminders.module';

@Module({
  imports: [PrismaModule, RemindersModule],
  controllers: [FixedExpensesController],
  providers: [FixedExpensesService],
  exports: [FixedExpensesService],
})
export class FixedExpensesModule {}
