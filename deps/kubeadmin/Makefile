#### Variables ####

export ROOT_DIR ?= $(PWD)
export KUBEADMIN_ROOT_DIR ?= $(ROOT_DIR)
export 5GC_ROOT_DIR ?= $(ROOT_DIR)

export HOSTS_INI_FILE ?= $(5GC_ROOT_DIR)/hosts.ini

export EXTRA_VARS ?= "@$(5GC_ROOT_DIR)/vars/main.yml"
kubeadmin-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/install.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

kubeadmin-config:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/config.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

kubeadmin-health:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/health.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

kubeadmin-health-master:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/health.yml --tags master \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

kubeadmin-health-worker:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/health.yml --tags worker \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

kubeadmin-uninstall:
	@echo "Uninstall functionality not yet implemented"
	@echo "Manual steps required to remove Kubernetes cluster"
