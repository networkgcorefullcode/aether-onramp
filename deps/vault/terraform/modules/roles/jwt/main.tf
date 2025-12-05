resource "vault_jwt_auth_backend_role" "jwt_role" {
  backend         = var.jwt_backend
  role_name       = var.jwt_role_name
  role_type       = var.jwt_role_type
  bound_audiences = var.jwt_bound_audiences
  user_claim      = var.jwt_user_claim
  token_policies  = var.jwt_token_policies
  token_ttl       = var.jwt_token_ttl
}
