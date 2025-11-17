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
import { InvestmentsService } from './investments.service';
import { CreateInvestmentsCategoryDto } from './dto/create-investments-category.dto';
import { UpdateInvestmentsCategoryDto } from './dto/update-investments-category.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller('financial-categories/investments')
@UseGuards(JwtAuthGuard)
export class InvestmentsController {
  constructor(private readonly investmentsService: InvestmentsService) {}

  @Post()
  create(@Body() createDto: CreateInvestmentsCategoryDto) {
    return this.investmentsService.create(createDto);
  }

  @Get()
  findAll() {
    return this.investmentsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.investmentsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDto: UpdateInvestmentsCategoryDto,
  ) {
    return this.investmentsService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.investmentsService.remove(id);
  }
}

