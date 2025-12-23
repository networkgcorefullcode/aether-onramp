# Ansible to deploy HashiCorp Vault

Este proyecto implementa el despliegue automatizado de HashiCorp Vault usando Ansible, basado en las mejores prácticas de la comunidad.

## 🚀 Quick Start

```bash
# Desplegar Vault
make deploy-dev

# Verificar estado
make status

# Ver guía rápida
cat QUICKSTART.md
```

## Vaults Comparison

| Feature | Dev mode Vault | Self-managed Vault | HCP Vault Dedicated |
|---------|----------------|-------------------|---------------------|
| Storage backend | In-memory storage backend | Configurable storage backend | Integrated storage backend |
| Initialization and unsealing | Automatic initialization and unsealing | Requires initialization and unsealing | Automatic initialization and unsealing |
| Seal type | Shamir's Secret Sharing seal with a single key share | Configurable seal | Cloud auto seal |
| Root token | Initial root token automatically generated or specified at runtime | Initial root token part of unseal output | No root token; generate admin tokens in HCP UI |

## 📋 Características Implementadas

✅ **Instalación automatizada**

- Creación de usuario y grupo dedicado `vault`
- Descarga e instalación del binario de Vault
- Configuración de capacidades del sistema (mlock)

✅ **Configuración segura**

- Backend de almacenamiento en archivo
- Servicio systemd para gestión persistente
- Permisos y ownership correctos

✅ **Inicialización automática**

- Generación de 5 unseal keys (threshold: 3)
- Almacenamiento seguro local de keys y root token
- Unsealing automático post-inicialización

✅ **Operaciones**

- Deploy completo con un comando
- Unseal manual cuando sea necesario
- Backup y restore de claves
- Desinstalación limpia

## 📁 Estructura del Proyecto

```bash
vaults/
├── README.md                   # Este archivo
├── README_VAULT.md            # Documentación detallada
├── QUICKSTART.md              # Guía rápida de uso
├── Makefile                   # Comandos principales
├── hosts.ini                  # Inventario Ansible
├── ansible.cfg                # Configuración Ansible
├── deploy.yml                 # Playbook principal
├── .gitignore                 # Protección de datos sensibles
│
├── vars/
│   └── main.yml              # Variables de configuración
│
├── roles/
│   └── deploy_dev/
│       ├── defaults/
│       │   └── main.yml      # Variables por defecto
│       ├── tasks/
│       │   ├── main.yml      # Orquestador de tareas
│       │   ├── install.yml   # Instalación de Vault
│       │   ├── unseal.yml    # Unsealing de Vault
│       │   └── uninstall.yml # Desinstalación
│       ├── templates/
│       │   ├── vault.hcl.j2  # Configuración Vault
│       │   └── vault.service.j2  # Servicio systemd
│       └── handlers/
│           └── main.yml      # Handlers Ansible
│
├── scripts/
│   ├── populate_vault.sh     # Poblar con secretos ejemplo
│   └── backup_vault.sh       # Backup de vault keys
│
└── examples/
    └── secrets.example.yml   # Ejemplo de estructura de secretos
```

## 🔧 Instalación

### Prerequisitos

- Ansible 2.9+
- Acceso SSH a nodos target
- Privilegios sudo
- Sistema operativo Linux (Ubuntu/Debian/RHEL/CentOS)

### Paso 1: Configurar Inventario

Edita `hosts.ini` con tus nodos:

```ini
[master_nodes]
coreGnbNode ansible_host=172.16.201.66 ansible_user=aether ansible_password=aether ansible_sudo_pass=aether
```

### Paso 2: Personalizar Variables (Opcional)

Edita `vars/main.yml` si necesitas cambiar la configuración:

```yaml
vault:
  version: "1.15.0"
  address: "http://0.0.0.0:8200"
  data_path: "/opt/vault/data"
```

### Paso 3: Desplegar

```bash
make deploy-dev
```

## 📖 Comandos Disponibles

```bash
# Desplegar Vault completo
make deploy-dev

# Verificar estado
make status

# Unseal después de reinicio
make unseal

# Desinstalar completamente
make uninstall
```

## 🔐 Seguridad

### Claves Generadas

Después del deployment, las claves se guardan en:

```bash
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

⚠️ **CRÍTICO**:

- **NO** commitear estas claves a git (ya están en .gitignore)
- Guardar en un password manager seguro
- Considerar backup encriptado
- Rotar el root token en producción

### Backup de Claves

```bash
# Hacer backup
./scripts/backup_vault.sh

# Backup se guarda en vault_backups/
```

## 🎯 Uso Básico

### Autenticarse

```bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat vault_keys/root_token/rootkey)
```

### Operaciones con Secretos

```bash
# Habilitar KV v2
vault secrets enable -path=secret kv-v2

# Escribir secreto
vault kv put secret/myapp/config username=admin password=secret123

# Leer secreto
vault kv get secret/myapp/config

# Listar secretos
vault kv list secret/
```

### Poblar con Ejemplos

```bash
chmod +x scripts/populate_vault.sh
./scripts/populate_vault.sh
```

## 🏗️ Arquitectura

### Componentes

1. **Usuario vault**: Sistema user sin login ni home
2. **Vault Binary**: `/usr/local/bin/vault`
3. **Configuración**: `/etc/vault.hcl`
4. **Datos**: `/opt/vault/data`
5. **Servicio**: `systemd` unit `vault.service`
6. **API**: Puerto `8200`

### Flujo de Deployment

```bash
1. Crear usuario/grupo vault
2. Descargar e instalar binario
3. Configurar capacidades (mlock)
4. Crear directorios de datos
5. Copiar configuración
6. Instalar servicio systemd
7. Iniciar servicio
8. Inicializar Vault (unseal keys + root token)
9. Unseal automático
```

## 🔍 Troubleshooting

### Vault está sellado

```bash
make unseal
```

### No se puede conectar

```bash
# Verificar servicio
sudo systemctl status vault

# Ver logs
sudo journalctl -u vault -f

# Verificar puerto
sudo netstat -tulpn | grep 8200
```

### Permisos denegados

Verifica que estás usando el root token correcto:

```bash
export VAULT_TOKEN=$(cat vault_keys/root_token/rootkey)
vault status
```

## 📚 Point to know about Vaults

- Installation method
- General Concepts
- Features: Authentication Methods, Secret Engines, Policies, Encryption as a Service, Audit Devices

## 📖 Documentación Oficial

- [Vault Getting Started](https://developer.hashicorp.com/vault/tutorials/get-started)
- [Vault Install Binary](https://developer.hashicorp.com/vault/tutorials/get-started/install-binary)
- [Vault Setup Lab](https://developer.hashicorp.com/vault/tutorials/get-started/setup#set-up-the-lab)
- [Vault Configuration](https://www.vaultproject.io/docs/configuration)
- [Production Hardening](https://learn.hashicorp.com/tutorials/vault/production-hardening)

## 🎓 Recursos Adicionales

- **README_VAULT.md**: Documentación completa y detallada
- **QUICKSTART.md**: Guía rápida de referencia
- **examples/**: Ejemplos de configuración de secretos
- **scripts/**: Scripts útiles para operaciones

## 🤝 Contribución

Este proyecto está basado en:

- [Setup HashiCorp Vault Using Ansible - Medium](https://medium.com/@mitesh_shamra/setup-hashicorp-vault-using-ansible-fa8073a70a56)
- [AnsibleVaultRole - GitHub](https://github.com/MiteshSharma/AnsibleVaultRole)

## 📝 Licencia

Este proyecto sigue la licencia del proyecto Aether principal.
