import { Module } from '@nestjs/common';
import { CandiesService } from './candies.service';
import { CandiesController } from './candies.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Candy } from './entities/candy.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Candy])],
  controllers: [CandiesController],
  providers: [CandiesService],
})
export class CandiesModule {}
