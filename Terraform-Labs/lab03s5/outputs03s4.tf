# a. VM hostname (1 block).
output "vm_hostname" {
  value = azurerm_linux_virtual_machine.lab03s3-vm.name
}

# b. Private IP address (1 block) and Public IP address (1 block).
output "private_ip_address" {
    value = azurerm_network_interface.lab03s3-nic.private_ip_address
}

# c. Virtual network name (1 block) and address space (1 block).
output "vnet_name" {
    value = azurerm_virtual_network.lab03s1-vnet.name
}
output "vnet_address_space" {
    value = azurerm_virtual_network.lab03s1-vnet.address_space
}

# d. Subnet names (2 blocks) and address spaces (2 blocks).
output "subnet_name_1" {
    value = azurerm_subnet.lab03s1-subnet1.name
}
output "subnet_address_space_1" {
    value = azurerm_subnet.lab03s1-subnet1.address_prefixes
}
output "subnet_name_2" {
    value = azurerm_subnet.lab03s1-subnet2.name
}
output "subnet_address_space_2" {
    value = azurerm_subnet.lab03s1-subnet2.address_prefixes
}
