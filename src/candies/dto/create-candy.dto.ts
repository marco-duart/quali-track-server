import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateCandyDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  category: number;

  @IsString()
  description: number;

  @IsNumber()
  value: number;
}
