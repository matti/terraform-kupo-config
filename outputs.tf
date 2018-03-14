output "id" {
  value = "${null_resource.start.id}"
}

output "rendered" {
  value = "${data.template_file.cluster_yml.rendered}"
}
