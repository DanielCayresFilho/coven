import { IsString, IsNotEmpty } from 'class-validator';

export class CreateCostVariableCategoryDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}

