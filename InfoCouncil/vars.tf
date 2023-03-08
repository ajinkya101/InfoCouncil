variable "rg_name" {}
variable "location" {}
variable "tenant_id" {}

# variable "vnet_name" {}
# variable "vnet_space" {}

variable "subnet1_id" {}
variable "subnet2_id" {}
variable "subnet3_id" {}
variable "subnet4_id" {}

# variable "nsg1_name" {}
# variable "nsg2_name" {}
# variable "nsg3_name" {}
# variable "nsg4_name" {}

variable "tags" {}

#Variables for Storage Account
# variable "account_replication_type" {}
# variable "sa_name" {}
# variable "account_kind" {}
# variable "account_tier" {}
# variable "access_tier" {}
# variable "min_tls_version" {}

#Variables for Container Registry
variable "container_registry_name" {}

#Variables for SQL Server
variable "ss_dns_name" {}
variable "ss_dns_a_record_name" {}
variable "ss_privateendpoint_name" {}
variable "ss_psc_name" {}
variable "ss_dzg_name" {}
variable "ss_name" {}
variable "ss_ep_name" {}

#Variables for Keyvault
variable "kv_dns_name" {}
variable "kv_dns_a_record_name" {}
variable "kv_privateendpoint_name" {}
variable "kv_psc_name" {}
variable "kv_dzg_name" {}
variable "kv_name" {}
variable "kv_sku_name" {}

#Variables for Storage Account
variable "sa_dns_name" {}
variable "sa_dns_a_record_name" {}
variable "sa_privateendpoint_name" {}
variable "sa_psc_name" {}
variable "sa_dzg_name" {}
variable "sa_name" {}

#Variables for Container App Environment (CAE)
variable "cae_dns_name" {}
variable "cae_dns_a_record_name" {}
variable "cae_name" {}
variable "aw_name" {}

#Variables for Bastion
variable "bastion_subnet_id" {}
variable "bastion_pip_name" {}
variable "bastion_name" {}
variable "bastion_allocation_method" {
    default = "Static"
}
variable "bastion_sku" {
    default = "Standard"
}

#Variables for Windows vm
variable "virtual_machine_name" {}
variable "private_ip_address_allocation_type" {
    default = "Dynamic"
}
variable "private_ip_address" {
    default = null
}
variable "virtual_machine_size" {
    default = "Standard_B2s"
}
variable "admin_username" {}
variable "admin_password" {}
variable "os_disk_storage_account_type" {
    default = "Standard_LRS"
}
variable "os_disk_caching" {
    default = "ReadWrite"
}
variable "os_publisher" {
    default = "MicrosoftWindowsServer"
}
variable "os_offer" {
    default = "WindowsServer"
}
variable "os_sku" {
    default = "2016-Datacenter"
}
variable "os_version" {
    default = "latest"
}
variable "random_password_length" {
  description = "The desired length of random password created by this module"
  default     = 24
}