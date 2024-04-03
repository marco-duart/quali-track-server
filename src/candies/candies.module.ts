import { Module } from '@nestjs/common';
import { CandiesService } from './candies.service';
import { CandiesController } from './candies.controller';

@Module({
  controllers: [CandiesController],
  providers: [CandiesService],
})
export class CandiesModule {}
