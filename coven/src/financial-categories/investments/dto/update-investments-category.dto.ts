import { PartialType } from '@nestjs/mapped-types';
import { CreateInvestmentsCategoryDto } from './create-investments-category.dto';

export class UpdateInvestmentsCategoryDto extends PartialType(
  CreateInvestmentsCategoryDto,
) {}

