resource "aws_db_subnet_group" "rds_db_subnet_group" {
    name = local.db_subnet_group_name
    subnet_ids = data.aws_subnets.db_subnet_group.ids
    depends_on = [
      aws_subnet.subnets
    ]
  }
  resource "aws_db_instance" "db_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin123"
  skip_final_snapshot  = true
  identifier           ="mysqldbfromtf"
  db_subnet_group_name = local.db_subnet_group_name
}
    
  