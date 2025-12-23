#### Variables ####

export ROOT_DIR ?= $(PWD)
export ARGOCD_ROOT_DIR ?= $(ROOT_DIR)

export HOSTS_INI_FILE ?= $(5GC_ROOT_DIR)/hosts.ini

export EXTRA_VARS ?= "@$(5GC_ROOT_DIR)/vars/main.yml"


### Provision ArgoCD ###
fleet-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(ARGOCD_ROOT_DIR)/fleet_ansible.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

fleet-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(ARGOCD_ROOT_DIR)/fleet_ansible.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)