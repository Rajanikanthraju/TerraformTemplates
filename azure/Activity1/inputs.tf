variable "arg_location" {
    type =string
    default = "South India"  
}
variable "az_ntier" {
    type = list(string)
    default = [ "10.10.0.0/16" ]
    description = "Azure virtual network"
  
}
variable "name_tags" {
    type= list(string)
    default=["web1-tf","web2-tf","app1-tf","app2-tf","db1-tf","db2-tf"]
  
}