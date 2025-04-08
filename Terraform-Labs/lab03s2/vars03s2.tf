# a. Name (e.g., linux_name): "lab03s2-db1-u-vm1".
variable "virtual_machine_name" {
    description = "Name of the virtual machine"
    type        = string
    default     = "lab03s2-db1-u-vm1"
}

# b. Size: "Standard_B1s".
variable "virtual_machine_size" {
    description = "Size of the virtual machine"
    type        = string
    default     = "Standard_B1s"
}

# c. Admin user name: "<firstname-yourHumberID>" [from Lab 01].
variable "admin_username" {
    description = "Admin username for the virtual machine"
    type        = string
    default     = "mujeeb2112345"
}

# d. Public key: "C:\Users\<YourWindowsUsername>\.ssh\id_rsa.pub" (adjust path to your SSH public key location on Windows).
variable "mujeeb-pub-key" {
    description = "Public key for SSH access"
    type        = string
    default     = "C:\\Users\\mmuje\\.ssh\\id_rsa.pub"
}

# e. OS disk attributes:
# i. Storage account type: "Premium_LRS".
# ii. Disk size: "32".
# iii. Caching: "ReadWrite".
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

# f. Ubuntu Linux OS information:
# i. Publisher: "Canonical".
# ii. Offer: "UbuntuServer".
# iii. Sku: "19.04".
# iv. Version: "latest".
variable "virtual_machine_os_publisher" {
    description = "Publisher of the OS image"
    type        = string
    default     = "Canonical"
}
variable "virtual_machine_os_offer" {
    description = "Offer of the OS image"
    type        = string
    default     = "UbuntuServer"
}
variable "virtual_machine_os_sku" {
    description = "SKU of the OS image"
    type        = string
    default     = "18.04-LTS"
}
variable "virtual_machine_os_version" {
    description = "Version of the OS image"
    type        = string
    default     = "latest"
}
