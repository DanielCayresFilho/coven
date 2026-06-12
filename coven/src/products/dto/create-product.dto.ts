import {
  IsString,
  IsNotEmpty,
  IsOptional,
  IsNumber,
  IsEnum,
  IsBoolean,
  IsInt,
  Min,
  ValidateIf,
} from 'class-validator';
import { Transform, Type } from 'class-transformer';
import { ProductType } from '@prisma/client';

export class CreateProductDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  description?: string;

  @ValidateIf((o) => o.category !== '')
  @IsString()
  @IsOptional()
  category?: string;

  @IsEnum(ProductType)
  type: ProductType;

  @IsNumber()
  @Type(() => Number)
  @IsOptional()
  @Min(0)
  price?: number;

  @IsInt({ message: 'Estoque deve ser um número inteiro' })
  @Type(() => Number)
  @Min(0)
  stock: number;

  @IsInt({ message: 'Estoque mínimo deve ser um número inteiro' })
  @Type(() => Number)
  @Min(0)
  minStock: number;

  @IsString()
  @IsOptional()
  unit?: string;

  @ValidateIf((o) => o.type === ProductType.USO_INTERNO)
  @IsNumber()
  @Type(() => Number)
  @Min(0.01, { message: 'Quantidade por unidade deve ser maior que zero' })
  unitQuantity?: number;

  @ValidateIf((o) => o.type === ProductType.USO_INTERNO)
  @IsString()
  @IsNotEmpty({ message: 'Unidade de medida é obrigatória para produtos de uso interno' })
  unitMeasurement?: string;

  @Transform(({ value }) => value === 'true' || value === true)
  @IsBoolean()
  @IsOptional()
  addToCost?: boolean;
}
