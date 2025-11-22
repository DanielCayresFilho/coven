-- Script para VERIFICAR os tipos atuais das colunas
-- Execute este primeiro para ver qual é o problema

-- Verificar tipo da coluna id em appointments
SELECT 
    COLUMN_NAME,
    COLUMN_TYPE,
    CHARACTER_SET_NAME,
    COLLATION_NAME,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'appointments'
  AND COLUMN_NAME = 'id';

-- Verificar tipo da coluna appointmentId em product_usages
SELECT 
    COLUMN_NAME,
    COLUMN_TYPE,
    CHARACTER_SET_NAME,
    COLLATION_NAME,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND COLUMN_NAME = 'appointmentId';

-- Verificar foreign keys existentes
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'product_usages'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

