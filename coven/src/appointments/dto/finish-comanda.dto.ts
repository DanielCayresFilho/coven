import { IsEnum, IsNumber, IsOptional, Min } from 'class-validator';
import { Type } from 'class-transformer';
import { PaymentMethod } from '@prisma/client';

export class FinishComandaDto {
  @IsEnum(PaymentMethod, { message: 'Forma de pagamento inválida' })
  paymentMethod: PaymentMethod;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(0, { message: 'Desconto não pode ser negativo' })
  discount?: number;

  @IsOptional()
  @Type(() => Number)
  @IsNumber()
  @Min(0, { message: 'Preço final não pode ser negativo' })
  finalPrice?: number;
}
