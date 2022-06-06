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
resource "aws_subnet" "subnets" {
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
  description   = local.default_description
  ingress {
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
      }
  ingress {
    from_port        = local.web_port
    to_port          = local.web_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
      }
    egress {
    from_port        = local.all_ports
    to_port          = local.all_ports
    protocol         = local.any_protocal
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = [local.anywhere_ipv6]
}
tags = {
  "Name" = "websgfromtf"
}
}
resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.ntier_vpc.id
  description      = local.default_description
  ingress {    
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
      }
  ingress {
    from_port        = local.app_port
    to_port          = local.app_port
    protocol         = local.tcp
    cidr_blocks      = [var.vpc_cidr_range]
      }
     egress {
    from_port        = local.all_ports
    to_port          = local.all_ports
    protocol         = local.any_protocal
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = [local.anywhere_ipv6]
}
tags = {
  "Name" = "appsgfromtf"
}
}
