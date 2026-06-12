import { IsUUID } from 'class-validator';

export class AddProductToProcedureDto {
  @IsUUID('4', { message: 'ID do produto inválido' })
  productId: string;
}
