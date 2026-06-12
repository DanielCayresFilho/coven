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
import { ClientsService } from './clients.service';
import { ClientsReportsService } from './clients-reports.service';
import { CreateClientDto } from './dto/create-client.dto';
import { UpdateClientDto } from './dto/update-client.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('clients')
@UseGuards(JwtAuthGuard)
export class ClientsController {
  constructor(
    private readonly clientsService: ClientsService,
    private readonly clientsReportsService: ClientsReportsService,
  ) {}

  @Post()
  async create(@Body() createClientDto: CreateClientDto) {
    try {
      return await this.clientsService.create(createClientDto);
    } catch (error) {
      console.error('Erro no controller ao criar cliente:', error);
      throw error;
    }
  }

  @Get()
  findAll(@Query('includeInactive') includeInactive?: string) {
    return this.clientsService.findAll(includeInactive === 'true');
  }

  @Get('birthdays')
  getBirthdaysThisMonth() {
    return this.clientsService.getBirthdaysThisMonth();
  }

  @Get('reports/top')
  getTopClients(@Query('limit') limit?: string) {
    const limitNum = limit ? parseInt(limit, 10) : 10;
    return this.clientsReportsService.getTopClients(limitNum);
  }

  @Get('reports/:id')
  getClientDetails(@Param('id') id: string) {
    return this.clientsReportsService.getClientDetails(id);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.clientsService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateClientDto: UpdateClientDto) {
    return this.clientsService.update(id, updateClientDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.clientsService.remove(id);
  }
}
