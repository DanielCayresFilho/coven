import { IsString, IsNotEmpty, IsNumber, IsDateString, IsOptional } from 'class-validator';

export class CreateOutAnalyticDto {
  @IsDateString()
  @IsNotEmpty()
  date: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsNumber()
  @IsNotEmpty()
  amount: number;

  // Apenas uma das três categorias deve ser fornecida (validação no service)
  @IsString()
  @IsOptional()
  costVariableCategoryId?: string;

  @IsString()
  @IsOptional()
  fixesAccountsCategoryId?: string;

  @IsString()
  @IsOptional()
  investmentsCategoryId?: string;
}

