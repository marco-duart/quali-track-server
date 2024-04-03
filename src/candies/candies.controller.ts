import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { CandiesService } from './candies.service';
import { CreateCandyDto } from './dto/create-candy.dto';
import { UpdateCandyDto } from './dto/update-candy.dto';
import { AuthGuard } from 'src/auth/guards/auth.guard';

@Controller('candies')
export class CandiesController {
  constructor(private readonly candiesService: CandiesService) {}

  @UseGuards(AuthGuard)
  @Post()
  create(@Body() createCandyDto: CreateCandyDto) {
    return this.candiesService.create(createCandyDto);
  }

  @UseGuards(AuthGuard)
  @Get()
  findAll() {
    return this.candiesService.findAll();
  }

  @UseGuards(AuthGuard)
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.candiesService.findOne(+id);
  }

  @UseGuards(AuthGuard)
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCandyDto: UpdateCandyDto) {
    return this.candiesService.update(+id, updateCandyDto);
  }

  @UseGuards(AuthGuard)
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.candiesService.remove(+id);
  }
}
