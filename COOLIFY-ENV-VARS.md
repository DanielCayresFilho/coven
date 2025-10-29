# Variáveis de Ambiente para Coolify - Coven

## ⚠️ VARIÁVEIS OBRIGATÓRIAS

### 🔐 MySQL Database

```bash
MYSQL_ROOT_PASSWORD=your_strong_root_password_here
MYSQL_DATABASE=coven
MYSQL_USER=coven_user
MYSQL_PASSWORD=your_strong_database_password_here
```

### 🔑 Backend

```bash
DATABASE_URL=mysql://coven_user:your_strong_database_password_here@db:3306/coven
JWT_SECRET=your_very_strong_secret_key_min_32_chars
```

**⚠️ IMPORTANTE:**
- O `DATABASE_URL` deve usar as mesmas credenciais do MySQL
- O `JWT_SECRET` deve ser uma string aleatória forte (mínimo 32 caracteres)
- Gere com: `openssl rand -base64 32` ou similar

### 🌐 Frontend

```bash
NUXT_PUBLIC_API_URL=https://api.seu-dominio.com
```

**⚠️ IMPORTANTE:**
- Em produção, use a URL real da API (ex: https://api.covenos.com.br)
- Não use localhost em produção

---

## 📌 VARIÁVEIS OPCIONAIS (com valores padrão)

### Portas

```bash
MYSQL_PORT=3307          # Porta externa do MySQL (padrão: 3307)
BACKEND_PORT=3009        # Porta externa do backend (padrão: 3009)
FRONTEND_PORT=3010       # Porta externa do frontend (padrão: 3010)
```

### Configurações Gerais

```bash
NODE_ENV=production      # Ambiente (padrão: production)
PORT=3000               # Porta interna do backend (padrão: 3000)
NUXT_PORT=3000          # Porta interna do frontend (padrão: 3000)
```

### Backup

```bash
MYSQL_INIT_SCRIPT=./coven_backup_20251023.sql  # Script SQL inicial
```

---

## 📋 CHECKLIST PARA COOLIFY

- [ ] **Criar todas as variáveis obrigatórias** (seção acima)
- [ ] **Gerar JWT_SECRET forte** com `openssl rand -base64 32`
- [ ] **Configurar NUXT_PUBLIC_API_URL** com domínio real
- [ ] **Ajustar DATABASE_URL** com mesmas credenciais do MySQL
- [ ] **Definir senhas fortes** para MySQL (root e user)
- [ ] **Verificar portas disponíveis** no servidor
- [ ] **Ajustar MYSQL_INIT_SCRIPT** se necessário

---

## 🚀 EXEMPLO COMPLETO

```bash
# MySQL
MYSQL_ROOT_PASSWORD=SuperSecureRoot@2024!
MYSQL_DATABASE=coven
MYSQL_USER=coven_user
MYSQL_PASSWORD=SecureDBPass@2024!

# Backend
DATABASE_URL=mysql://coven_user:SecureDBPass@2024!@db:3306/coven
JWT_SECRET=a8f5f167f44f4964e6c998dee827110c00000000000000000000000000000000
NODE_ENV=production
PORT=3000

# Frontend
NUXT_PUBLIC_API_URL=https://api.covenos.com.br
NUXT_PORT=3000

# Portas (opcional)
MYSQL_PORT=3307
BACKEND_PORT=3009
FRONTEND_PORT=3010
```

---

## 💡 DICAS

1. **Senhas Fortes**: Use geradores de senha ou comandos como:
   ```bash
   openssl rand -base64 24
   ```

2. **JWT Secret**: Gere sempre um novo:
   ```bash
   openssl rand -base64 32
   ```

3. **URLs em Produção**: Sempre use HTTPS e domínios reais

4. **Backup**: O arquivo `coven_backup_20251023.sql` será carregado automaticamente na primeira inicialização

5. **Portas**: Se já houver serviços nas portas padrão, ajuste conforme necessário

---

## ⚙️ COMO APLICAR NO COOLIFY

1. Acesse seu projeto no Coolify
2. Vá em **Environment Variables**
3. Adicione cada variável da seção **OBRIGATÓRIAS**
4. Ajuste as variáveis **OPCIONAIS** se necessário
5. Salve e faça o deploy

---

**Gerado automaticamente - Coven System**
