#### Variables ####

export ROOT_DIR ?= $(PWD)
export KUBEADMIN_ROOT_DIR ?= $(ROOT_DIR)
export 5GC_ROOT_DIR ?= $(ROOT_DIR)

export HOSTS_INI_FILE ?= $(5GC_ROOT_DIR)/hosts.ini

export EXTRA_VARS ?= "@$(5GC_ROOT_DIR)/vars/main.yml"

# Install kubeadm, kubelet, kubectl, and containerd
kubeadmin-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/install.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) --tags install

# Uninstall kubeadm, kubelet, kubectl, and containerd
kubeadmin-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/install.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) --tags uninstall

# Restore swap after uninstallation (optional)
kubeadmin-restore-swap:
	ansible-playbook -i $(HOSTS_INI_FILE) $(KUBEADMIN_ROOT_DIR)/install.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) --tags restore-swap