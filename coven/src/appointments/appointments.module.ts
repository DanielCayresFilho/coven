import { Module } from '@nestjs/common';
import { AppointmentsService } from './appointments.service';
import { AppointmentsController } from './appointments.controller';
import { ProductsModule } from '../products/products.module';
import { GoalsModule } from '../goals/goals.module';

@Module({
  imports: [ProductsModule, GoalsModule],
  controllers: [AppointmentsController],
  providers: [AppointmentsService],
  exports: [AppointmentsService],
})
export class AppointmentsModule {}
