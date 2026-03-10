-- AlterTable: Expand text columns from VARCHAR(191) to TEXT

ALTER TABLE `clients` MODIFY COLUMN `address` TEXT NULL;
ALTER TABLE `clients` MODIFY COLUMN `observations` TEXT NULL;

ALTER TABLE `procedures` MODIFY COLUMN `description` TEXT NULL;

ALTER TABLE `products` MODIFY COLUMN `description` TEXT NULL;

ALTER TABLE `stock_movements` MODIFY COLUMN `reason` TEXT NULL;

ALTER TABLE `appointments` MODIFY COLUMN `paymentData` TEXT NULL;
ALTER TABLE `appointments` MODIFY COLUMN `observations` TEXT NULL;

ALTER TABLE `entry_analytics` MODIFY COLUMN `description` TEXT NULL;

ALTER TABLE `out_analytics` MODIFY COLUMN `description` TEXT NULL;

ALTER TABLE `reminders` MODIFY COLUMN `description` TEXT NULL;

ALTER TABLE `fixed_expenses` MODIFY COLUMN `description` TEXT NULL;
