# Guía Rápida - Vault Deployment

## Comandos Principales

### 1. Desplegar Vault
```bash
cd deps/vaults
make deploy-dev
```

### 2. Ver Estado
```bash
make status
```

### 3. Unseal después de reinicio
```bash
make unseal
```

### 4. Desinstalar
```bash
make uninstall
```

## Acceso a Vault

### Variables de Entorno
```bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat vault_keys/root_token/rootkey)
```

### Comandos Básicos
```bash
# Ver estado
vault status

# Escribir secreto
vault write secret/myapp/config username=admin password=secret123

# Leer secreto
vault read secret/myapp/config

# Listar secretos
vault list secret/

# Habilitar engine de secretos
vault secrets enable -path=kv kv-v2

# Escribir secreto en KV v2
vault kv put kv/myapp/config username=admin password=secret123

# Leer secreto de KV v2
vault kv get kv/myapp/config
```

## Estructura de Archivos Generados

```
vault_keys/
├── unseal_keys/
│   ├── unseal_key_0
│   ├── unseal_key_1
│   ├── unseal_key_2
│   ├── unseal_key_3
│   └── unseal_key_4
└── root_token/
    └── rootkey
```

## URLs Útiles

- **API**: http://localhost:8200
- **UI**: http://localhost:8200/ui (si está habilitada)

## Unseal Manual

Si necesitas unseal manualmente:

```bash
vault operator unseal $(cat vault_keys/unseal_keys/unseal_key_0)
vault operator unseal $(cat vault_keys/unseal_keys/unseal_key_1)
vault operator unseal $(cat vault_keys/unseal_keys/unseal_key_2)
```

## Verificación

```bash
# Check si está sellado
vault status | grep Sealed

# Check salud
curl http://127.0.0.1:8200/v1/sys/health

# Ver logs
sudo journalctl -u vault -f --no-pager
```

## Troubleshooting

### Problema: Vault está sellado
**Solución**: `make unseal`

### Problema: No se puede conectar
**Solución**: 
1. Verificar servicio: `sudo systemctl status vault`
2. Ver logs: `sudo journalctl -u vault -n 50`
3. Verificar puerto: `sudo netstat -tulpn | grep 8200`

### Problema: Permisos denegados
**Solución**: Verificar que estés usando el root token correcto
```bash
export VAULT_TOKEN=$(cat vault_keys/root_token/rootkey)
```
