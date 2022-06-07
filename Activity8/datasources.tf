data "aws_subnets" "db_subnet_group" {
    filter {
    name   = "vpc-id"
    values = [aws_vpc.ntier_vpc.id]
  }
    filter {
    name   = "tag:Name"
    values = var.db_subnets 
  }
  
}