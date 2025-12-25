#### Variables ####

export ROOT_DIR ?= $(PWD)
export VAULT_ROOT_DIR ?= $(ROOT_DIR)

export HOSTS_INI_FILE ?= $(VAULT_ROOT_DIR)/hosts.ini

export EXTRA_VARS ?= "@$(VAULT_ROOT_DIR)/vars/main.yml"

#### Vault Deployment ####

vault-deploy-dev:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy_dev.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags install

vault-unseal-dev:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy_dev.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags unseal

vault-uninstall-dev:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy_dev.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags uninstall

vault-status-dev:
	ansible -i $(HOSTS_INI_FILE) vault_dev_nodes -m shell \
		-a "VAULT_ADDR=http://127.0.0.1:8200 vault status" \
		--become

vault-kubernetes-auth-dev:
	ansible-playbook -i $(HOSTS_INI_FILE) $(VAULT_ROOT_DIR)/deploy_dev.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS) \
		--tags vault-kubernetes

terraform-install:
	@set -e; \
	sudo apt-get update; \
	sudo apt-get install -y curl gnupg software-properties-common; \
	sudo install -d -m 0755 /usr/share/keyrings; \
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
	CODENAME=$$(. /etc/os-release && echo $$VERSION_CODENAME || lsb_release -cs); \
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $$CODENAME main" | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null; \
	sudo apt-get update; \
	sudo apt-get install -y terraform; \
	terraform version

ansible-install:
	@set -e; \
	sudo apt-get update; \
	sudo apt-get install -y software-properties-common; \
	sudo add-apt-repository --yes --update ppa:ansible/ansible; \
	sudo apt-get install -y ansible; \
	ansible --version

apply-terraform-dev:
	cd $(VAULT_ROOT_DIR)/terraform/enviroments/dev && terraform init && terraform apply --auto-approve
	cd $(VAULT_ROOT_DIR)

destroy-terraform-dev:
	cd $(VAULT_ROOT_DIR)/terraform/enviroments/dev && terraform destroy --auto-approve
	cd $(VAULT_ROOT_DIR)