import { Module } from '@nestjs/common';
import { FixesAccountsService } from './fixes-accounts.service';
import { FixesAccountsController } from './fixes-accounts.controller';

@Module({
  controllers: [FixesAccountsController],
  providers: [FixesAccountsService],
  exports: [FixesAccountsService],
})
export class FixesAccountsModule {}

