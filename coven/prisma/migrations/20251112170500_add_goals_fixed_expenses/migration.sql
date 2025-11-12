-- Alter products to support usable amount for internal-use items
ALTER TABLE `products`
  ADD COLUMN IF NOT EXISTS `usableAmount` DECIMAL(10, 2) NULL AFTER `unitMeasurement`;

-- Extend reminders enum with DESPESA_FIXA
ALTER TABLE `reminders`
MODIFY COLUMN `type`
    ENUM('ANIVERSARIO', 'MANUAL', 'PRODUTO_BAIXO', 'AGENDAMENTO', 'DESPESA_FIXA')
    NOT NULL;

-- Create goals table for monthly/weekly targets
CREATE TABLE IF NOT EXISTS `goals` (
  `id` VARCHAR(191) NOT NULL,
  `period` ENUM('SEMANAL', 'MENSAL') NOT NULL,
  `targetAmount` DECIMAL(10, 2) NOT NULL,
  `currentAmount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
  `startDate` DATETIME(3) NOT NULL,
  `endDate` DATETIME(3) NOT NULL,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` DATETIME(3) NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create fixed expenses table for recurring costs
CREATE TABLE IF NOT EXISTS `fixed_expenses` (
  `id` VARCHAR(191) NOT NULL,
  `name` VARCHAR(191) NOT NULL,
  `amount` DECIMAL(10, 2) NOT NULL,
  `dueDay` INT NOT NULL,
  `description` VARCHAR(191) DEFAULT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` DATETIME(3) NOT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

