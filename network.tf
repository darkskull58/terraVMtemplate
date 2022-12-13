/*
terraform {
  backend "azure" {}
}
*/
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  depends_on = [
    azurerm_resource_group.example
  ]
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_virtual_network.example
  ]
}
resource "azurerm_public_ip" "example" {
  count = local.count
  name                = "acceptanceTestPublicIp1${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.example
  ]
}

resource "azurerm_network_interface" "example" {
  count= local.count
  name = "myint${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal${count.index}"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example[count.index].id

  }
  depends_on = [
    azurerm_subnet.example
  ]
}