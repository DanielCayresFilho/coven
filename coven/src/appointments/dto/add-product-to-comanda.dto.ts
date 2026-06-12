import { IsNumber, IsUUID, Min } from 'class-validator';
import { Type } from 'class-transformer';

export class AddProductToComandaDto {
  @IsUUID('4', { message: 'productId deve ser um UUID válido' })
  productId: string;

  @Type(() => Number)
  @IsNumber()
  @Min(0.01, { message: 'Quantidade mínima é 0.01' })
  quantity: number;
}
