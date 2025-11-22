# Instruções de Deploy - Correção Foreign Key

## ⚠️ IMPORTANTE: Execute o script SQL ANTES do deploy

Antes de fazer commit e deploy, você precisa executar o script SQL para corrigir a foreign key incompatível.

## Passo a Passo:

### 1. Execute o script SQL no banco de dados

**Opção A: Via terminal (se tiver acesso SSH ao servidor)**
```bash
# Conecte-se ao container do banco ou servidor MySQL
mysql -h usco88cc4o80kkkgcwccc0g4 -P 3306 -u seu_usuario -p coven < fix_product_usages_fk.sql
```

**Opção B: Via cliente MySQL (phpMyAdmin, MySQL Workbench, etc)**
1. Conecte-se ao banco de dados
2. Selecione o banco `coven`
3. Execute o conteúdo do arquivo `fix_product_usages_fk.sql`

**Opção C: Via Coolify (se tiver acesso ao terminal do container)**
```bash
# Entre no container do backend
docker exec -it <container_id> sh

# Execute o script (você precisará ter o mysql client instalado ou usar prisma)
npx prisma db execute --file fix_product_usages_fk.sql
```

### 2. Depois de executar o script SQL

1. **Commit as mudanças:**
   ```bash
   git add .
   git commit -m "feat: adiciona clientId no EntryAnalytic e sincroniza procedures com EntryMoneyCategory"
   git push
   ```

2. **Faça o deploy no Coolify**
   - O Coolify vai fazer o build e deploy automaticamente
   - O `npx prisma db push` será executado automaticamente no entrypoint

### 3. Verificação

Após o deploy, verifique se tudo está funcionando:
- A aplicação deve iniciar sem erros
- As novas funcionalidades devem estar disponíveis

## Nota

Se você não conseguir executar o script SQL antes do deploy, o `npx prisma db push` vai falhar com o erro de foreign key. Nesse caso:
1. Execute o script SQL manualmente
2. Faça o deploy novamente

