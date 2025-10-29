# 🔐 Fix: MySQL SSL Required no Coolify

## ❌ Erro
```
ERROR HY000 (3159): Connections using insecure transport are prohibited while --require_secure_transport=ON
```

---

## ✅ SOLUÇÃO

O MySQL do Coolify exige SSL, mas o Prisma precisa ser configurado para aceitar certificados auto-assinados.

### 🔧 Modificar DATABASE_URL

No Coolify, vá no **Backend Application** → **Environment Variables**

#### ❌ URL que NÃO funciona:
```bash
DATABASE_URL=mysql://user:password@host:3306/coven?ssl-mode=REQUIRED
```

#### ✅ URL CORRIGIDA (opção 1 - recomendada):
```bash
DATABASE_URL=mysql://user:password@host:3306/coven?sslaccept=strict
```

#### ✅ URL CORRIGIDA (opção 2 - alternativa):
```bash
DATABASE_URL=mysql://user:password@host:3306/coven?ssl={"rejectUnauthorized":false}
```

---

## 📋 Passo a Passo Completo

### 1. Obter DATABASE_URL do MySQL

No Coolify:
1. Vá em **Databases**
2. Clique no seu MySQL
3. Copie a **Internal Connection String**

Exemplo:
```
mysql://mysql:%40D4n63rl0lX%3C%3E82@h08sck8sk0w0kwgc0ows0oow:3306/coven?ssl-mode=REQUIRED
```

### 2. Modificar a URL

**ANTES:**
```
...@host:3306/coven?ssl-mode=REQUIRED
```

**DEPOIS:**
```
...@host:3306/coven?sslaccept=strict
```

### 3. Aplicar no Backend

1. No Coolify, vá no **Backend Application**
2. **Environment Variables**
3. Edite `DATABASE_URL`
4. Cole a URL modificada
5. **Salve**

### 4. Restart

1. No Backend, clique em **Restart** ou **Redeploy**
2. Aguarde o deploy completar
3. Verifique os logs

---

## 🔍 Verificar se Funcionou

### ✅ Sucesso nos Logs:
```
[Nest] Nest application successfully started
[Nest] Application is running on: http://[::]:3000
```

### ❌ Ainda com erro:

**Erro 1: Can't reach database server**
→ Volte ao passo 1 e verifique o hostname

**Erro 2: Access denied**
→ Verifique username e senha na URL

**Erro 3: Unknown database**
→ Verifique o nome do database

---

## 💡 Por que isso é necessário?

- **Coolify** usa MySQL com SSL obrigatório por segurança
- O MySQL tem certificados **auto-assinados** (não verificados por CA)
- **Prisma** por padrão **rejeita** certificados não verificados
- `sslaccept=strict` faz o Prisma **aceitar** esses certificados

---

## 🔐 Parâmetros SSL do Prisma/MySQL

### sslaccept=strict
- ✅ Aceita qualquer certificado SSL
- ✅ Mais simples
- ✅ Recomendado para Coolify

### ssl={"rejectUnauthorized":false}
- ✅ Aceita certificados não verificados
- ⚠️ Sintaxe mais complexa
- ✅ Alternativa válida

### ssl-mode=REQUIRED (NÃO funciona)
- ❌ Exige SSL mas valida certificado
- ❌ Falha com certificados auto-assinados

---

## 📚 Referências

- [Prisma MySQL SSL](https://www.prisma.io/docs/orm/overview/databases/mysql#configuring-an-ssl-connection)
- [Coolify Database SSL](https://coolify.io/docs/databases/mysql)

---

**Gerado automaticamente - Coven System**
