variable "region" {
    type = string
    default = "ap-southeast-1"
    description = "target region where resource can be created"
  
}
variable "vpc_cidr_range" {
    type = string
    default = "10.10.0.0/16"
    description = "VPC cidr range"  
}
variable "name_tags" {
    type= list(string)
    default=["web1-tf","web2-tf","app1-tf","app2-tf","db1-tf","db2-tf"]
  
}
variable "bucket" {
    type= string
    default="from-tf-test-bucket"
    description = "bucket name"
  
}
variable "public_subnets" {
    type =list(string)
    default=["web1-tf","web2-tf"]
  
}
variable "db_subnets" {
    type =list(string)
    default=["db1-tf","db2-tf"]
  
}