-- Script para corrigir a COLLATION incompatível
-- O problema é que as colunas têm collations diferentes:
-- appointments.id: utf8mb4_unicode_ci
-- product_usages.appointmentId: utf8mb4_0900_ai_ci

-- Passo 1: Remover a foreign key existente (se existir)
-- Buscar todas as foreign keys da tabela product_usages
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND (CONSTRAINT_NAME LIKE '%appointmentId%' OR CONSTRAINT_NAME = 'product_usages_appointmentId_fkey')
LIMIT 1;

-- Se encontrou, remove
SET @sql = IFNULL(@sql, 'SELECT "Nenhuma foreign key encontrada para remover" AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Passo 2: Corrigir a collation da coluna appointmentId para ser igual à coluna id
ALTER TABLE `product_usages` 
MODIFY COLUMN `appointmentId` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- Passo 3: Criar a foreign key (agora as collations são compatíveis)
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) 
REFERENCES `appointments`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

