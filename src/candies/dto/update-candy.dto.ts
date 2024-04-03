import { PartialType } from '@nestjs/mapped-types';
import { CreateCandyDto } from './create-candy.dto';

export class UpdateCandyDto extends PartialType(CreateCandyDto) {}
