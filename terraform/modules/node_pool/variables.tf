variable "region"{
    type = string
}
variable "node_type"{
    type = string
}
variable "node_disk_size"{
    type = number
}
variable "node_disk_type" {
  type = string
}
variable "gke_cluster_name" {
  type = string
}
variable "node_sa_email" {
  type = string
}