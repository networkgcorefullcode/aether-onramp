# Load users directly from the YAML file

data "local_file" "users_yaml" {
  filename = "${path.module}/configs/users.yml"
}

locals {
  users = yamldecode(data.local_file.users_yaml.content).users
}

module "vault_users" {
  for_each = { for user in local.users : user.username => user }
  source   = "../../modules/vault_generic_endpoint"
  
  path      = "auth/${module.auth_backend.path}/users/${each.value.username}"
  data_json = {
    password = each.value.password
    policies = each.value.policies
  }
  
  depends_on = [module.auth_backend]
}