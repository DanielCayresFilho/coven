import { PartialType } from '@nestjs/mapped-types';
import { CreateFixesAccountsCategoryDto } from './create-fixes-accounts-category.dto';

export class UpdateFixesAccountsCategoryDto extends PartialType(
  CreateFixesAccountsCategoryDto,
) {}

