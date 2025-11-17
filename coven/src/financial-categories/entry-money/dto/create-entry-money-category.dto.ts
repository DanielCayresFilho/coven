import { IsString, IsNotEmpty } from 'class-validator';

export class CreateEntryMoneyCategoryDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}

