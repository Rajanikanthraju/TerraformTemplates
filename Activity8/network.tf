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
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.ntier_vpc.id
  ingress {
    description      = "allow ssh connection"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
      }
      egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
ingress {
    description      = "allow http connection"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
      }
      egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
tags = {
  "Name" = "websgfromtf"
}
}
resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.ntier_vpc.id
  ingress {
    description      = "allow http connection"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
      }
      egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
tags = {
  "Name" = "appsgfromtf"
}
}
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.ntier_vpc.id
  ingress {
    description      = "allow database connection"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
      }
      egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
tags = {
  "Name" = "dbsgfromtf"
}
}