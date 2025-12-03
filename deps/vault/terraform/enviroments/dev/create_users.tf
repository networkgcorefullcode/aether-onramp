# Load users directly from the YAML file

data "local_file" "users_yaml" {
  filename = "${path.module}/configs/users.yml"
}

locals {
  users = yamldecode(data.local_file.users_yaml.content).users
}

resource "random_password" "user_passwords" {
  for_each = { for user in local.users : user.username => user }
  length   = 16
  special  = true
  override_special = "@#$%"
}

module "vault_users" {
  for_each = { for user in local.users : user.username => user }
  source   = "../modules/vault_generic_endpoint"
  sensitive_data = true

  path      = "auth/userpass/users/${each.value.username}"
  data_json = jsonencode({
    password = random_password.user_passwords[each.key].result
    policies = each.value.policies
  })
}