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
import { CashFlowService } from './cash-flow.service';
import { CreateCashFlowConfigDto } from './dto/create-cash-flow-config.dto';
import { UpdateCashFlowConfigDto } from './dto/update-cash-flow-config.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('cash-flow')
@UseGuards(JwtAuthGuard)
export class CashFlowController {
  constructor(private readonly cashFlowService: CashFlowService) {}

  @Post('config')
  createConfig(@Body() createDto: CreateCashFlowConfigDto) {
    return this.cashFlowService.create(createDto);
  }

  @Get('config')
  findAllConfigs(@Query('year') year?: number) {
    return this.cashFlowService.findAll(year ? parseInt(year.toString()) : undefined);
  }

  @Get('config/:id')
  findOneConfig(@Param('id') id: string) {
    return this.cashFlowService.findOne(id);
  }

  @Get('config/month/:year/:month')
  findByMonthYear(
    @Param('year') year: string,
    @Param('month') month: string,
  ) {
    return this.cashFlowService.findByMonthYear(
      parseInt(year),
      parseInt(month),
    );
  }

  @Patch('config/:id')
  updateConfig(
    @Param('id') id: string,
    @Body() updateDto: UpdateCashFlowConfigDto,
  ) {
    return this.cashFlowService.update(id, updateDto);
  }

  @Delete('config/:id')
  removeConfig(@Param('id') id: string) {
    return this.cashFlowService.remove(id);
  }

  @Get('calculate/:year')
  getCashFlow(@Param('year') year: string) {
    return this.cashFlowService.getCashFlow(parseInt(year));
  }
}

