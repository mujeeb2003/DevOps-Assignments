# resource group
resource "azurerm_resource_group" "project-rg" {
  name     = var.resource_group_name
  location = var.location
}

# vnet
resource "azurerm_virtual_network" "project-vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.project-rg.location
  resource_group_name = azurerm_resource_group.project-rg.name
  address_space       = var.vnet_address_space
  # dns_servers         = var.vnet_dns_servers
}

# subnet
resource "azurerm_subnet" "project-subnet1" {
  name                 = var.subnet_name_1
  resource_group_name  = azurerm_resource_group.project-rg.name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = var.subnet_address_space_1
}

# network security group
resource "azurerm_network_security_group" "project-nsg1" {
  name                = var.nsg-name
  location            = azurerm_resource_group.project-rg.location
  resource_group_name = azurerm_resource_group.project-rg.name
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
  security_rule {
    name                       = "rule2"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg1-subnet1" {
  subnet_id                 = azurerm_subnet.project-subnet1.id
  network_security_group_id = azurerm_network_security_group.project-nsg1.id
}

# network interface
resource "azurerm_network_interface" "project-nic" {
  name                = "${var.virtual_machine_name}-nic"
  location            = azurerm_resource_group.project-rg.location
  resource_group_name = azurerm_resource_group.project-rg.name

  ip_configuration {
    name                          = "${var.virtual_machine_name}-ipconfig1"
    subnet_id                     = azurerm_subnet.project-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.project-pip.id
  }

}
resource "azurerm_public_ip" "project-pip" {
  name                = "${var.virtual_machine_name}-pip"
  location            = azurerm_resource_group.project-rg.location
  resource_group_name = azurerm_resource_group.project-rg.name
  allocation_method   = "Dynamic"
}

# virtual machine
resource "azurerm_linux_virtual_machine" "project-vm1" {
  name                = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.project-rg.name
  location            = azurerm_resource_group.project-rg.location
  size                = var.virtual_machine_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.project-nic.id
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
