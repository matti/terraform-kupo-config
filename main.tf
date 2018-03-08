data "external" "kupo" {
  program = ["ruby", "${path.module}/kupo.rb"]

  query = {
    hosts   = "${jsonencode(var.hosts)}"
    network = "${jsonencode(var.network)}"
    addons  = "${jsonencode(var.addons)}"
  }
}
