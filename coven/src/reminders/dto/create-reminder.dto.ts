import {
  IsString,
  IsNotEmpty,
  IsOptional,
  IsEnum,
  IsDateString,
} from 'class-validator';
import { ReminderType, ReminderPriority } from '@prisma/client';

export class CreateReminderDto {
  @IsEnum(ReminderType)
  type: ReminderType;

  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsDateString()
  date: string;

  @IsEnum(ReminderPriority)
  @IsOptional()
  priority?: ReminderPriority;

  @IsString()
  @IsOptional()
  userId?: string;

  @IsString()
  @IsOptional()
  clientId?: string;
}
