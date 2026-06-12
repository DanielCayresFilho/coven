import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { Response } from 'express';

const FIELD_LABELS: Record<string, string> = {
  email: 'email',
  phone: 'telefone',
  name: 'nome',
};

@Catch(Prisma.PrismaClientKnownRequestError)
export class PrismaExceptionFilter implements ExceptionFilter {
  catch(exception: Prisma.PrismaClientKnownRequestError, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse<Response>();

    if (exception.code === 'P2002') {
      const field = (exception.meta?.target as string[])?.[0] ?? 'campo';
      const label = FIELD_LABELS[field] ?? field;

      return response.status(409).json({
        statusCode: 409,
        message: `Já existe um registro com este ${label}.`,
      });
    }

    if (exception.code === 'P2025') {
      return response.status(404).json({
        statusCode: 404,
        message: 'Registro não encontrado.',
      });
    }

    return response.status(500).json({
      statusCode: 500,
      message: 'Erro interno ao processar operação no banco de dados.',
    });
  }
}
