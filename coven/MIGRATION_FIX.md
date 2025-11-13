# Correção: Coluna lastAppointmentAt não existe

## Problema
A coluna `lastAppointmentAt` está definida no schema do Prisma, mas não existe no banco de dados, causando o erro:
```
The column `coven.clients.lastAppointmentAt` does not exist in the current database.
```

## Solução Rápida (Aplicar SQL Manualmente)

Execute este SQL diretamente no seu banco de dados:

```sql
ALTER TABLE `clients`
  ADD COLUMN `lastAppointmentAt` DATETIME(3) NULL AFTER `observations`;
```

Ou use o arquivo `add_last_appointment_at.sql` que foi criado na raiz do projeto.

## Solução Automática (Reconstruir Docker)

O Dockerfile foi atualizado para aplicar migrations automaticamente na inicialização. Para usar:

1. Reconstrua a imagem do backend:
```bash
docker-compose -f docker-compose.prod.yml build backend
```

2. Reinicie o container:
```bash
docker-compose -f docker-compose.prod.yml up -d backend
```

As migrations serão aplicadas automaticamente na próxima inicialização.

## Migration Criada

A migration foi criada em:
`prisma/migrations/20251113120000_add_last_appointment_at_to_clients/migration.sql`

## Verificação

Após aplicar a migration, verifique se a coluna existe:
```sql
DESCRIBE clients;
```

Você deve ver a coluna `lastAppointmentAt` na lista.

