// Configure the Google Cloud provider
provider "google" {
 project = var.project
 region = var.region
}

resource "google_compute_network" "vpc_network" {
 name = "${var.prefix_name}-network"
 auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network" {
  name = "${var.prefix_name}-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region = var.region
  network = google_compute_network.vpc_network.id  
}