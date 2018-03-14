#TODO: nothing actually depends on this, I don't think the resources below should (?)

resource "null_resource" "start" {
  triggers = {
    depends_id = "${var.depends_id}"
  }
}

module "map2yaml" {
  source  = "matti/yaml/map"
  version = "0.0.1"

  root = {
    network = "${var.network}"
    addons  = "${var.addons}"
  }
}

module "kupo_master" {
  source = "modules/terraform-kupo-hosts-partial-yaml"

  addresses         = ["${var.master_addresses}"]
  private_addresses = ["${var.master_private_addresses}"]

  fields = "${var.master_fields}"
}

module "kupo_workers" {
  source = "modules/terraform-kupo-hosts-partial-yaml"

  addresses         = ["${var.worker_addresses}"]
  private_addresses = ["${var.worker_private_addresses}"]

  fields = "${var.worker_fields}"
}

data "template_file" "cluster_yml" {
  template = "${file("${path.module}/cluster.yml.tpl")}"

  vars {
    root          = "${module.map2yaml.rendered}"
    host_partials = "${join("\n", list(module.kupo_workers.rendered, module.kupo_master.rendered))}"
  }
}
