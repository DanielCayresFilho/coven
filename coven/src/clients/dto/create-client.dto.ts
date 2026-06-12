import { Transform } from 'class-transformer';
import {
  IsString,
  IsEmail,
  IsOptional,
  IsDateString,
  IsNotEmpty,
  MaxLength,
  Matches,
} from 'class-validator';

export class CreateClientDto {
  @IsString()
  @IsNotEmpty()
  @MaxLength(150)
  name: string;

  @Transform(({ value }) => (value === '' ? undefined : value))
  @IsEmail({}, { message: 'Email inválido' })
  @IsOptional()
  email?: string;

  @Transform(({ value }) => (value === '' ? undefined : value))
  @IsString()
  @IsOptional()
  @Matches(/^(\(?\d{2}\)?\s?)?\d{4,5}-?\d{4}$/, {
    message: 'Telefone inválido. Use formato (11) 99999-9999',
  })
  phone?: string;

  @IsDateString({}, { message: 'Data de nascimento inválida' })
  @IsOptional()
  birthDate?: string;

  @IsString()
  @IsOptional()
  @MaxLength(500)
  address?: string;

  @IsString()
  @IsOptional()
  @MaxLength(2000)
  observations?: string;
}
