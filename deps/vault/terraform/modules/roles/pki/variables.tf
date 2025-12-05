# PKI Role variables
variable "pki_backend" {
  description = "The backend for PKI secrets engine."
  type        = string
}

variable "pki_role_name" {
  description = "The name of the PKI role."
  type        = string
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
}

variable "pki_allow_subdomains" {
  description = "Whether to allow subdomains in certificate generation."
  type        = bool
  default     = true
}
