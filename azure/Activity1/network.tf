resource "azurerm_resource_group" "arg" {
    name="argfromtf"
    location = var.arg_location
  
}
resource "azurerm_virtual_network" "avn" {
  name                = "avnfromtf"
  location            = var.arg_location
  resource_group_name = azurerm_resource_group.arg.name
  address_space       = var.az_ntier
}
resource "azurerm_subnet" "az_snet" {
count                  =length(var.name_tags)
  name                 = var.name_tags[count.index]
  resource_group_name  = azurerm_resource_group.arg.name
  virtual_network_name = azurerm_virtual_network.avn.name
  address_prefixes     = [cidrsubnet(var.az_ntier[0],8,count.index)]
}
