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
  depends_on = [
  aws_vpc.ntier_vpc
]
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
 depends_on = [
  aws_vpc.ntier_vpc
] 
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
depends_on = [
  aws_vpc.ntier_vpc
]
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
depends_on = [
  aws_vpc.ntier_vpc
]
}
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.ntier_vpc.id
  description      = local.default_description
  ingress {    
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
      }
  ingress {
    from_port        = local.db_port
    to_port          = local.db_port
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
  "Name" = "dbsgfromtf"
}
depends_on = [
  aws_vpc.ntier_vpc
]
}
resource "aws_route_table" "publicrt" {
vpc_id = aws_vpc.ntier_vpc.id
route {
  cidr_block = local.anywhere
  gateway_id = aws_internet_gateway.igw.id
}
tags = {
  "Name" = "Public RT"
}
  
}
resource "aws_route_table" "privatert" {
vpc_id = aws_vpc.ntier_vpc.id
tags = {
  "Name" = "Private RT"
}
 
}

resource "aws_route_table_association" "associations" {
  count = length(aws_subnet.subnets)
  subnet_id = aws_subnet.subnets[count.index].id
  route_table_id = contains(var.public_subnets, lookup(aws_subnet.subnets[count.index].tags_all,"Name",""))? aws_route_table.publicrt.id : aws_route_table.privatert.id  
 # route_table_id = count.index <2 ? aws_route_table.publicrt.id : aws_route_table.privatert.id  
}