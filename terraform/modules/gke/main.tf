resource "google_container_cluster" "cnpg-primary" {
  name     = var.cluster_name
  location   = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
  workload_identity_config {
  workload_pool = "${var.project_id}.svc.id.goog"
}
  //enable_shielded_nodes = true 
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

}

