# a. Define network interface called ${var.linux_name}-nic with IP configuration name
# ${var.linux_name}-ipconfig1 using azurerm_network_interface. Use Dynamic IP address allocation.
resource "azurerm_network_interface" "lab03s2-nic" {
  name                = "${var.virtual_machine_name}-nic"
  location            = azurerm_resource_group.lab03s1-rg.location
  resource_group_name = azurerm_resource_group.lab03s1-rg.name

  ip_configuration {
    name                          = "${var.virtual_machine_name}-ipconfig1"
    subnet_id                     = azurerm_subnet.lab03s1-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.lab03s2-pip.id
  }
}

# b. Define public IP address called ${var.linux_name}-pip using azurerm_public_ip. Use Dynamic IP
# address allocation method.
resource "azurerm_public_ip" "lab03s2-pip" {
  name                = "${var.virtual_machine_name}-pip"
  location            = azurerm_resource_group.lab03s1-rg.location
  resource_group_name = azurerm_resource_group.lab03s1-rg.name
  allocation_method   = "Dynamic"
}

# c. Define virtual machine using azurerm_linux_virtual_machine. Use ${var.linux_name}-osdisk as the
# OS disk name.
resource "azurerm_linux_virtual_machine" "lab03s2-vm" {
  name                = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.lab03s1-rg.name
  location            = azurerm_resource_group.lab03s1-rg.location
  size                = var.virtual_machine_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.lab03s2-nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.mujeeb-pub-key)
  }

  os_disk {
    name                 = "${var.virtual_machine_name}-osdisk"
    caching              = var.virtual_machine_os_disk_caching
    storage_account_type = var.virtual_machine_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.virtual_machine_os_publisher
    offer     = var.virtual_machine_os_offer
    sku       = var.virtual_machine_os_sku
    version   = var.virtual_machine_os_version
  }
}
