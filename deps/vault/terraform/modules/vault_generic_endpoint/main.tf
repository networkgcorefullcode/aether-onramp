# Terraform module for Vault generic_endpoint resource

resource "vault_generic_endpoint" "this" {
  path      = var.path
  data_json = jsonencode(var.data_json)
  ignore_absent_fields = var.ignore_absent_fields
}