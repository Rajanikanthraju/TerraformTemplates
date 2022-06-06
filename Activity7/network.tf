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
count = length(var.name_tags)
cidr_block = cidrsubnet(var.vpc_cidr_range,8,count.index)
availability_zone =format("${var.region}%s",count.index%2 == 0?"a":"b")
 tags = {

     "Name" = var.name_tags[count.index]
 } 
  
}
