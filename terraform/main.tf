module "apis" {
  source     = "./modules/apis"
  project_id = var.project_id
}
module "iam" {
  depends_on         = [module.apis.prep]
  source             = "./modules/iam"
  backup_bucket_name = module.backups.backup_bucket_name
  project_id         = var.project_id
  backup_ksa_name = var.backup_ksa_name
  secrets_ksa_name = var.secrets_ksa_name
  database_namespace = var.db_namespace
  secrets_namespace = var.secrets_namespace
}
module "gke" {
  depends_on   = [module.apis.prep]
  source       = "./modules/gke"
  region       = var.region
  cluster_name = var.cluster_name
}
module "node_pool" {
  depends_on     = [module.apis.prep]
  source         = "./modules/node_pool"
  region         = var.region
  node_disk_size = var.node_disk_size
  node_disk_type = var.node_disk_type
  node_type      = var.node_type

  gke_cluster_name = module.gke.gke_cluster_name
  node_sa_email    = module.iam.node_sa_email
}
module "backups" {
  depends_on           = [module.apis.prep]
  source               = "./modules/backups"
  backup_bucket_region = var.backup_bucket_region
  backup_bucket_name   = var.backup_bucket_name
  cnpg_backup_sa_email = module.iam.backup_sa_email
  gke_node_sa_email    = module.iam.node_sa_email
}

output "backup_sa_email" {
  value = module.iam.backup_sa_email
}