import { Module } from '@nestjs/common';
import { CostVariableService } from './cost-variable.service';
import { CostVariableController } from './cost-variable.controller';

@Module({
  controllers: [CostVariableController],
  providers: [CostVariableService],
  exports: [CostVariableService],
})
export class CostVariableModule {}

