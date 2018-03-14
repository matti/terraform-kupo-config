module "kupo" {
  source = ".."

  # workaround terraform heterogenous map issue
  master_addresses         = ["1.0.0.1"]
  master_private_addresses = ["10.0.0.1"]

  master_fields = {
    role = "master"
    user = "user"
  }

  worker_addresses         = ["2.0.0.0", "2.0.0.1"]
  worker_private_addresses = ["20.0.0.1", "20.0.0.2"]

  worker_fields = {
    role = "worker"
    user = "user"

    labels = {
      ingress = "nginx"
    }
  }

  network = {
    service_cidr     = "10.96.0.0/12"
    pod_network_cidr = "10.32.0.0/12"
    trusted_subnets  = ["10.10.0.0/16"]
  }

  addons = {
    ingress-nginx = {
      enabled = false
    }

    kured = {
      enabled = true
    }
  }
}

output "rendered" {
  value = "${module.kupo.rendered}"
}
