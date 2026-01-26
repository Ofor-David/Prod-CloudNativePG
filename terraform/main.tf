resource "google_service_account" "cnpg-admin" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "cnpg-primary" {
  name     = "cnpg-gke-cluster"
  location   = "${var.region}-a"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "cnpg-node-pool"
  location   = "${var.region}-a"
  cluster    = google_container_cluster.cnpg-primary.name
  node_count = 2


  node_config {
    preemptible  = true
    machine_type = var.node_type
    disk_size_gb = var.node_disk_size
    disk_type = var.node_disk_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.cnpg-admin.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}