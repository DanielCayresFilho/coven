-- Script SIMPLIFICADO para corrigir a foreign key
-- Execute este script linha por linha se o script completo der erro

-- 1. Corrigir tipo da coluna id em appointments
ALTER TABLE `appointments` MODIFY COLUMN `id` VARCHAR(191) NOT NULL;

-- 2. Corrigir tipo da coluna appointmentId em product_usages  
ALTER TABLE `product_usages` MODIFY COLUMN `appointmentId` VARCHAR(191) NOT NULL;

-- 3. Remover foreign key existente (execute apenas se existir)
-- Descomente a linha abaixo e execute se souber o nome exato da foreign key:
-- ALTER TABLE `product_usages` DROP FOREIGN KEY `nome_da_foreign_key_aqui`;

-- 4. Criar a foreign key
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) 
REFERENCES `appointments`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

