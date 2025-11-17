import { PartialType } from '@nestjs/mapped-types';
import { CreateEntryAnalyticDto } from './create-entry-analytic.dto';

export class UpdateEntryAnalyticDto extends PartialType(
  CreateEntryAnalyticDto,
) {}

