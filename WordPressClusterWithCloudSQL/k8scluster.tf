resource "google_container_cluster" "gkecluster" {
  name               = "${var.prefix_name}-k8scluster"
  location           = var.region
  initial_node_count = 1

  //network    = google_compute_network.vpc_network.name
  network = "${var.prefix_name}-network"

  //subnetwork = google_compute_subnetwork.network.name
  subnetwork = "${var.prefix_name}-subnetwork"

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}