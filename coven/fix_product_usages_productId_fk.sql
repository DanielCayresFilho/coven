-- Corrigir foreign key do productId (mesmo problema de collation)

-- Passo 1: Remover foreign key existente
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND CONSTRAINT_NAME LIKE '%productId%'
LIMIT 1;

SET @sql = IFNULL(@sql, 'SELECT "Nenhuma foreign key encontrada" AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Passo 2: Corrigir collation do productId
ALTER TABLE `product_usages` 
MODIFY COLUMN `productId` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- Passo 3: Garantir que products.id também está correto
ALTER TABLE `products` 
MODIFY COLUMN `id` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- Passo 4: Criar foreign key
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_productId_fkey` 
FOREIGN KEY (`productId`) 
REFERENCES `products`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

