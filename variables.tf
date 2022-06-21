//variable "image_id" {
  //type = string
//}

//variable "availability_zone_names" {
//  type    = list(string)
//  default = ["eu-west-1a"]
//}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}