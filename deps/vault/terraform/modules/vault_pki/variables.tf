variable "pki_path" {
    description = "Path where the PKI secrets engine will be mounted"
    type        = string
}

variable "pki_description" {
    description = "Description for the PKI secrets engine"
    type        = string
    default     = "PKI secrets engine"
}

variable "default_lease_ttl_seconds" {
    description = "Default lease TTL in seconds"
    type        = number
    default     = 3600
}

variable "max_lease_ttl_seconds" {
    description = "Maximum lease TTL in seconds"
    type        = number
    default     = 86400
}

# Root Certificate Configuration
variable "root_cert_config_type" {
    description = "Type of root certificate (internal or exported)"
    type        = string
    default     = "internal"
}

variable "root_cert_config_common_name" {
    description = "Common name for the root certificate"
    type        = string
    default     = "Root CA"
}

variable "root_cert_config_ttl" {
    description = "TTL for the root certificate"
    type        = string
    default     = "87600h"  # 10 years
}

variable "root_cert_config_issuer_name" {
    description = "Issuer name for the root certificate"
    type        = string
    default     = "root-2023"
}

# Issuer Configuration
variable "revocation_signature_algorithm" {
    description = "The signature algorithm to use for revocation"
    type        = string
    default     = "SHA256WithRSA"
}

# Role Configuration
variable "role_name" {
    description = "Name of the PKI role"
    type        = string
    default     = "default-role"
}

variable "role_ttl" {
    description = "TTL for certificates issued by this role"
    type        = number
    default     = 86400  # 24 hours
}

variable "allow_ip_sans" {
    description = "Allow IP Subject Alternative Names"
    type        = bool
    default     = true
}

variable "key_type" {
    description = "Type of key to generate (rsa, ec, ed25519)"
    type        = string
    default     = "rsa"
}

variable "key_bits" {
    description = "Number of bits for the key"
    type        = number
    default     = 2048
}

variable "allowed_domains" {
    description = "List of allowed domains for certificates"
    type        = list(string)
    default     = []
}

variable "allow_subdomains" {
    description = "Allow subdomains of allowed_domains"
    type        = bool
    default     = false
}

variable "allow_any_name" {
    description = "Allow any common name"
    type        = bool
    default     = false
}

# Config URLs
variable "issuing_certificates" {
    description = "URLs for issuing certificates"
    type        = list(string)
    default     = []
}

variable "crl_distribution_points" {
    description = "URLs for CRL distribution points"
    type        = list(string)
    default     = []
}

# Intermediate Certificate Configuration
variable "intermediate_pki_path" {
    description = "Path where the intermediate PKI secrets engine is mounted"
    type        = string
    default     = "pki_int"
}

variable "intermediate_pki_description" {
    description = "Description for the intermediate PKI secrets engine"
    type        = string
    default     = "Intermediate PKI secrets engine"
}

variable "intermediate_default_lease_ttl_seconds" {
    description = "Default lease TTL in seconds for intermediate PKI"
    type        = number
    default     = 3600
}

variable "intermediate_max_lease_ttl_seconds" {
    description = "Maximum lease TTL in seconds for intermediate PKI"
    type        = number
    default     = 86400
}

variable "intermediate_cert_type" {
    description = "Type of intermediate certificate (internal or exported)"
    type        = string
    default     = "internal"
}

variable "intermediate_common_name" {
    description = "Common name for the intermediate certificate"
    type        = string
    default     = "Intermediate Authority"
}

variable "intermediate_issuer_common_name" {
    description = "Common name for the intermediate issuer"
    type        = string
    default     = "Intermediate CA"
}

variable "intermediate_cert_format" {
    description = "Format for the intermediate certificate (pem_bundle, pem, der)"
    type        = string
    default     = "pem_bundle"
}

variable "intermediate_cert_ttl" {
    description = "TTL for the intermediate certificate in seconds"
    type        = number
    default     = 15480000  # Approximately 180 days
}