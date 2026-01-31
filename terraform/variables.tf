variable "project_id" { 
    type = string
    description = "GCP Project Id "
}

variable "region"{
    type = string
}

variable "node_type"{
    type = string
}

variable "node_disk_size"{
    type = number
    default = 10
}
variable "node_disk_type" {
  type = string
}

variable "cluster_name"{
    type = string
}
variable "backup_bucket_region" {
  type = string
}
variable "backup_bucket_name" {
  type = string
}

variable "backup_ksa_name" {
  type = string
}
variable "secrets_ksa_name" {
  type = string
}
variable "db_namespace" {
  type = string
}

variable "secrets_namespace" {
  type = string
}