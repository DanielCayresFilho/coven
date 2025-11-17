import { PartialType } from '@nestjs/mapped-types';
import { CreateOutAnalyticDto } from './create-out-analytic.dto';

export class UpdateOutAnalyticDto extends PartialType(
  CreateOutAnalyticDto,
) {}

