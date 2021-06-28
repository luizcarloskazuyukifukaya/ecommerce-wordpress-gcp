data "google_client_config" "provider" {}

provider "kubernetes" { 
  //load_config_file = false

  host  = "https://${google_container_cluster.gkecluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.gkecluster.master_auth[0].cluster_ca_certificate,
  )
}

resource "kubernetes_deployment" "wp" {
  metadata {
    name = "wordpress"
    labels = {
      App = "frontend"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          App = "frontend"
        }
      }
      spec {
        container {
          image = "wordpress"
          name  = "wordpress"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}