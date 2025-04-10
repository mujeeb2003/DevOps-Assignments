resource "azurerm_resource_group" "lab03s1-rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "lab03s1-vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.lab03s1-rg.location
  resource_group_name = azurerm_resource_group.lab03s1-rg.name
  address_space       = var.virtual_network_address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
resource "azurerm_subnet" "lab03s1-subnet1" {
  name                 = var.subnet_name_1
  resource_group_name  = azurerm_resource_group.lab03s1-rg.name
  virtual_network_name = azurerm_virtual_network.lab03s1-vnet.name
  address_prefixes     = var.subnet1-address-space
}
resource "azurerm_network_security_group" "lab03s1-nsg1" {
  name                = var.network_security_group_1
  location            = azurerm_resource_group.lab03s1-rg.location
  resource_group_name = azurerm_resource_group.lab03s1-rg.name
  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "lab03s1-subnet1-nsg1" {
  subnet_id                 = azurerm_subnet.lab03s1-subnet1.id
  network_security_group_id = azurerm_network_security_group.lab03s1-nsg1.id
}

resource "azurerm_subnet" "lab03s1-subnet2" {
  name                 = var.subnet_name_2
  resource_group_name  = azurerm_resource_group.lab03s1-rg.name
  virtual_network_name = azurerm_virtual_network.lab03s1-vnet.name
  address_prefixes     = var.subnet2-address-space
}
resource "azurerm_network_security_group" "lab03s1-nsg2" {
  name                = var.network_security_group_2
  location            = azurerm_resource_group.lab03s1-rg.location
  resource_group_name = azurerm_resource_group.lab03s1-rg.name
  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "lab03s1-subnet2-nsg2" {
  subnet_id                 = azurerm_subnet.lab03s1-subnet2.id
  network_security_group_id = azurerm_network_security_group.lab03s1-nsg2.id
}