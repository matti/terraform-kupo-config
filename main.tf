module "map2yaml" {
  source  = "matti/yaml/map"
  version = "0.0.1"

  root = {
    hosts   = "${var.hosts}"
    network = "${var.network}"
    addons  = "${var.addons}"
  }
}
