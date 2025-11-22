-- Script ALTERNATIVO caso a coluna id seja CHAR(36) em vez de VARCHAR(191)
-- Execute este se o script final ainda der erro

-- Passo 1: Verificar se id é CHAR(36) e corrigir appointmentId para ser igual
-- Se appointments.id for CHAR(36), use este:
ALTER TABLE `product_usages` 
MODIFY COLUMN `appointmentId` CHAR(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- OU se for VARCHAR, use este:
-- ALTER TABLE `product_usages` 
-- MODIFY COLUMN `appointmentId` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- Passo 2: Remover foreign keys existentes
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
LIMIT 1;

SET @sql = IFNULL(@sql, 'SELECT "Nenhuma foreign key encontrada" AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Passo 3: Criar a foreign key
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) 
REFERENCES `appointments`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

