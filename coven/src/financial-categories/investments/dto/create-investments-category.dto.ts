import { IsString, IsNotEmpty } from 'class-validator';

export class CreateInvestmentsCategoryDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}

