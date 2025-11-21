import { Module } from '@nestjs/common';
import { ClientsService } from './clients.service';
import { ClientsController } from './clients.controller';
import { ClientsReportsService } from './clients-reports.service';

@Module({
  controllers: [ClientsController],
  providers: [ClientsService, ClientsReportsService],
  exports: [ClientsService, ClientsReportsService],
})
export class ClientsModule {}
