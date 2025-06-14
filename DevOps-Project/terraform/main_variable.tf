variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
    default = "project-rg"  
}

variable "location" {
    description = "The location for the resource"
    type        = string
    default = "East US"
}

variable "vnet_name" {
    description = "The name of the virtual network"
    type        = string
    default = "project-vnet"
}

variable "vnet_address_space" {
    description = "The address space for the virtual network"
    type        = list(string)
    default = ["10.0.0.0/16"]
}

variable "vnet_dns_servers" {
    description = "The DNS servers for the virtual network"
    type        = list(string)
    default = ["10.0.0.4","10.0.0.5"]
}

variable "subnet_name_1" {
    description = "The name of the first subnet"
    type        = string
    default = "project-subnet1"
}

variable "subnet_address_space_1" {
    description = "The address space for the first subnet"
    type        = list(string)
    default = ["10.0.1.0/24"]
}

variable "nsg-name" {
    description = "The name of the network security group"
    type        = string
    default = "project-nsg1"
}
