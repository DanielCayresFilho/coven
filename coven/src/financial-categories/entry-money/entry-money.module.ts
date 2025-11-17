import { Module } from '@nestjs/common';
import { EntryMoneyService } from './entry-money.service';
import { EntryMoneyController } from './entry-money.controller';

@Module({
  controllers: [EntryMoneyController],
  providers: [EntryMoneyService],
  exports: [EntryMoneyService],
})
export class EntryMoneyModule {}

