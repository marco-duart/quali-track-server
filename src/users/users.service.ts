import { BadRequestException, HttpException, HttpStatus, Injectable, NotFoundException } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  async create(createUserDto: CreateUserDto) {
    try {
      const user = this.userRepository.create(createUserDto);
      await this.userRepository.save(user);

      return user;
    } catch (error) {
      throw new BadRequestException(error?.message);
    }
  }

  async findOne(id: number) {
    try {
      const user = await this.userRepository.findOneOrFail({
        where: {
          id,
        },
      });

      return user;
    } catch (error) {
      throw new NotFoundException(error?.message || 'User not found');
    }
  }

  async findByEmail(email: string) {
    try {
      const user = await this.userRepository.findOneOrFail({
        where: {
          email,
        },
        select: {
          createdAt: true,
          email: true,
          id: true,
          password: true,
        },
      });

      return user;
    } catch (error) {
      throw new NotFoundException(error?.message);
    }
  }

  async update(id: number, updateUserDto: UpdateUserDto) {
    try {
      const { affected } = await this.userRepository.update(id, updateUserDto);
      if (!affected) {
        throw new NotFoundException(`User ${id} does not exist`);
      }

      return await this.userRepository.findOneBy({ id });
    } catch (error) {
      throw new NotFoundException(error?.message);
    }
  }

  async remove(id: number) {
    return 
  }
}
