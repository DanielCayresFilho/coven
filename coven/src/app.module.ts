import { Module } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { ClientsModule } from './clients/clients.module';
import { ProceduresModule } from './procedures/procedures.module';
import { ProductsModule } from './products/products.module';
import { AppointmentsModule } from './appointments/appointments.module';
import { EntryMoneyModule } from './financial-categories/entry-money/entry-money.module';
import { CostVariableModule } from './financial-categories/cost-variable/cost-variable.module';
import { FixesAccountsModule } from './financial-categories/fixes-accounts/fixes-accounts.module';
import { InvestmentsModule } from './financial-categories/investments/investments.module';
import { EntryAnalyticsModule } from './entry-analytics/entry-analytics.module';
import { OutAnalyticsModule } from './out-analytics/out-analytics.module';
import { CashFlowModule } from './cash-flow/cash-flow.module';
import { RemindersModule } from './reminders/reminders.module';
import { GoalsModule } from './goals/goals.module';
import { FixedExpensesModule } from './fixed-expenses/fixed-expenses.module';
@Module({
  imports: [

    ConfigModule.forRoot({
      isGlobal: true,
    }),
    ScheduleModule.forRoot(),
    PrismaModule,
    AuthModule,
    UsersModule,
    ClientsModule,
    ProceduresModule,
    ProductsModule,
    AppointmentsModule,
    EntryMoneyModule,
    CostVariableModule,
    FixesAccountsModule,
    InvestmentsModule,
    EntryAnalyticsModule,
    OutAnalyticsModule,
    CashFlowModule,
    RemindersModule,
    GoalsModule,
    FixedExpensesModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
