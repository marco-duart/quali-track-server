import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateCandyDto } from './dto/create-candy.dto';
import { UpdateCandyDto } from './dto/update-candy.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Candy } from './entities/candy.entity';
import { Repository } from 'typeorm';

@Injectable()
export class CandiesService {
  constructor(
    @InjectRepository(Candy)
    private candyRepository: Repository<Candy>,
  ) {}

  async create(createCandyDto: CreateCandyDto) {
    try {
      const candy = this.candyRepository.create(createCandyDto);
      await this.candyRepository.save(candy);

      return candy;
    } catch (error) {
      throw new BadRequestException(error?.message);
    }
  }

  async findAll() {
    return this.candyRepository.find();
  }

  async findOne(id: number) {
    try {
      const candy = await this.candyRepository.findOneOrFail({
        where: {
          id,
        },
      });

      return candy;
    } catch (error) {
      throw new NotFoundException(error?.message || 'Candy not found');
    }
  }

  async update(id: number, updateCandyDto: UpdateCandyDto) {
    try {
      const { affected } = await this.candyRepository.update(
        id,
        updateCandyDto,
      );
      if (!affected) {
        throw new NotFoundException(`Candy ${id} does not exist`);
      }

      return this.candyRepository.findOneBy({ id });
    } catch (error) {
      throw new NotFoundException(error?.message || 'Candy not found');
    }
  }

  // async candyReport() {
    
  // }

  async remove(id: number) {
    try {
      await this.findOne(id);

      await this.candyRepository.delete(id);

      return { status: 'ok' };
    } catch (error) {
      throw new NotFoundException(error?.message);
    }
  }
}
