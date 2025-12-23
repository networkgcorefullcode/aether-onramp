# Variables for Vault transit secret backend key module

variable "backend" {
  description = "The path to the transit secret backend."
  type        = string
}

variable "name" {
  description = "The name of the encryption key."
  type        = string
}

variable "allow_plaintext_backup" {
  description = "If true, allows plaintext backup of the key."
  type        = bool
  default     = false
}

variable "auto_rotate_period" {
  description = "The period at which the key should be rotated automatically (e.g., '24h', '30d')."
  type        = string
  default     = null
}

variable "deletion_allowed" {
  description = "If true, allows deletion of the key."
  type        = bool
  default     = false
}

variable "derived" {
  description = "If true, key derivation is enabled."
  type        = bool
  default     = false
}

variable "exportable" {
  description = "If true, the key is exportable."
  type        = bool
  default     = false
}

variable "convergent_encryption" {
  description = "If true, convergent encryption is enabled (requires derived=true)."
  type        = bool
  default     = false
}

variable "type" {
  description = "The type of key to create (e.g., 'aes256-gcm96', 'rsa-2048', 'ecdsa-p256')."
  type        = string
  default     = "aes256-gcm96"
}

variable "min_decryption_version" {
  description = "The minimum key version that can be used for decryption."
  type        = number
  default     = null
}

variable "min_encryption_version" {
  description = "The minimum key version that can be used for encryption."
  type        = number
  default     = null
}