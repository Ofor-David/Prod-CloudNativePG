# Create the dedicated service account for nodes
resource "google_service_account" "gke_nodes" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}

# Assign minimum required roles
resource "google_project_iam_member" "gke_node_roles" {
  for_each = toset([
    "roles/container.nodeServiceAccount",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/storage.objectAdmin",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_service_account" "cnpg_backup" {
  account_id   = "cnpg-backup"
  display_name = "cnpg-backup"
}

# Workload identity for cnpg SA (from serviceAccountTemplate)
resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.cnpg_backup.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/${var.ksa_name}]"
}

# Workload identity for cnpg-cluster SA (actual SA used by CNPG pods)
resource "google_service_account_iam_member" "workload_identity_binding_cluster" {
  service_account_id = google_service_account.cnpg_backup.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/cnpg-cluster]"
}
