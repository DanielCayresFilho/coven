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
import { OutAnalyticsService } from './out-analytics.service';
import { CreateOutAnalyticDto } from './dto/create-out-analytic.dto';
import { UpdateOutAnalyticDto } from './dto/update-out-analytic.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('out-analytics')
@UseGuards(JwtAuthGuard)
export class OutAnalyticsController {
  constructor(private readonly outAnalyticsService: OutAnalyticsService) {}

  @Post()
  create(@Body() createDto: CreateOutAnalyticDto) {
    return this.outAnalyticsService.create(createDto);
  }

  @Get()
  findAll(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
    @Query('categoryId') categoryId?: string,
    @Query('categoryType') categoryType?: string,
  ) {
    return this.outAnalyticsService.findAll(startDate, endDate, categoryId, categoryType);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.outAnalyticsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDto: UpdateOutAnalyticDto,
  ) {
    return this.outAnalyticsService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.outAnalyticsService.remove(id);
  }
}

