/*   Main execution file, usually it has providers configuration */
  
provider "aws" {
  region  = "eu-west-1"
  //shared_config_files      = ["/Users/tf_user/.aws/conf"]
  //shared_credentials_files = ["/~/.aws/credentials"]
  //access_key = "${var.aws_access_key_id}"
  //secret_key = "${var.aws_secret_access_key}"
  //profile = "default"
  access_key_id = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
}


resource "aws_s3_bucket" "mapfre-gitops-amelgar" {
  bucket = "mapfre-gitops-amelgar"
//  acl = "public-read"
//  website {
//    index_document = "index.html"
//  }
}

//resource "aws_s3_bucket_website_configuration" "mapfre-gitops-amelgar1" {
  //bucket = "aws_s3_bucket.webmapfre-gitops-amelgar1.bucket"
  ////acl = "public-read"
  //index_document {
    //suffix = "index.html"
  //}
//}

resource "aws_s3_bucket_acl" "mapfre-gitops-amelgar" {
  bucket = aws_s3_bucket.mapfre-gitops-amelgar.id
  acl    = "public-read"
}