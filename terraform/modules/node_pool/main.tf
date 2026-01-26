resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "cnpg-node-pool"
  location   = "${var.region}"
  cluster    = var.gke_cluster_name
  node_count = 2


  node_config {
    preemptible  = true
    machine_type = var.node_type
    disk_size_gb = var.node_disk_size
    disk_type = var.node_disk_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.node_sa_email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}