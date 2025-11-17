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
import { FixesAccountsService } from './fixes-accounts.service';
import { CreateFixesAccountsCategoryDto } from './dto/create-fixes-accounts-category.dto';
import { UpdateFixesAccountsCategoryDto } from './dto/update-fixes-accounts-category.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller('financial-categories/fixes-accounts')
@UseGuards(JwtAuthGuard)
export class FixesAccountsController {
  constructor(private readonly fixesAccountsService: FixesAccountsService) {}

  @Post()
  create(@Body() createDto: CreateFixesAccountsCategoryDto) {
    return this.fixesAccountsService.create(createDto);
  }

  @Get()
  findAll() {
    return this.fixesAccountsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.fixesAccountsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateDto: UpdateFixesAccountsCategoryDto,
  ) {
    return this.fixesAccountsService.update(id, updateDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.fixesAccountsService.remove(id);
  }
}

