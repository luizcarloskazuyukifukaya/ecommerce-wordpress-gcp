// Configure the Google Cloud provider
provider "google" {
 project = "${var.project}"
 region = "${var.region}"
}

resource "google_compute_network" "vpc_network" {
 name = "${var.prefix_name}-network"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "${var.prefix_name}-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "southamerica-east1-a"

 boot_disk {
  initialize_params {
   image = "debian-cloud/debian-9"
  }
 }

 // Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
  network = "${var.prefix_name}-network"

  access_config {
    // Include this section to give the VM an external ip address
  }
 }
}