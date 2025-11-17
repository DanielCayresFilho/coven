import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { EntryMoneyService } from './entry-money.service';
import { CreateEntryMoneyCategoryDto } from './dto/create-entry-money-category.dto';
import { UpdateEntryMoneyCategoryDto } from './dto/update-entry-money-category.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller('financial-categories/entry-money')
@UseGuards(JwtAuthGuard)
export class EntryMoneyController {
  constructor(private readonly entryMoneyService: EntryMoneyService) {}

  @Post()
  create(@Body() createDto: CreateEntryMoneyCategoryDto) {
    return this.entryMoneyService.create(createDto);
  }

  @Get()
  findAll() {
    return this.entryMoneyService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.entryMoneyService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDto: UpdateEntryMoneyCategoryDto,
  ) {
    return this.entryMoneyService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.entryMoneyService.remove(id);
  }
}

