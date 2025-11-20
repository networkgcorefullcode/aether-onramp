#### Variables ####

export ROOT_DIR ?= $(PWD)
export KUBEADMIN_ROOT_DIR ?= $(ROOT_DIR)
export HOSTS_INI_FILE ?= $(ROOT_DIR)/hosts.ini

#### Default target ####
.PHONY: help
help:
	@echo "Kubernetes cluster management with kubeadm"
	@echo ""
	@echo "Available targets:"
	@echo "  install         - Install complete Kubernetes cluster"
	@echo "  config          - Configure containerd on all nodes"
	@echo "  health          - Check health of all nodes"
	@echo "  health-master   - Check health of master nodes"
	@echo "  health-worker   - Check health of worker nodes"
	@echo "  uninstall       - Remove Kubernetes cluster (WIP)"
	@echo ""

#### a. Installation ####
.PHONY: install
install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/install.yml

#### b. Configuration ####
.PHONY: config
config:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/config.yml

#### c. Health checks ####
.PHONY: health
health:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/health.yml

.PHONY: health-master
health-master:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/health.yml --tags master

.PHONY: health-worker
health-worker:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/health.yml --tags worker

#### d. Uninstall (TODO) ####
.PHONY: uninstall
uninstall:
	@echo "Uninstall functionality not yet implemented"
	@echo "Manual steps required to remove Kubernetes cluster"
