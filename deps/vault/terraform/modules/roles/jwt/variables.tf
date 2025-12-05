# JWT Auth variables
variable "jwt_backend" {
  description = "The backend for JWT authentication."
  type        = string
  default     = "jwt"
}

variable "jwt_role_name" {
  description = "The name of the JWT auth role."
  type        = string
}

variable "jwt_role_type" {
  description = "The type of JWT role (jwt or oidc)."
  type        = string
  default     = "jwt"
}

variable "jwt_bound_audiences" {
  description = "List of audiences that are allowed to authenticate."
  type        = list(string)
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
