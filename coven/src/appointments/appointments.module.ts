import { Module } from '@nestjs/common';
import { AppointmentsService } from './appointments.service';
import { AppointmentsController } from './appointments.controller';
import { ProductsModule } from '../products/products.module';
import { GoalsModule } from '../goals/goals.module';
import { EntryAnalyticsModule } from '../entry-analytics/entry-analytics.module';
import { OutAnalyticsModule } from '../out-analytics/out-analytics.module';

@Module({
  imports: [ProductsModule, GoalsModule, EntryAnalyticsModule, OutAnalyticsModule],
  controllers: [AppointmentsController],
  providers: [AppointmentsService],
  exports: [AppointmentsService],
})
export class AppointmentsModule {}
