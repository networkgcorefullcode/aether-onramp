resource "vault_transit_secret_backend_key" "key" {
  backend                 = var.backend
  name                    = var.name
  allow_plaintext_backup  = var.allow_plaintext_backup
  auto_rotate_period      = var.auto_rotate_period
  deletion_allowed        = var.deletion_allowed
  derived                 = var.derived
  exportable              = var.exportable
  convergent_encryption   = var.convergent_encryption
  type                    = var.type

  min_decryption_version = var.min_decryption_version
  min_encryption_version = var.min_encryption_version
}