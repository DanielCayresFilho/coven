import { PartialType } from '@nestjs/mapped-types';
import { CreateEntryMoneyCategoryDto } from './create-entry-money-category.dto';

export class UpdateEntryMoneyCategoryDto extends PartialType(
  CreateEntryMoneyCategoryDto,
) {}

