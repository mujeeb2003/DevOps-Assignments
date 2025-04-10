# a. One block for resource group name.
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "lab03s1-rg"
}

# b. One block for location.
variable "location" {
  description = "The location for the resource group."
  type        = string
  default     = "East US"
}

# c. One block for virtual network name.
variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "lab03s1-vnet"
}

# d. One block for virtual network address space.
variable "virtual_network_address_space" {
  description = "values for the virtual network address space."
  type        = list(string)
  default     = ["10.0.0.0/16"]

}

# e. Two blocks for subnet names (one per subnet).
variable "subnet_name_1" {
  description = "The name of the first subnet."
  type        = string
  default     = "lab03s1-subnet1"
}
variable "subnet_name_2" {
  description = "The name of the second subnet."
  type        = string
  default     = "lab03s1-subnet2"
}

# f. Two blocks for subnet address spaces (one per address space).
variable "subnet1-address-space" {
  description = "values for the subnet address space."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "subnet2-address-space" {
  description = "values for the subnet address space."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

# g. Two blocks for network security groups (one per network security group).
variable "network_security_group_1" {
  description = "The name of the first network security group."
  type        = string
  default     = "lab03s1-nsg1"
}
variable "network_security_group_2" {
  description = "The name of the second network security group."
  type        = string
  default     = "lab03s1-nsg2"
}
