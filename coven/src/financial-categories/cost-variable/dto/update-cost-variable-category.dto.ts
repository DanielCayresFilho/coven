import { PartialType } from '@nestjs/mapped-types';
import { CreateCostVariableCategoryDto } from './create-cost-variable-category.dto';

export class UpdateCostVariableCategoryDto extends PartialType(
  CreateCostVariableCategoryDto,
) {}

