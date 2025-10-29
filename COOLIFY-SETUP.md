# 🚀 Guia de Deploy no Coolify - Coven

## ⚠️ PROBLEMA IDENTIFICADO

O Coolify está procurando por um `Dockerfile` na raiz, mas seu projeto usa **docker-compose** com múltiplos serviços. No Coolify, você precisa criar **recursos separados** para cada serviço.

---

## ✅ SOLUÇÃO RECOMENDADA: Recursos Separados

### 📊 Arquitetura no Coolify

Você vai criar **3 recursos separados**:

1. **Database** (MySQL) - Recurso de banco de dados
2. **Backend** (NestJS) - Aplicação Docker
3. **Frontend** (Nuxt.js) - Aplicação Docker

---

## 🗄️ PASSO 1: Criar o Database (MySQL)

1. No Coolify, vá em **Databases**
2. Clique em **+ Add**
3. Selecione **MySQL** (versão 8.0)
4. Configure:
   - **Name**: `coven-mysql`
   - **Root Password**: `sua_senha_root_forte`
   - **Database Name**: `coven`
   - **Username**: `coven_user`
   - **Password**: `sua_senha_database_forte`
5. Clique em **Create**

### 📝 Anote as informações:
- **Internal Host**: Será algo como `coven-mysql` ou o nome do container
- **Port**: 3306
- **Database**: coven
- **User**: coven_user
- **Password**: a senha que você definiu

---

## 🔧 PASSO 2: Criar o Backend (NestJS)

1. No Coolify, vá em **Resources**
2. Clique em **+ Add Resource**
3. Selecione **Public Repository**
4. Configure:
   - **Repository URL**: `https://github.com/DanielCayresFilho/coven.git`
   - **Branch**: `main`
   - **Build Pack**: `Dockerfile`

### ⚙️ Configurações Importantes:

#### Base Directory
```
coven
```
*Este é o caminho onde está o Dockerfile.prod do backend*

#### Dockerfile Location
```
Dockerfile.prod
```

#### Port Exposes
```
3000
```

### 🔐 Environment Variables

Adicione estas variáveis (vá em **Environment Variables**):

```bash
NODE_ENV=production
PORT=3000
JWT_SECRET=gere_uma_string_aleatoria_forte_aqui
DATABASE_URL=mysql://coven_user:SUA_SENHA@coven-mysql:3306/coven
```

**⚠️ IMPORTANTE:**
- Substitua `SUA_SENHA` pela senha do MySQL que você criou no Passo 1
- Substitua `coven-mysql` pelo nome interno do seu database no Coolify
- Gere o JWT_SECRET com: `openssl rand -base64 32`

### 🌐 Domínio (opcional)
Configure um domínio para o backend, exemplo:
- `api.seu-dominio.com` ou
- Deixe usar o domínio gerado pelo Coolify

---

## 🎨 PASSO 3: Criar o Frontend (Nuxt.js)

1. No Coolify, vá em **Resources**
2. Clique em **+ Add Resource**
3. Selecione **Public Repository**
4. Configure:
   - **Repository URL**: `https://github.com/DanielCayresFilho/coven.git`
   - **Branch**: `main`
   - **Build Pack**: `Dockerfile`

### ⚙️ Configurações Importantes:

#### Base Directory
```
covenos-frontend
```

#### Dockerfile Location
```
Dockerfile.prod
```

#### Port Exposes
```
3000
```

### 🔐 Environment Variables

```bash
NODE_ENV=production
NUXT_PORT=3000
NUXT_PUBLIC_API_URL=https://api.seu-dominio.com
```

**⚠️ IMPORTANTE:**
- `NUXT_PUBLIC_API_URL` deve ser a URL **pública** do backend
- Se você configurou domínio para o backend, use: `https://api.seu-dominio.com`
- Se não, use a URL gerada pelo Coolify para o backend

### 🌐 Domínio
Configure o domínio principal da aplicação:
- `seu-dominio.com` ou `app.seu-dominio.com`

---

