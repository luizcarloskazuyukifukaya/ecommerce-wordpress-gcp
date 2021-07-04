resource "google_compute_firewall" "rule" {
  name    = "${var.prefix_name}-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}