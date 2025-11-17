import { PartialType } from '@nestjs/mapped-types';
import { CreateCashFlowConfigDto } from './create-cash-flow-config.dto';

export class UpdateCashFlowConfigDto extends PartialType(
  CreateCashFlowConfigDto,
) {}

