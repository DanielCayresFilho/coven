import { Module } from '@nestjs/common';
import { EntryAnalyticsService } from './entry-analytics.service';
import { EntryAnalyticsController } from './entry-analytics.controller';

@Module({
  controllers: [EntryAnalyticsController],
  providers: [EntryAnalyticsService],
  exports: [EntryAnalyticsService],
})
export class EntryAnalyticsModule {}

