output "azurerm_linux_virtual_machine_project_vm1" {
  value     = azurerm_linux_virtual_machine.project-vm1
  sensitive = true
}

output "azurerm_network_interface_project_nic" {
  value = azurerm_network_interface.project-nic
}

output "azurerm_public_ip_project_pip" {
  value = azurerm_public_ip.project-pip
}

output "azurerm_network_security_group_project_nsg1" {
  value = azurerm_network_security_group.project-nsg1
}

output "azurerm_subnet_project_subnet1" {
  value = azurerm_subnet.project-subnet1
}

output "azurerm_virtual_network_project_vnet" {
  value = azurerm_virtual_network.project-vnet
}

output "azurerm_resource_group_project_rg" {
  value = azurerm_resource_group.project-rg
}

output "public_ip" {
  value = azurerm_public_ip.project-pip.ip_address
}
