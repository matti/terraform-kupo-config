variable "depends_id" {
  default = ""
}

variable "master_addresses" {
  type = "list"
}

variable "master_private_addresses" {
  type = "list"
}

variable "master_fields" {
  type = "map"
}

variable "worker_addresses" {
  type = "list"
}

variable "worker_private_addresses" {
  type = "list"
}

variable "worker_fields" {
  type = "map"
}

variable "addons" {
  type    = "map"
  default = {}
}

variable "network" {
  type    = "map"
  default = {}
}
