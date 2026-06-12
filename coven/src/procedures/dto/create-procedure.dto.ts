import {
  IsString,
  IsNotEmpty,
  IsOptional,
  IsNumber,
  IsPositive,
  IsInt,
  Min,
  ValidateIf,
  IsBoolean,
  IsIn,
} from 'class-validator';
import { Type } from 'class-transformer';

export const PROCEDURE_CATEGORIES = [
  'CABELO',
  'ALISAMENTO',
  'CORTE',
  'TRATAMENTO',
  'COLORACAO',
  'DESCOLORACAO',
  'EPILACAO',
  'ESTETICA_FACIAL',
  'ESTETICA_CORPORAL',
  'OUTROS',
] as const;

export class CreateProcedureDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  description?: string;

  @ValidateIf((o) => o.category !== '' && o.category != null)
  @IsIn(PROCEDURE_CATEGORIES, { message: 'Categoria inválida' })
  @IsOptional()
  category?: string;

  @IsInt({ message: 'Duração deve ser em minutos inteiros' })
  @Type(() => Number)
  @Min(1)
  duration: number;

  @IsNumber()
  @Type(() => Number)
  @IsPositive()
  price: number;

  @IsBoolean()
  @IsOptional()
  active?: boolean;
}
