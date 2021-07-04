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
  ip_cidr_range = "10.128.0.0/16"
  region = var.region
  network = google_compute_network.vpc_network.id  
}
// Google Private Services Access
resource "google_compute_global_address" "private_ip_block" {
  name         = "private-ip-block"
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"
  ip_version   = "IPV4"
  prefix_length = 20
  //network       = google_compute_network.vpc_network.self_link
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}