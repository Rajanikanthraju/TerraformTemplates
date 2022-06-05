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
variable "az_a" {
    type = string
    default = "ap-southeast-1a"
    description = "availability zone a subnet"
  
}
variable "az_b" {
    type = string
    default = "ap-southeast-1b"
    description = "availability zone of b subnet"
  
}
variable "bucket" {
    type= string
    default="from-tf-test-bucket"
    description = "bucket name"
  
}