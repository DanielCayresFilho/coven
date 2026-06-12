import {
  IsString,
  IsInt,
  Min,
  IsOptional,
} from 'class-validator';
import { Type } from 'class-transformer';

export class StockMovementDto {
  @IsInt({ message: 'Quantidade deve ser um número inteiro' })
  @Type(() => Number)
  @Min(1, { message: 'Quantidade mínima é 1' })
  quantity: number;

  @IsString()
  @IsOptional()
  reason?: string;
}
