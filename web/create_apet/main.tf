resource "aws_instance" "web" {
  ami           = "ami-0063343029bd9616b"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  key_name = "amelgar@mapfre.com"
  subnet_id = var.subnet_id
  vpc_security_group_ids = ["sg-0916b96e36c8b90a4"]

  tags = {
    Name = "gransapote"
    Owner = "amelgar@mapfre.com"
  }
}