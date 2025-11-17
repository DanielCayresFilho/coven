import { IsInt, IsNumber, Min, Max, IsNotEmpty } from 'class-validator';

export class CreateCashFlowConfigDto {
  @IsInt()
  @Min(2020)
  @Max(2100)
  @IsNotEmpty()
  year: number;

  @IsInt()
  @Min(1)
  @Max(12)
  @IsNotEmpty()
  month: number;

  @IsNumber()
  @IsNotEmpty()
  initialBalance: number;

  @IsNumber()
  @Min(0)
  prolabore?: number;
}

