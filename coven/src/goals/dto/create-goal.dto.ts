import {
  IsEnum,
  IsNumber,
  IsDateString,
  Min,
} from 'class-validator';
import { Type } from 'class-transformer';
import { GoalPeriod } from '@prisma/client';

export class CreateGoalDto {
  @IsEnum(GoalPeriod)
  period: GoalPeriod;

  @IsNumber()
  @Type(() => Number)
  @Min(0.01)
  targetAmount: number;

  @IsDateString()
  startDate: string;

  @IsDateString()
  endDate: string;
}

