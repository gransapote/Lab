/*   Main execution file, usually it has providers configuration */
  
//provider "aws" {
  //region  = "eu-west-1"
//}


resource "aws_s3_bucket" "mapfre-gitops-amelgar" {
  bucket = "mapfre-gitops-amelgar"
}

//resource "aws_s3_bucket_website_configuration" "mapfre-gitops-amelgar" {
  //bucket = "aws_s3_bucket.mapfre-gitops-amelgar.bucket"
  //acl = "public-read"
  //index_document {
    //suffix = "index.html"
  //}
//}

resource "aws_s3_bucket_acl" "mapfre-gitops-amelgar" {
  bucket = aws_s3_bucket.mapfre-gitops-amelgar.id
  acl    = "public-read"
}