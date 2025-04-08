terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "lab02-rg" {
    name     = "lab02-rg"
    location = "East US"
}

resource "azurerm_virtual_network" "lab02-vnet" {
    name                = "lab02-vnet"
    location            = azurerm_resource_group.lab02-rg.location
    resource_group_name = azurerm_resource_group.lab02-rg.name
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "lab02-subnet1" {
    name                 = "lab02-subnet1"
    resource_group_name  = azurerm_resource_group.lab02-rg.name
    virtual_network_name = azurerm_virtual_network.lab02-vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "lab02-nsg1" {
    name                = "lab02-nsg1"
    location            = azurerm_resource_group.lab02-rg.location
    resource_group_name = azurerm_resource_group.lab02-rg.name
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

resource "azurerm_subnet_network_security_group_association" "lab02-subnet1-nsg1" {
    subnet_id                 = azurerm_subnet.lab02-subnet1.id
    network_security_group_id = azurerm_network_security_group.lab02-nsg1.id
}

resource "azurerm_subnet" "lab02-subnet2" {
    name                 = "lab02-subnet2"
    resource_group_name  = azurerm_resource_group.lab02-rg.name
    virtual_network_name = azurerm_virtual_network.lab02-vnet.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "lab02-nsg2" {
    name                = "lab02-nsg2"
    location            = azurerm_resource_group.lab02-rg.location
    resource_group_name = azurerm_resource_group.lab02-rg.name
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

resource "azurerm_subnet_network_security_group_association" "lab02-subnet2-nsg2" {
    subnet_id                 = azurerm_subnet.lab02-subnet2.id
    network_security_group_id = azurerm_network_security_group.lab02-nsg2.id
}