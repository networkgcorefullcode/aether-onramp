module "auth_backend_k8s" {
    source = "../auth_backend"

    type              = var.auth_type
    description       = var.auth_description
    path              = var.auth_path
    default_lease_ttl = var.default_lease_ttl
    max_lease_ttl     = var.max_lease_ttl
}

resource "vault_kubernetes_auth_backend_config" "this" {
    backend                = module.auth_backend_k8s.path
    kubernetes_host        = var.kubernetes_host
    kubernetes_ca_cert     = var.kubernetes_ca_cert
    token_reviewer_jwt     = var.token_reviewer_jwt
    issuer                 = var.issuer
    disable_iss_validation = var.disable_iss_validation
}