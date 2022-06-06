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
variable "cidr_range" {
    type = list(string)
    default = [ "10.10.0.0/24","10.10.1.0/24","10.10.2.0/24","10.10.3.0/24","10.10.4.0/24","10.10.5.0/24"]
    description = "cidr range of subnets"
  
}
variable "az" {
    type = list(string)
    default = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1a","ap-southeast-1b","ap-southeast-1a","ap-southeast-1b"]
    description = "availability zone a subnet"
  
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