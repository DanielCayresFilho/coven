import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from '@nestjs/common';
import { FixedExpensesService } from './fixed-expenses.service';
import { CreateFixedExpenseDto } from './dto/create-fixed-expense.dto';
import { UpdateFixedExpenseDto } from './dto/update-fixed-expense.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('fixed-expenses')
@UseGuards(JwtAuthGuard)
export class FixedExpensesController {
  constructor(private readonly fixedExpensesService: FixedExpensesService) {}

  @Post()
  create(@Body() createFixedExpenseDto: CreateFixedExpenseDto) {
    return this.fixedExpensesService.create(createFixedExpenseDto);
  }

  @Get()
  findAll() {
    return this.fixedExpensesService.findAll();
  }

  @Get('upcoming')
  getUpcomingExpenses(@Query('days') days?: string) {
    const parsed = Number(days);
    const daysNumber = Number.isFinite(parsed) && parsed > 0 ? parsed : 15;
    return this.fixedExpensesService.getUpcomingExpenses(daysNumber);
  }

  @Post(':id/pay')
  payExpense(@Param('id') id: string) {
    return this.fixedExpensesService.payExpense(id);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.fixedExpensesService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateFixedExpenseDto: UpdateFixedExpenseDto,
  ) {
    return this.fixedExpensesService.update(id, updateFixedExpenseDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.fixedExpensesService.remove(id);
  }
}
