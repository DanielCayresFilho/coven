-- Script para corrigir a foreign key incompatível em product_usages
-- Execute este script antes de rodar npx prisma db push
-- 
-- NOTA: Se der erro ao remover a foreign key, significa que ela não existe
-- e você pode ignorar o erro e continuar

-- Passo 1: Garantir que o tipo da coluna appointmentId está correto
ALTER TABLE `product_usages` 
MODIFY COLUMN `appointmentId` VARCHAR(191) NOT NULL;

-- Passo 2: Remover a foreign key existente (se existir)
-- Se der erro 1091 "Can't DROP", significa que não existe - IGNORE o erro e continue
-- Você pode comentar esta linha se já souber que não existe
-- ALTER TABLE `product_usages` DROP FOREIGN KEY `product_usages_appointmentId_fkey`;

-- Passo 3: Criar a foreign key com os tipos corretos
-- Se já existir, vai dar erro - nesse caso, a foreign key já está correta
ALTER TABLE `product_usages` 
ADD CONSTRAINT `product_usages_appointmentId_fkey` 
FOREIGN KEY (`appointmentId`) 
REFERENCES `appointments`(`id`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;
