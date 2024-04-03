import { Injectable } from '@nestjs/common';
import { CreateCandyDto } from './dto/create-candy.dto';
import { UpdateCandyDto } from './dto/update-candy.dto';

@Injectable()
export class CandiesService {
  create(createCandyDto: CreateCandyDto) {
    return 
  }

  findAll() {
    return 
  }

  findOne(id: number) {
    return 
  }

  update(id: number, updateCandyDto: UpdateCandyDto) {
    return 
  }

  remove(id: number) {
    return 
  }
}
