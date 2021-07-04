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
