resource "aws_vpc" "ntier_vpc" {
    cidr_block = "10.10.0.0/16"
    tags = {
      "Name" = "from-tf"
    }
  
}
#Web1 subnet
resource "aws_subnet" "web1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = "10.10.0.0/24"
availability_zone ="ap-southeast-1a"
 tags= {

     "Name"="web1-tf"
 } 
  
}
#Web2 subnet
resource "aws_subnet" "web2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = "10.10.1.0/24"
availability_zone ="ap-southeast-1b"
 tags = {
     "Name" ="web2-tf"
 } 
  
}
#db1 subnet
resource "aws_subnet" "db1" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = "10.10.2.0/24"
availability_zone ="ap-southeast-1a"
 tags= {

     "Name"="db1-tf"
 } 
  
}
#Web2 subnet
resource "aws_subnet" "db2" {
vpc_id = aws_vpc.ntier_vpc.id
cidr_block = "10.10.3.0/24"
availability_zone ="ap-southeast-1b"
 tags = {
     "Name" ="db2-tf"
 } 
  
}