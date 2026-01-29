resource "google_storage_bucket" "cnpg-backup" {
  name          = var.backup_bucket_name
  location      = var.backup_bucket_region
  force_destroy = true

  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 7
    }
    action {
      type = "Delete"
    }
  }
}