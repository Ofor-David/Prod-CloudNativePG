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

resource "google_storage_bucket_iam_member" "cnpg_backup_admin" {
  bucket = google_storage_bucket.cnpg-backup.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.cnpg_backup_sa_email}"
}

resource "google_storage_bucket_iam_member" "gke_node_admin" {
  bucket = google_storage_bucket.cnpg-backup.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.gke_node_sa_email}"
}