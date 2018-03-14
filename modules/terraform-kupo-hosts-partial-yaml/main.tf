resource "null_resource" "start" {
  triggers {
    depends_id = "${var.depends_id}"
  }
}

data "external" "mapper" {
  depends_on = ["null_resource.start"]

  program = ["ruby", "${path.module}/mapper.rb"]

  query = {
    addresses         = "${jsonencode(var.addresses)}"
    private_addresses = "${jsonencode(var.private_addresses)}"
    fields            = "${jsonencode(var.fields)}"
    labels            = "${jsonencode(var.labels)}"
  }
}
