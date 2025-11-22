-- Script para corrigir a foreign key incompatível em product_usages
-- Este script verifica e corrige os tipos das colunas para serem compatíveis

-- Passo 1: Verificar e corrigir o tipo da coluna id na tabela appointments
-- No MySQL, UUIDs podem ser CHAR(36) ou VARCHAR(191), vamos garantir compatibilidade
-- Primeiro, vamos ver qual é o tipo atual e corrigir se necessário
ALTER TABLE `appointments` 
MODIFY COLUMN `id` VARCHAR(191) NOT NULL;

-- Passo 2: Garantir que o tipo da coluna appointmentId está correto e compatível
ALTER TABLE `product_usages` 
MODIFY COLUMN `appointmentId` VARCHAR(191) NOT NULL;

-- Passo 3: Remover qualquer foreign key existente relacionada a appointmentId
-- Buscar todas as foreign keys que referenciam appointmentId
SET @sql = NULL;
SELECT CONCAT('ALTER TABLE `product_usages` DROP FOREIGN KEY `', CONSTRAINT_NAME, '`')
INTO @sql
FROM information_schema.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND CONSTRAINT_NAME LIKE '%appointmentId%'
LIMIT 1;

-- Se encontrou uma foreign key, remove
SET @sql = IFNULL(@sql, 'SELECT "Nenhuma foreign key encontrada para remover" AS message');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Passo 4: Criar a foreign key com os tipos corretos
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) 
REFERENCES `appointments`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;
