module "kupo" {
  source = ".."

  hosts = [
    {
      role            = "master"
      address         = "35.190.177.65"
      user            = "ubuntu"
      private_address = "10.142.0.3"
    },
    {
      role            = "worker"
      address         = "35.229.87.147"
      user            = "ubuntu"
      private_address = "10.142.0.4"

      labels = {
        disk    = "ssd"
        ingress = "nginx"
      }
    },
  ]

  network = {
    service_cidr     = "10.96.0.0/12"
    pod_network_cidr = "10.32.0.0/12"
    trusted_subnets  = ["10.10.0.0/16"]
  }

  addons = {
    ingress-nginx = {
      enabled = true

      node_selector = {
        ingress = "nginx"
      }

      configmap = {
        # see all supported options: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/configmap.md
        load-balance = "least_conn"
      }
    }

    cert-manager = {
      enabled = true

      issuer = {
        name   = "letsencrypt-staging"
        server = "https://acme-staging.api.letsencrypt.org/directory"
        email  = "me@domain.com"
      }
    }

    host-upgrades = {
      enabled  = true
      interval = "7d"
    }

    kured = {
      enabled = true
    }
  }
}

output "rendered" {
  value = "${module.kupo.rendered}"
}
