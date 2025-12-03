# Load policies directly from the YAML file

data "local_file" "policies_yaml" {
  filename = "${path.module}/configs/policies.yml"
}

locals {
  policies = yamldecode(data.local_file.policies_yaml.content).policies
}

module "policies" {
  for_each = { for policy in local.policies : policy.name => policy }
  source   = "../modules/policies"

  name     = each.value.name
  policy   = each.value.policy
}