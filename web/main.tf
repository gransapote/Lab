/*   Main execution file, usually it has providers configuration */
  
provider "aws" {
  region  = "eu-west-1"
  //profile = "default"
}

data "aws_subnet_ids" "selected" {
vpc_id = "vpc-01f8e0ace904bdd9e"
filter {
name = "tag:Name"
values = ["alumni"] # insert values here
}
}

resource "aws_instance" "web" {
  ami           = var.image_id 
  instance_type = "t3.micro"
  associate_public_ip_address = true
  key_name = "amelgar@mapfre.com"
  subnet_id = one (toset (data.aws_subnet_ids.selected.ids)) 
  vpc_security_group_ids = ["sg-0916b96e36c8b90a4"]

  tags = {
    Name = "gransapote"
    Owner = "amelgar@mapfre.com"
  } 
}