# ⚡ Coolify - Quick Start

## 🚨 O Problema

Você recebeu este erro porque o Coolify está configurado como **aplicação Docker simples**, mas este projeto usa **docker-compose com 3 serviços**.

## ✅ Solução Rápida

No Coolify, você precisa criar **3 recursos separados**:

### 1️⃣ Database (MySQL 8.0)
- Nome: `coven-mysql`
- Database: `coven`
- User: `coven_user`
- Password: escolha uma senha forte

### 2️⃣ Backend (Application)
- Repository: `https://github.com/DanielCayresFilho/coven.git`
- Branch: `main`
- **Base Directory**: `coven` ⚠️
- **Dockerfile Location**: `Dockerfile.prod` ⚠️
- **Port**: `3000`

**Environment Variables:**
```bash
NODE_ENV=production
PORT=3000
JWT_SECRET=<gere com: openssl rand -base64 32>
DATABASE_URL=mysql://coven_user:SUA_SENHA@coven-mysql:3306/coven
```

### 3️⃣ Frontend (Application)
- Repository: `https://github.com/DanielCayresFilho/coven.git`
- Branch: `main`
- **Base Directory**: `covenos-frontend` ⚠️
- **Dockerfile Location**: `Dockerfile.prod` ⚠️
- **Port**: `3000`

**Environment Variables:**
```bash
NODE_ENV=production
NUXT_PORT=3000
NUXT_PUBLIC_API_URL=https://api.seu-dominio.com
```

---

## 📖 Documentação Completa

Veja o arquivo **COOLIFY-SETUP.md** para instruções detalhadas passo a passo.

---

## 🔑 Pontos Críticos

1. **Base Directory** é OBRIGATÓRIO - sem ele, o Coolify não acha o Dockerfile
2. **Dockerfile Location** deve ser `Dockerfile.prod`
3. Deploy na ordem: Database → Backend → Frontend
4. Configure as variáveis de ambiente ANTES de fazer deploy

---

**Feito isso, o deploy vai funcionar!**
