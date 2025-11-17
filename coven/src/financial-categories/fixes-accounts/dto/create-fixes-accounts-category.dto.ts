import { IsString, IsNotEmpty } from 'class-validator';

export class CreateFixesAccountsCategoryDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}

