#### Variables ####

export ROOT_DIR ?= $(PWD)
export ARGOCD_ROOT_DIR ?= $(ROOT_DIR)

export HOSTS_INI_FILE ?= $(5GC_ROOT_DIR)/hosts.ini

export EXTRA_VARS ?= "@$(5GC_ROOT_DIR)/vars/main.yml"


### Provision ArgoCD ###
argocd-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(ARGOCD_ROOT_DIR)/argocd.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

argocd-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(ARGOCD_ROOT_DIR)/argocd.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)