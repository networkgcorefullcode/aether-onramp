# Variables
variable "name" {
  description = "The name of the policy."
  type        = string
}

variable "policy" {
  description = "The HCL or JSON policy string."
  type        = string
}