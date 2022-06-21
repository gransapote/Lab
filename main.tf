/*   Main execution file, usually it has providers configuration */
  
provider "aws" {
  region  = "eu-west-1"
  //profile = "default"
}


resource "aws_s3_bucket" "mapfre-gitops-amelgar" {
  bucket = "mapfre-gitops-amelgar"
//  acl = "public-read"
//  website {
//    index_document = "index.html"
//  }
}

resource "aws_s3_bucket_website_configuration" "mapfre-gitops-amelgar" {
  bucket = "aws_s3_bucket.webmapfre-gitops-amelgar.bucket"
  //acl = "public-read"
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "mapfre-gitops-amelgar" {
  bucket = "aws_s3_bucket.mapfre-gitops-amelgar.bucket"
  acl    = "public-read"
}