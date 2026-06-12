import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { PrismaExceptionFilter } from './common/filters/prisma-exception.filter';

async function bootstrap() {
  try {
    const app = await NestFactory.create(AppModule);

    // Configurar CORS
    const corsOrigins = process.env.CORS_ORIGINS?.split(',')
      .map((origin) => origin.trim())
      .filter(Boolean);

    app.enableCors({
      origin: corsOrigins?.length ? corsOrigins : true,
      credentials: true,
    });

    // Configurar validação global
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        transform: true,
        forbidNonWhitelisted: true,
      }),
    );

    // Tratamento global de erros Prisma
    app.useGlobalFilters(new PrismaExceptionFilter());

    // Prefixo global para APIs
    app.setGlobalPrefix('api');

    const port = process.env.PORT || 3009;
    await app.listen(port);
    console.log(`🦇 CovenSO Backend rodando na porta ${port}`);

    // Verificação diária de aniversários será implementada via endpoint
    console.log(
      '📅 Para verificação automática de aniversários, chame: POST /api/reminders/birthdays/check-daily',
    );

    // Graceful shutdown handlers
    process.on('SIGTERM', async () => {
      console.log('🔄 SIGTERM received, shutting down gracefully...');
      await app.close();
      process.exit(0);
    });

    process.on('SIGINT', async () => {
      console.log('🔄 SIGINT received, shutting down gracefully...');
      await app.close();
      process.exit(0);
    });

    // Handle uncaught exceptions
    process.on('uncaughtException', (error) => {
      console.error('❌ Uncaught Exception:', error);
      process.exit(1);
    });

    process.on('unhandledRejection', (reason, promise) => {
      console.error('❌ Unhandled Rejection at:', promise, 'reason:', reason);
      process.exit(1);
    });

  } catch (error) {
    console.error('❌ Failed to start application:', error);
    process.exit(1);
  }
}
bootstrap();
