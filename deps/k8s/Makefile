#### Variables ####

export ROOT_DIR ?= $(PWD)
export K8S_ROOT_DIR ?= $(ROOT_DIR)

export EXTRA_VARS ?= ""

#### a. Debugging ####
k8s-debug:
	ansible-playbook -i /home/abelct/aether/aether-onramp/deps/k8s/inventory/storage/hosts.yml $(K8S_ROOT_DIR)/debug.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

#### b. Provision k8s ####
k8s-install: k8s-rke2-install k8s-helm-install
k8s-uninstall: k8s-helm-uninstall k8s-rke2-uninstall

#### c. Provision rke2 ####
k8s-rke2-install:
	ansible-playbook -i /home/abelct/aether/aether-onramp/deps/k8s/inventory/storage/hosts.yml $(K8S_ROOT_DIR)/rke2.yml --tags install
#### --extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
k8s-rke2-uninstall:
	ansible-playbook -i /home/abelct/aether/aether-onramp/deps/k8s/inventory/storage/hosts.yml $(K8S_ROOT_DIR)/rke2.yml --tags uninstall
#### --extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

#### d. Provision helm ####
k8s-helm-install:
	ansible-playbook -i /home/abelct/aether/aether-onramp/deps/k8s/inventory/storage/hosts.yml $(K8S_ROOT_DIR)/helm.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
k8s-helm-uninstall:
	ansible-playbook -i /home/abelct/aether/aether-onramp/deps/k8s/inventory/storage/hosts.yml $(K8S_ROOT_DIR)/helm.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)



#### cambiar la variable $(HOSTS_INI_FILE) por el archivo host.yml con la sintaxis nueva

#### $(K8S_ROOT_DIR) esta variable si debe estar bien

#### $(EXTRA_VARS) esta variable no hace nada

#### k8s-rke2-uninstall: este target de make hay quen hacerlo
