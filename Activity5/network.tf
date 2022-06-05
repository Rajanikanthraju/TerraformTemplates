resource "aws_vpc" "ntier_vpc" {
    cidr_block = var.vpc_cidr_range
    tags = {
      "Name" = "from-tf"
    }
  
}
# Creating S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
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
cidr_block = var.cidr_range[0]
availability_zone =var.az_a
 tags= {

     "Name"="web1-tf"
 } 
  
}
#Web2 subnet
resource "aws_subnet" "web2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.cidr_range[1]
availability_zone =var.az_b
 tags = {
     "Name" ="web2-tf"
 } 
  
}
#App1 subnet
resource "aws_subnet" "app1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.cidr_range[2]
availability_zone =var.az_a
 tags= {

     "Name"="app1-tf"
 } 
  
}
#App22 subnet
resource "aws_subnet" "app2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.cidr_range[3]
availability_zone =var.az_b
 tags = {
     "Name" ="app2-tf"
 } 
  
}
#db1 subnet
resource "aws_subnet" "db1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = var.cidr_range[4]
availability_zone =var.az_a
 tags= {

     "Name"="db1-tf"
 } 
  
}
#Web2 subnet
resource "aws_subnet" "db2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block =var.cidr_range[5]
availability_zone =var.az_b
 tags = {
     "Name" ="db2-tf"
 } 
  
}