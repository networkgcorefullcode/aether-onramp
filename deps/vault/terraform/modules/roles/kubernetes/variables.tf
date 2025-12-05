# Variables for roles module

# Enable/Disable flags
variable "enabled_approle" {
  description = "Enable or disable AppRole authentication."
  type        = bool
  default     = true
}

variable "enabled_k8s" {
  description = "Enable or disable Kubernetes authentication."
  type        = bool
  default     = true
}

variable "enabled_jwt" {
  description = "Enable or disable JWT authentication."
  type        = bool
  default     = true
}

variable "enabled_cert" {
  description = "Enable or disable Certificate authentication."
  type        = bool
  default     = true
}

# AppRole variables
variable "approle_backend" {
  description = "The backend for AppRole authentication."
  type        = string
  default     = "approle"
}

variable "approle_role_name" {
  description = "The name of the AppRole role."
  type        = string
  default     = "miapp"
}

variable "approle_token_policies" {
  description = "List of policies to attach to AppRole tokens."
  type        = list(string)
}

variable "approle_token_ttl" {
  description = "The TTL for AppRole tokens in seconds."
  type        = number
  default     = 3600
}

variable "approle_token_max_ttl" {
  description = "The maximum TTL for AppRole tokens in seconds."
  type        = number
  default     = 7200
}

# Kubernetes Auth variables
variable "k8s_backend" {
  description = "The backend for Kubernetes authentication."
  type        = string
  default     = "kubernetes"
}

variable "k8s_role_name" {
  description = "The name of the Kubernetes auth role."
  type        = string
  default     = "miapp-k8s"
}

variable "k8s_bound_service_account_names" {
  description = "List of service account names that can authenticate."
  type        = list(string)
  default     = ["vault-client"]
}

variable "k8s_bound_service_account_namespaces" {
  description = "List of namespaces that service accounts can authenticate from."
  type        = list(string)
  default     = ["default"]
}

variable "k8s_token_policies" {
  description = "List of policies to attach to Kubernetes auth tokens."
  type        = list(string)
}

variable "k8s_token_ttl" {
  description = "The TTL for Kubernetes auth tokens in seconds."
  type        = number
  default     = 3600
}

# JWT Auth variables
variable "jwt_backend" {
  description = "The backend for JWT authentication."
  type        = string
  default     = "jwt"
}

variable "jwt_role_name" {
  description = "The name of the JWT auth role."
  type        = string
  default     = "miapp-jwt"
}

variable "jwt_role_type" {
  description = "The type of JWT role (jwt or oidc)."
  type        = string
  default     = "jwt"
}

variable "jwt_bound_audiences" {
  description = "List of audiences that are allowed to authenticate."
  type        = list(string)
  default     = ["miapp"]
}

variable "jwt_user_claim" {
  description = "The claim to use for the user identity."
  type        = string
  default     = "sub"
}

variable "jwt_token_policies" {
  description = "List of policies to attach to JWT auth tokens."
  type        = list(string)
}

variable "jwt_token_ttl" {
  description = "The TTL for JWT auth tokens in seconds."
  type        = number
  default     = 3600
}

# Certificate Auth variables
variable "cert_backend" {
  description = "The backend for Certificate authentication."
  type        = string
  default     = "cert"
}

variable "cert_role_name" {
  description = "The name of the Certificate auth role."
  type        = string
  default     = "miapp-cert"
}

variable "cert_allowed_domains" {
  description = "List of allowed certificate common names."
  type        = list(string)
  default     = ["example.com"]
}

variable "cert_allow_subdomains" {
  description = "Whether to allow subdomains in certificate authentication."
  type        = bool
  default     = true
}

variable "cert_certificate" {
  description = "The CA certificate for certificate authentication."
  type        = string
  default     = "ca.crt"
}

variable "cert_token_ttl" {
  description = "The TTL for Certificate auth tokens in seconds."
  type        = number
  default     = 300
}

variable "cert_token_max_ttl" {
  description = "The maximum TTL for Certificate auth tokens in seconds."
  type        = number
  default     = 600
}

variable "cert_token_policies" {
  description = "List of policies to attach to Certificate auth tokens."
  type        = list(string)
  default     = []
}

# PKI Role variables
variable "enabled_pki" {
  description = "Enable or disable PKI role."
  type        = bool
  default     = true
}

variable "pki_backend" {
  description = "The backend for PKI secrets engine."
  type        = string
  default     = "pki"
}

variable "pki_role_name" {
  description = "The name of the PKI role."
  type        = string
  default     = "my_role"
}

variable "pki_ttl" {
  description = "The TTL for certificates in seconds."
  type        = number
  default     = 3600
}

variable "pki_allow_ip_sans" {
  description = "Allow IP Subject Alternative Names."
  type        = bool
  default     = true
}

variable "pki_key_type" {
  description = "The key type for certificates (rsa, ec, ed25519)."
  type        = string
  default     = "rsa"
}

variable "pki_key_bits" {
  description = "The number of bits to use for the key."
  type        = number
  default     = 4096
}

variable "pki_allowed_domains" {
  description = "List of domains allowed for certificate generation."
  type        = list(string)
  default     = ["example.com", "my.domain"]
}

variable "pki_allow_subdomains" {
  description = "Whether to allow subdomains in certificate generation."
  type        = bool
  default     = true
}

variable "pki_mount_path" {
  description = "The mount path reference for the PKI backend."
  type        = string
  default     = null
}
