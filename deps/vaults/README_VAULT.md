# HashiCorp Vault Deployment with Ansible

Este proyecto despliega HashiCorp Vault en modo desarrollo usando Ansible, basado en las mejores prácticas de la comunidad.

## Características

- Instalación automatizada de HashiCorp Vault
- Configuración de usuario y grupo dedicado para Vault
- Inicialización automática con generación de unseal keys y root token
- Almacenamiento seguro de claves en el directorio local
- Unsealing automático del vault
- Servicio systemd para gestión persistente

## Estructura del Proyecto

```
vaults/
├── Makefile                    # Comandos make para deployment
├── hosts.ini                   # Inventario de Ansible
├── deploy.yml                  # Playbook principal
├── vars/
│   └── main.yml               # Variables de configuración
└── roles/
    └── deploy_dev/
        ├── defaults/
        │   └── main.yml       # Variables por defecto
        ├── tasks/
        │   ├── main.yml       # Tareas principales
        │   ├── install.yml    # Instalación de Vault
        │   ├── unseal.yml     # Unsealing de Vault
        │   └── uninstall.yml  # Desinstalación
        ├── templates/
        │   ├── vault.hcl.j2   # Configuración de Vault
        │   └── vault.service.j2  # Servicio systemd
        └── handlers/
            └── main.yml       # Handlers de Ansible
```

## Prerequisitos

- Ansible 2.9 o superior
- Nodo(s) Linux con acceso SSH
- Privilegios sudo en los nodos target

## Configuración

### 1. Inventario (hosts.ini)

Configura tus nodos en `hosts.ini`:

```ini
[master_nodes]
coreGnbNode ansible_host=172.16.201.66 ansible_user=aether ansible_password=aether ansible_sudo_pass=aether
```

### 2. Variables (vars/main.yml)

Personaliza las variables según necesites:

```yaml
vault:
  version: "1.15.0"
  user: "vault"
  group: "vault"
  config_path: "/etc/vault.hcl"
  data_path: "/opt/vault/data"
  address: "http://0.0.0.0:8200"
```

## Uso

### Desplegar Vault

```bash
make deploy-dev
```

Este comando:
1. Crea el usuario y grupo vault
2. Descarga e instala el binario de Vault
3. Configura el servicio systemd
4. Inicializa Vault con 5 unseal keys (threshold de 3)
5. Guarda las unseal keys y root token en `vault_keys/`
6. Unseal automáticamente el vault

### Verificar Estado

```bash
make status
```

### Unseal Manual (después de reinicio)

```bash
make unseal
```

### Desinstalar

```bash
make uninstall
```

## Claves y Tokens

Después del deployment, las claves se almacenan en:

- **Unseal Keys**: `vault_keys/unseal_keys/unseal_key_0` a `unseal_key_4`
- **Root Token**: `vault_keys/root_token/rootkey`

⚠️ **IMPORTANTE**: Guarda estas claves de forma segura. Son necesarias para:
- Unseal del vault después de reinicios
- Operaciones administrativas (root token)

## Arquitectura de Seguridad

### Usuario Dedicado
- Usuario `vault` sin shell (`/sbin/nologin`)
- Sin directorio home
- Permisos mínimos necesarios

### Capacidades del Sistema
- `cap_ipc_lock+ep` habilitado para usar mlock sin root
- Previene swap de secretos a disco

### Almacenamiento
- Backend de archivo en `/opt/vault/data`
- Encriptación automática de datos en reposo

## Operaciones Post-Deployment

### Autenticar con Root Token

```bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat vault_keys/root_token/rootkey)
vault status
```

### Escribir un Secreto

```bash
vault write secret/content value=secretData
```

### Leer un Secreto

```bash
vault read secret/content
```

## Troubleshooting

### Vault está sellado

Si Vault se reinicia, quedará sellado. Ejecuta:

```bash
make unseal
```

### Ver logs del servicio

```bash
sudo journalctl -u vault -f
```

### Verificar conectividad

```bash
curl http://127.0.0.1:8200/v1/sys/health
```

## Próximos Pasos

Para entornos de producción, considera:

1. **TLS/HTTPS**: Habilitar TLS en el listener
2. **Backend HA**: Usar Consul o similar para alta disponibilidad
3. **Auto-unseal**: Configurar auto-unseal con cloud KMS
4. **Políticas**: Crear políticas de acceso granulares
5. **Audit Logs**: Habilitar audit logging
6. **Backup**: Implementar backup automático de datos

## Referencias

- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs/)
- [Vault Configuration](https://www.vaultproject.io/docs/configuration)
- [Production Hardening](https://learn.hashicorp.com/tutorials/vault/production-hardening)

## Licencia

Este proyecto sigue la licencia del proyecto Aether principal.
