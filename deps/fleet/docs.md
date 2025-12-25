```
Ansible
 ├─ prepara cluster(s)
 ├─ instala Fleet (si hace falta)
 └─ crea recursos GitRepo

Fleet (en Rancher)
 └─ observa Git

GitOps Repo
 ├─ dev/
 ├─ prod/
 └─ common/

Fleet Agent (por cluster)
 └─ ejecuta Helm
```

👉 **Ansible NO despliega apps**
👉 **Fleet SÍ despliega apps**
👉 **Helm lo ejecuta Fleet**

---

# 🧩 Paso 1: Estructura de repositorios (RECOMENDADO)

## 📁 Repo 1 — Infra / Ansible

```
infra-ansible/
├─ inventories/
│  ├─ dev/
│  │  ├─ hosts.yaml
│  │  └─ group_vars/
│  └─ prod/
│     ├─ hosts.yaml
│     └─ group_vars/
├─ roles/
│  ├─ fleet_bootstrap/
│  ├─ fleet_clusters/
│  └─ rancher_access/
└─ playbooks/
   ├─ fleet-dev.yaml
   └─ fleet-prod.yaml
```

---

## 📁 Repo 2 — GitOps (Fleet)

```
gitops-fleet/
├─ fleet.yaml
├─ common/
│  └─ vault/
├─ dev/
│  └─ aether/
│     ├─ fleet.yaml
│     └─ values-dev.yaml
└─ prod/
   └─ aether/
      ├─ fleet.yaml
      └─ values-prod.yaml
```

---

# 🧱 Paso 2: Ansible Role – `fleet_bootstrap`

Este role:

* verifica acceso a cluster
* instala Fleet (si no viene con Rancher)
* configura namespaces

### roles/fleet_bootstrap/tasks/main.yml

```yaml
- name: Create fleet namespace
  kubernetes.core.k8s:
    api_version: v1
    kind: Namespace
    name: cattle-fleet-system
    state: present
```

> En Rancher normalmente Fleet ya viene, este role puede ser noop.

---

# 🧱 Paso 3: Ansible Role – `fleet_clusters`

Este es el **role más importante**.

Crea recursos `GitRepo` **por entorno**.

---

## 📌 Template GitRepo (Jinja2)

### roles/fleet_clusters/templates/gitrepo.yaml.j2

```yaml
apiVersion: fleet.cattle.io/v1alpha1
kind: GitRepo
metadata:
  name: {{ fleet_name }}
  namespace: fleet-local
spec:
  repo: {{ fleet_repo_url }}
  branch: {{ fleet_branch }}
  paths:
    - {{ fleet_path }}
  targets:
    - clusterSelector:
        matchLabels:
          env: {{ env }}
```

---

## 📌 Task del role

### roles/fleet_clusters/tasks/main.yml

```yaml
- name: Apply Fleet GitRepo
  kubernetes.core.k8s:
    state: present
    definition: "{{ lookup('template', 'gitrepo.yaml.j2') }}"
```

---

# 🧱 Paso 4: Playbooks por entorno

## DEV

### playbooks/fleet-dev.yaml

```yaml
- name: Fleet DEV setup
  hosts: dev_cluster
  roles:
    - role: fleet_clusters
      vars:
        env: dev
        fleet_name: aether-dev
        fleet_repo_url: https://github.com/org/gitops-fleet
        fleet_branch: main
        fleet_path: dev
```

---

## PROD

### playbooks/fleet-prod.yaml

```yaml
- name: Fleet PROD setup
  hosts: prod_cluster
  roles:
    - role: fleet_clusters
      vars:
        env: prod
        fleet_name: aether-prod
        fleet_repo_url: https://github.com/org/gitops-fleet
        fleet_branch: main
        fleet_path: prod
```

---

# 🧱 Paso 5: Configurar Fleet para Helm

En el repo GitOps:

---

## 📄 dev/aether/fleet.yaml

```yaml
defaultNamespace: aether-5gc

helm:
  chart: sd-core
  repo: https://charts.aetherproject.org
  releaseName: sd-core
  valuesFiles:
    - values-dev.yaml
```

---

## 📄 prod/aether/fleet.yaml

```yaml
defaultNamespace: aether-5gc

helm:
  chart: sd-core
  repo: https://charts.aetherproject.org
  releaseName: sd-core
  valuesFiles:
    - values-prod.yaml
```

---

# 🧱 Paso 6: Diferenciar DEV vs PROD (Best Practice)

### Clusters etiquetados en Rancher

```yaml
env=dev
env=prod
```

Fleet usa esto:

```yaml
clusterSelector:
  matchLabels:
    env: dev
```