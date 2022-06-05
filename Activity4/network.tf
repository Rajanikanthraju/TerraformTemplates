resource "aws_vpc" "ntier_vpc" {
    cidr_block = var.vpc_cidr_range
    tags = {
      "Name" = "from-tf"
    }
  
}
# Creating S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "from-tf-test-bucket"

  tags = {
    Name        = "My test bucket"
    
  }
}

#Creating Internet gateway and attaching it to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ntier_vpc.id

  tags = {
    Name = "tf-igw"
  }
}
#Web1 subnet
resource "aws_subnet" "web1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.web1_cidr_range
availability_zone =var.web1_az
 tags= {

     "Name"="web1-tf"
 } 
  
}
#Web2 subnet
resource "aws_subnet" "web2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.web2_cidr_range
availability_zone =var.web2_az
 tags = {
     "Name" ="web2-tf"
 } 
  
}
#App1 subnet
resource "aws_subnet" "app1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.app1_cidr_range
availability_zone =var.app1_az
 tags= {

     "Name"="app1-tf"
 } 
  
}
#App22 subnet
resource "aws_subnet" "app2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.app2_cidr_range
availability_zone =var.app2_az
 tags = {
     "Name" ="app2-tf"
 } 
  
}
#db1 subnet
resource "aws_subnet" "db1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.db1_cidr_range
availability_zone =var.db1_az
 tags= {

     "Name"="db1-tf"
 } 
  
}
#Web2 subnet
resource "aws_subnet" "db2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.db2_cidr_range
availability_zone =var.db2_az
 tags = {
     "Name" ="db2-tf"
 } 
  
}