-- Script COMPLETO para corrigir TODAS as foreign keys de product_usages

-- 1. Remover foreign key do appointmentId (se existir)
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND CONSTRAINT_NAME LIKE '%appointmentId%'
LIMIT 1;
SET @sql = IFNULL(@sql, 'SELECT "FK appointmentId não encontrada" AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 2. Remover foreign key do productId (se existir)
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND CONSTRAINT_NAME LIKE '%productId%'
LIMIT 1;
SET @sql = IFNULL(@sql, 'SELECT "FK productId não encontrada" AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 3. Corrigir collations
ALTER TABLE `appointments` MODIFY COLUMN `id` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
ALTER TABLE `products` MODIFY COLUMN `id` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
ALTER TABLE `product_usages` MODIFY COLUMN `appointmentId` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
ALTER TABLE `product_usages` MODIFY COLUMN `productId` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- 4. Criar foreign keys
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) REFERENCES `appointments`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_productId_fkey` 
FOREIGN KEY (`productId`) REFERENCES `products`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

