// this file is always included in terraform runs
// you can also use include .tfvars in commandline, export TF_VAR_image_id=ami-abc123 etc
// -var-file="testing.tfvars"
image_id = "ami-0063343029bd9616b"
availability_zone_names = [
  "us-east-1a",
  "us-west-1c",
]