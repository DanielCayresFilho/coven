# 🔧 Fix: Backend não conecta ao MySQL no Coolify

## ❌ Erro Atual
```
Can't reach database server at `coven-mysql:3306`
```

---

## ✅ SOLUÇÃO PASSO A PASSO

### 1️⃣ VERIFICAR SE O DATABASE FOI CRIADO

No Coolify:
1. Vá em **Databases**
2. Verifique se existe um Database MySQL criado
3. Verifique se o status está **"Running"** (verde)

**❌ Se NÃO existe:**
- Siga o **PASSO 1** do arquivo `COOLIFY-SETUP.md`
- Crie o Database MySQL ANTES de continuar

**✅ Se existe e está Running:**
- Continue para o próximo passo

---

### 2️⃣ OBTER O INTERNAL HOSTNAME CORRETO

No Coolify, acesse seu **Database MySQL**:

1. Clique no Database
2. Vá na aba **"Configuration"** ou **"Overview"**
3. Procure por:
   - **Internal Host** ou
   - **Internal Connection String** ou
   - **Internal IP/Hostname**

**Exemplos de Internal Hostname:**
- `coven-mysql` (se você nomeou assim)
- UUID gerado pelo Coolify (ex: `mysql-abc123`)
- IP interno (ex: `172.17.0.2`)

📝 **ANOTE O INTERNAL HOSTNAME** (vamos usar no próximo passo)

---

### 3️⃣ ATUALIZAR O DATABASE_URL NO BACKEND

No Coolify, acesse seu **Backend Application**:

1. Vá em **Environment Variables**
2. Localize a variável `DATABASE_URL`
3. **Atualize com o formato correto:**

```bash
DATABASE_URL=mysql://coven_user:SUA_SENHA@INTERNAL_HOSTNAME:3306/coven
```

**Substitua:**
- `SUA_SENHA` → Senha que você definiu no Database
- `INTERNAL_HOSTNAME` → Hostname interno obtido no Passo 2

**Exemplos corretos:**
```bash
# Exemplo 1: Se o internal hostname é "coven-mysql"
DATABASE_URL=mysql://coven_user:MinhaSenha123@coven-mysql:3306/coven

# Exemplo 2: Se o Coolify gerou UUID
DATABASE_URL=mysql://coven_user:MinhaSenha123@mysql-abc123def:3306/coven

# Exemplo 3: Se é um IP interno
DATABASE_URL=mysql://coven_user:MinhaSenha123@172.17.0.2:3306/coven
```

4. **Salve as alterações**

---

### 4️⃣ CONECTAR OS RECURSOS NA MESMA REDE

No Coolify, os recursos precisam estar na mesma rede Docker:

#### Opção A: Via UI (Recomendado)

1. No **Backend Application**, vá em **Networks**
2. Conecte à mesma rede do Database
3. Ou use a opção **"Connect to Database"** se disponível

#### Opção B: Via Configuração Manual

Certifique-se de que Backend e Database estão no mesmo:
- **Server** (mesmo host físico)
- **Docker Network** (mesma rede interna)

---

### 5️⃣ RESTART O BACKEND

Após ajustar o DATABASE_URL:

1. No Coolify, vá no **Backend Application**
2. Clique em **"Restart"** ou **"Redeploy"**
3. Aguarde o deploy completar
4. Verifique os logs

---

## 🔍 VERIFICAR SE FUNCIONOU

### Método 1: Logs do Backend
No Coolify, veja os logs do Backend:

**✅ Sucesso - Deve mostrar:**
```
[Nest] Nest application successfully started
[Nest] Application is running on: http://[::]:3000
```

**❌ Ainda com erro:**
```
Can't reach database server
```
→ Volte ao Passo 2 e verifique o hostname

---

### Método 2: Testar Endpoint
```bash
curl https://seu-backend.com/health
# ou
curl https://seu-backend.com/api/health
```

**✅ Se retornar 200 OK:** Está funcionando!

---

## 🆘 TROUBLESHOOTING AVANÇADO

### Problema: Ainda não conecta após ajustar DATABASE_URL

**Teste 1: Verificar se o MySQL está acessível**

No Coolify, acesse o **Terminal** do container do Backend e teste:

```bash
# Dentro do container do backend
nc -zv INTERNAL_HOSTNAME 3306
# ou
ping INTERNAL_HOSTNAME
```

**✅ Se conectar:** Problema nas credenciais
**❌ Se não conectar:** Problema de rede

---

### Problema: Erro de autenticação

```
Access denied for user 'coven_user'@'...'
```

**Solução:**
1. Verifique username e senha no DATABASE_URL
2. Confirme que são os mesmos definidos no Database
3. Recrie o Database se necessário

---

### Problema: Database não existe

```
Unknown database 'coven'
```

**Solução:**
1. No Database MySQL, verifique se o database `coven` foi criado
2. Ou ajuste o DATABASE_URL para o nome correto

---

## 📋 CHECKLIST FINAL

- [ ] Database MySQL criado e **Running**
- [ ] Internal Hostname obtido corretamente
- [ ] DATABASE_URL atualizado com hostname correto
- [ ] Username e senha corretos no DATABASE_URL
- [ ] Backend e Database na mesma rede Docker
- [ ] Backend reiniciado após mudanças
- [ ] Logs mostram "successfully started"

---

## 💡 DICA PRO

Se você está tendo dificuldade para conectar, uma alternativa é:

### Usar Recurso "Database" do Coolify com Auto-Connect

1. Ao criar o Backend, procure por opção **"Connect to existing database"**
2. Selecione o MySQL que você criou
3. O Coolify configura automaticamente a conexão
4. Ele cria a variável DATABASE_URL com o hostname correto

---

## 📚 PRÓXIMOS PASSOS

Após o Backend conectar com sucesso:

1. ✅ **Importar o backup do banco** (se ainda não fez)
2. ✅ **Configurar o Frontend** para apontar para o Backend
3. ✅ **Testar a aplicação completa**

Veja `COOLIFY-SETUP.md` para mais detalhes.

---

**Gerado automaticamente - Coven System**
