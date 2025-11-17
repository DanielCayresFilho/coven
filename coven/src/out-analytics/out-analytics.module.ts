import { Module } from '@nestjs/common';
import { OutAnalyticsService } from './out-analytics.service';
import { OutAnalyticsController } from './out-analytics.controller';

@Module({
  controllers: [OutAnalyticsController],
  providers: [OutAnalyticsService],
  exports: [OutAnalyticsService],
})
export class OutAnalyticsModule {}

