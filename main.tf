/*   Main execution file, usually it has providers configuration */
  
provider "aws" {
  region  = "eu-west-1"
  //profile = "default"
}


//resource "aws_s3_bucket" "web" {
//  bucket = "mapfre-gitops-amelgar"
//  acl = "public-read"
//  website {
//    index_document = "index.html"
//  }
//}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = "aws_s3_bucket.web.bucket"
  //acl = "public-read"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "web_bucket_acl" {
  bucket = "aws_s3_bucket.web.bucket"
  acl    = "public-read"
}