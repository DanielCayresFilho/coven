-- Script para inserir TODOS os procedimentos ativos na tabela entry_money_categories
-- Execute este script para sincronizar os procedimentos com as categorias de entrada

INSERT INTO `entry_money_categories` (`id`, `name`, `createdAt`, `updatedAt`)
SELECT 
    UUID() as id,
    p.name as name,
    NOW() as createdAt,
    NOW() as updatedAt
FROM `procedures` p
WHERE p.active = 1
  AND p.name NOT IN (SELECT name FROM `entry_money_categories`);
