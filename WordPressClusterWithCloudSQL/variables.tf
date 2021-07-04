// variables definition
variable "prefix_name" {
    default = "xecommerce"
}

// ~/.config/gcloud/ilovedigitalmeister-ecommerce.json
// GOOGLE_CREDENTIALS environment variable defined
// Or specify the file directly (Optional)
// credentials = file("ilovedigitalmeister-ecommerce.json")

variable "project" {
    default = "ilovedigitalmeister-ecommerce"
}

variable "region" {
    default = "southamerica-east1"
}

// To be specified to connect to MySQL managed service
// *** IMPORTANT TO KEEP SECURED ***
variable "mysql_user" {
    default = "luizcarloskazuyukifukaya"
}

variable "mysql_password" {
    default = "Lu1zC@rl0sK@zuyuk1Fuk@y@"
}
// *** IMPORTANT TO KEEP SECURED ***