## 🔄 PASSO 4: Importar Backup do Banco

Após criar o database e o backend, você precisa importar o backup inicial.

### Opção A: Via Coolify UI
1. Acesse o Database no Coolify
2. Vá em **Backups** ou **Execute Command**
3. Importe o arquivo `coven_backup_20251023.sql`

### Opção B: Via SSH/Terminal
```bash
# Acesse o container do MySQL
docker exec -i <nome-do-container-mysql> mysql -u coven_user -p coven < coven_backup_20251023.sql
```

### Opção C: Após Backend Subir
O backend com Prisma pode criar as tabelas automaticamente:
```bash
# No container do backend, execute:
npx prisma migrate deploy
```

---

## 📋 ORDEM DE DEPLOY

Execute nesta ordem:

1. ✅ **Database** (MySQL) - Espere ficar online
2. ✅ **Backend** (NestJS) - Espere build e deploy completo
3. ✅ **Frontend** (Nuxt.js) - Aguarde backend estar funcionando

---

## 🔍 CHECKLIST DE VARIÁVEIS

### Database (MySQL)
- [ ] MYSQL_ROOT_PASSWORD configurado
- [ ] MYSQL_DATABASE = coven
- [ ] MYSQL_USER = coven_user
- [ ] MYSQL_PASSWORD configurado

### Backend
- [ ] NODE_ENV = production
- [ ] PORT = 3000
- [ ] JWT_SECRET (gerado com openssl rand -base64 32)
- [ ] DATABASE_URL aponta para o MySQL correto
- [ ] Base Directory = `coven`
- [ ] Dockerfile Location = `Dockerfile.prod`

### Frontend
- [ ] NODE_ENV = production
- [ ] NUXT_PORT = 3000
- [ ] NUXT_PUBLIC_API_URL aponta para backend público
- [ ] Base Directory = `covenos-frontend`
- [ ] Dockerfile Location = `Dockerfile.prod`

---

## 🔗 CONEXÃO ENTRE SERVIÇOS

```
┌─────────────────┐
│   Frontend      │
│  (Nuxt.js)      │
│  Port: 3000     │
└────────┬────────┘
         │
         │ NUXT_PUBLIC_API_URL
         │
         ▼
┌─────────────────┐
│   Backend       │
│  (NestJS)       │
│  Port: 3000     │
└────────┬────────┘
         │
         │ DATABASE_URL
         │
         ▼
┌─────────────────┐
│   Database      │
│  (MySQL 8.0)    │
│  Port: 3306     │
└─────────────────┘
```

---

## ⚠️ ERROS COMUNS

### 1. "Cannot connect to database"
- Verifique se o DATABASE_URL está correto
- Confirme que o nome do host do MySQL está certo (internal hostname no Coolify)
- Teste a conexão entre containers

### 2. "Frontend não carrega dados"
- Verifique se NUXT_PUBLIC_API_URL aponta para o backend correto
- Confirme que o backend está respondendo
- Verifique CORS no backend

### 3. "Build failed - Dockerfile not found"
- Confirme que Base Directory está correto (`coven` ou `covenos-frontend`)
- Confirme que Dockerfile Location = `Dockerfile.prod`

---

## 🧪 TESTAR DEPLOY

### 1. Testar Backend
```bash
curl https://api.seu-dominio.com/health
# ou
curl https://[coolify-url-do-backend]/health
```

### 2. Testar Database
Via Coolify UI ou connect ao container

### 3. Testar Frontend
Acesse a URL do frontend no navegador

---

## 📚 DOCUMENTAÇÃO ADICIONAL

- Veja `COOLIFY-ENV-VARS.md` para lista completa de variáveis
- Veja `.env.example` para referência de configuração

---

## 🆘 SUPORTE

Se ainda tiver erros:
1. Verifique os logs de cada serviço no Coolify
2. Confirme que todos os serviços estão "Running"
3. Verifique as environment variables estão corretas
4. Confirme que Base Directory e Dockerfile Location estão corretos

---

**Gerado automaticamente - Coven System**
