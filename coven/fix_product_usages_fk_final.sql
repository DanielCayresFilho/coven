-- Script FINAL para corrigir a foreign key incompatível
-- Este script verifica os tipos atuais e os corrige para serem EXATAMENTE iguais

-- Primeiro, vamos verificar e corrigir os tipos para serem idênticos
-- O problema pode ser charset, collation ou tamanho diferente

-- Passo 1: Verificar o tipo atual da coluna id em appointments
-- (Execute este comando separadamente para ver o tipo atual)
-- DESCRIBE `appointments`;

-- Passo 2: Corrigir a coluna id em appointments para VARCHAR(191) com charset e collation explícitos
ALTER TABLE `appointments` 
MODIFY COLUMN `id` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- Passo 3: Corrigir a coluna appointmentId em product_usages para ser EXATAMENTE igual
ALTER TABLE `product_usages` 
MODIFY COLUMN `appointmentId` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- Passo 4: Remover qualquer foreign key existente (se houver)
-- Lista todas as foreign keys da tabela
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
LIMIT 1;

-- Se encontrou, remove
SET @sql = IFNULL(@sql, 'SELECT "Nenhuma foreign key encontrada" AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Passo 5: Criar a foreign key
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) 
REFERENCES `appointments`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

