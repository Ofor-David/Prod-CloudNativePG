module "iam" {
  source = "./modules/iam"
}
module "gke" {
    source = "./modules/gke"
    region = var.region
    cluster_name = var.cluster_name
}
module "node_pool"{
    source = "./modules/node_pool"
    region = var.region
    node_disk_size = var.node_disk_size
    node_disk_type = var.node_disk_type
    node_type = var.node_type

    gke_cluster_name = module.gke.gke_cluster_name
    node_sa_email = module.iam.node_sa_email
}