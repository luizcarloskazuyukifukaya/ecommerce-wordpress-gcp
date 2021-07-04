resource "random_id" "unique_id" {
  byte_length = 8
}

resource "random_string" "unique_string" {
  length = 8
  special = false
  number = false
  lower = true
  upper = false
}

resource "google_sql_database_instance" "master" {
  //name = "${var.prefix_name}-mysql-${random_id.unique_id.hex}"
  name = "${var.prefix_name}-mysql-${random_string.unique_string.result}"
  //name = "${var.prefix_name}-mysql-abcd"
  database_version = "MYSQL_5_7"
  region       = var.region

  // Private VPC Connection
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    //tier = "db-g1-small" # $38.33 / month
    tier = "db-f1-micro" # $11.50 / month

    availability_type = "REGIONAL"
    backup_configuration {
      binary_log_enabled = true
      enabled = true
    }
    // disk_size = 10 # 10 GB is the smallest disk disk_size

    ip_configuration {
      ipv4_enabled = false # No public IP (private IP only)
      private_network = google_compute_network.vpc_network.id
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name      = "${var.prefix_name}-database"
  instance  = "${google_sql_database_instance.master.name}"
  //charset   = "sjis"
  charset   = "utf8"
  //collation = "sjis_japanese_ci"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name     = var.mysql_user
  instance = "${google_sql_database_instance.master.name}"
  host     = "%"
  password = var.mysql_password
}
output "cloudsql_instance_name" {
  value = google_sql_database_instance.master.name
}

output "cloudsql_private_ip" {
  value = google_sql_database_instance.master.private_ip_address
}

output "cloudsql_public_ip" {
  value = google_sql_database_instance.master.public_ip_address
}