#### Variables ####

export ROOT_DIR ?= $(PWD)
export VAULT_ROOT_DIR ?= $(ROOT_DIR)

export HOSTS_INI_FILE ?= $(VAULT_ROOT_DIR)/hosts.ini

export EXTRA_VARS ?= "@$(VAULT_ROOT_DIR)/vars/main.yml"

#### Vault Deployment ####

deploy-dev:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags install

unseal:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags unseal

uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags uninstall

status:
	ansible -i $(HOSTS_INI_FILE) master_nodes -m shell \
		-a "VAULT_ADDR=http://127.0.0.1:8200 vault status" \
		--become