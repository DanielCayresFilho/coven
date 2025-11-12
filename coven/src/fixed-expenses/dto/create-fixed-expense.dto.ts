import { IsString, IsNumber, IsOptional, Min, Max } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateFixedExpenseDto {
  @IsString()
  name: string;

  @Type(() => Number)
  @IsNumber()
  @Min(0.01)
  amount: number;

  @Type(() => Number)
  @IsNumber()
  @Min(1)
  @Max(31)
  dueDay: number;

  @IsString()
  @IsOptional()
  description?: string;
}
