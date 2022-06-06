provider "aws" {
  #Use the access key and secret key genarated in IAM
    access_key = " "
    secret_key = " "
    region = "ap-southeast-1"
}
resource "aws_s3_bucket" "bucket" {
  bucket = "s3bucketfromtf" 

  tags = {
    Name        = "tfs3bucket"
  }
}