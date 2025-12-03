# Commands and Links

Serie de comandos ejecutados para crear el cluster de kubernetes, estos comandos son ejecutados despues de correr el comando `make kubeadmin-install`.

## Desarrollo

### Iniciar el control plane

```bash
sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --cri-socket /var/run/containerd/containerd.sock
```

### Habilitar kubectl

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Instalar Calico

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/tigera-operator.yaml
```

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/custom-resources.yaml
```

### Habilitar el nodo master para correr pods

```bash
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

### Deshabilitar el nodo master como nodo de control

```bash
kubectl taint nodes --all node-role.kubernetes.io/control-
```

### Excluir el node del backend server

```bash
kubectl label nodes --all node.kubernetes.io/exclude-from-external-load-balancers-
```

### Agregar workers nodes

<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#join-nodes>

- Linux: <https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-linux-nodes/>

### Agregar la config de kubectl en local para trabajar

<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#optional-controlling-your-cluster-from-machines-other-than-the-control-plane-node>

### Proxy para el API Server hacia nuestro local host

<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#optional-controlling-your-cluster-from-machines-other-than-the-control-plane-node>

### Clean up

<https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#tear-down>

### High Availability for Kubernetes

Topología: <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/>
Instalación: <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/>

### Validar configuración de Nodos

<https://kubernetes.io/docs/setup/best-practices/node-conformance/>

### Gateway API

<https://gateway-api.sigs.k8s.io/guides/>


### Configurar Gateway API

Instalar los CRDs para Gateway API

```bash
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml
```
