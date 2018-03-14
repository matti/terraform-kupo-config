variable "depends_id" {
  default = ""
}

variable "addresses" {
  type = "list"
}

variable "private_addresses" {
  type    = "list"
  default = []
}

variable "fields" {
  type    = "map"
  default = {}
}

variable "labels" {
  type    = "map"
  default = {}
}
