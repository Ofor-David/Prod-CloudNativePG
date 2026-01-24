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