/*   Main execution file, usually it has providers configuration */
  
provider "aws" {
  region  = "eu-west-1"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  //profile = "default"
}


resource "aws_s3_bucket" "mapfre-gitops-amelgar1" {
  bucket = "mapfre-gitops-amelgar1"
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

//resource "aws_s3_bucket_acl" "mapfre-gitops-amelgar1" {
  //bucket = aws_s3_bucket.mapfre-gitops-amelgar1.id
  //acl    = "public-read"
//}