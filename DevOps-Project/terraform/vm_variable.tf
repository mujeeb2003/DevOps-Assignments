variable "virtual_machine_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "project-vm1"
}

variable "virtual_machine_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1ms"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "mujeeb2112345"
}

variable "mujeeb-pub-key" {
  description = "Public key for SSH access"
  type        = string
  default     = "/home/jenkins/.ssh/id_rsa.pub"
}

variable "virtual_machine_os_disk_storage_account_type" {
  description = "Storage account type for the OS disk"
  type        = string
  default     = "Premium_LRS"
}

variable "virtual_machine_os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 32
}

variable "virtual_machine_os_disk_caching" {
  description = "Caching type for the OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "virtual_machine_os_publisher" {
  description = "Publisher of the OS image"
  type        = string
  default     = "Canonical"
}

variable "virtual_machine_os_offer" {
  description = "Offer of the OS image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "virtual_machine_os_sku" {
  description = "SKU of the OS image"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "virtual_machine_os_version" {
  description = "Version of the OS image"
  type        = string
  default     = "latest"
}
