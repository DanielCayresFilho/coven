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
import { CostVariableService } from './cost-variable.service';
import { CreateCostVariableCategoryDto } from './dto/create-cost-variable-category.dto';
import { UpdateCostVariableCategoryDto } from './dto/update-cost-variable-category.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller('financial-categories/cost-variable')
@UseGuards(JwtAuthGuard)
export class CostVariableController {
  constructor(private readonly costVariableService: CostVariableService) {}

  @Post()
  create(@Body() createDto: CreateCostVariableCategoryDto) {
    return this.costVariableService.create(createDto);
  }

  @Get()
  findAll() {
    return this.costVariableService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.costVariableService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDto: UpdateCostVariableCategoryDto,
  ) {
    return this.costVariableService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.costVariableService.remove(id);
  }
}

