# Certificate Auth variables
variable "cert_backend" {
  description = "The backend for Certificate authentication."
  type        = string
  default     = "cert"
}

variable "cert_role_name" {
  description = "The name of the Certificate auth role."
  type        = string
}

variable "cert_allowed_domains" {
  description = "List of allowed certificate common names."
  type        = list(string)
  default     = []
}

variable "cert_certificate" {
  description = "The CA certificate for certificate authentication."
  type        = string
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
