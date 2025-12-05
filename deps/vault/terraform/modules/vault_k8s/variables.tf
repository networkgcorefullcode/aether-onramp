# Auth backend variables
variable "auth_type" {
    description = "Type of authentication backend"
    type        = string
    default     = "kubernetes"
}

variable "auth_description" {
    description = "Description for the authentication backend"
    type        = string
    default     = "Kubernetes authentication backend"
}

variable "auth_path" {
    description = "Path where the auth backend will be mounted"
    type        = string
    default     = "kubernetes"
}

variable "default_lease_ttl" {
    description = "Default lease TTL for tokens issued by this backend"
    type        = number
    default     = null
}

variable "max_lease_ttl" {
    description = "Maximum lease TTL for tokens issued by this backend"
    type        = number
    default     = null
}

# Kubernetes auth backend config variables
variable "kubernetes_host" {
    description = "Kubernetes API host URL"
    type        = string
}

variable "kubernetes_ca_cert" {
    description = "PEM encoded CA certificate to verify the Kubernetes API server certificate"
    type        = string
    default     = ""
}

variable "token_reviewer_jwt" {
    description = "JWT token for the service account used for token review"
    type        = string
    sensitive   = true
}

variable "issuer" {
    description = "JWT issuer to validate against"
    type        = string
    default     = ""
}

variable "disable_iss_validation" {
    description = "Disable JWT issuer validation"
    type        = bool
    default     = false
}