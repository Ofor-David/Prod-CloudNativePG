output "node_sa_email" {
  value = google_service_account.gke_nodes.email
}

output "backup_sa_email" {
  value = google_service_account.cnpg_backup.email
}