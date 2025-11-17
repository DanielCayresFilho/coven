import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Query,
} from '@nestjs/common';
import { EntryAnalyticsService } from './entry-analytics.service';
import { CreateEntryAnalyticDto } from './dto/create-entry-analytic.dto';
import { UpdateEntryAnalyticDto } from './dto/update-entry-analytic.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('entry-analytics')
@UseGuards(JwtAuthGuard)
export class EntryAnalyticsController {
  constructor(private readonly entryAnalyticsService: EntryAnalyticsService) {}

  @Post()
  create(@Body() createDto: CreateEntryAnalyticDto) {
    return this.entryAnalyticsService.create(createDto);
  }

  @Get()
  findAll(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
    @Query('categoryId') categoryId?: string,
  ) {
    return this.entryAnalyticsService.findAll(startDate, endDate, categoryId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.entryAnalyticsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDto: UpdateEntryAnalyticDto,
  ) {
    return this.entryAnalyticsService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.entryAnalyticsService.remove(id);
  }
}

