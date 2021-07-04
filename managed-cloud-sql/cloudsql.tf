// Configure the Google Cloud provider
provider "google" {
 project = var.project
 region = var.region
}

resource "google_sql_database_instance" "master" {
  name = "${var.prefix_name}-mysql"
  database_version = "MYSQL_5_7"
  region       = var.region

  settings {
    tier = "db-f1-micro"
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name      = "${var.prefix_name}-database"
  instance  = "${google_sql_database_instance.master.name}"
  charset   = "sjis"
  collation = "sjis_japanese_ci"
}

resource "google_sql_user" "users" {
  name     = var.mysql_user
  instance = "${google_sql_database_instance.master.name}"
  host     = "%"
  password = var.mysql_password
}
