tags                                = {
    Environment                     = "Dev"
    Developer                       = "Depal Dhir"
    Workload                        = "PRCP"
    Team                            = "Hybrid Cloud"
    Purpose                         = "Pipeline 1"
}

#Variables for Resource Groups
rg_name                             = "d-auea-info-rg-prcp-cust"
location                            = "australiaeast"
tenant_id                           = "4b7e7b89-9ba4-473a-a11b-42f5f814c887"

# #Variables for Virtual Networks (VNets)
# vnet_name                           = "d-auea-info-vn-prcp-cust"
# vnet_space                          = "10.100.96.0/20"

# #Variables for Subnets
# subnet1_name                        = "d-auea-info-sn-db"
# subnet1_address                     = "10.100.102.0/24"

# subnet2_name                        = "d-auea-info-sn-con"
# subnet2_address                     = "10.100.104.0/22"

# subnet3_name                        = "d-auea-info-sn-vmss"
# subnet3_address                     = "10.100.106.0/22"

# subnet4_name                        = "d-auea-info-sn-app"
# subnet4_address                     = "10.100.98.0/24"

# #Variables for Network Security Groups
# nsg1_name                           = "d-auea-info-nsg-db"
# nsg2_name                           = "d-auea-info-nsg-con"
# nsg3_name                           = "d-auea-info-nsg-vmss"
# nsg4_name                           = "d-auea-info-nsg-app"

#Variables for SQL Server DNS
ss_dns_name                         = "privatelink.database.windows.net"
ss_dns_a_record_name                = "infocouncil"

#Variables for Azure Private Endpoint (SQL Server)
ss_privateendpoint_name             = "d-auea-info-sspe-01"
ss_psc_name                         = "sql-server-private-service-connection"
ss_dzg_name                         = "sql-server-private-endpoint-dns-zone-group"

#Variables for SQL Server
ss_name                             = "d-auea-info-ss-01"
subnet1_id                          = "/subscriptions/b867f15c-4e36-4dda-b7a9-53ba28fe2d21/resourceGroups/d-auea-info-rg-prcp-cust/providers/Microsoft.Network/virtualNetworks/d-auea-info-vn-prcp-cust/subnets/d-auea-info-sn-db"

#Variables for Elastic Pool
ss_ep_name                          = "d-auea-info-ep-01"

#Variables for Storage Account DNS
sa_dns_name                         = "privatelink.blob.core.windows.net"
sa_dns_a_record_name                = "storage"
      
#Variables for Storage Account
sa_name                             = "daueainfosaapp01"   
subnet4_id                          = "/subscriptions/b867f15c-4e36-4dda-b7a9-53ba28fe2d21/resourceGroups/d-auea-info-rg-prcp-cust/providers/Microsoft.Network/virtualNetworks/d-auea-info-vn-prcp-cust/subnets/d-auea-info-sn-app"

#Variables for Azure Private Endpoint (Storage Account)
sa_privateendpoint_name             = "d-auea-info-sape-01"
sa_psc_name                         = "storageaccount-private-service-connection"
sa_dzg_name                         = "storageaccount-private-endpoint-dns-zone-group"

#Variables for Container Registry
container_registry_name             = "daueainfocouncilcrcust01"

#Variables for Keyvault
kv_name                             = "d-auea-info-kv-01-981"

#Variables for Keyvault DNS
kv_dns_name                         = "privatelink.vaultcore.azure.net"
kv_dns_a_record_name                = "keyvault"
kv_sku_name                         = "standard"

#Variables for Azure Private Endpoint (Keyvault)
kv_privateendpoint_name             = "d-auea-info-kvpe-01"
kv_psc_name                         = "keyvault-private-service-connection"
kv_dzg_name                         = "keyvault-private-endpoint-dns-zone-group"

#Variables for Container Apps Environment (CAE)
cae_name                            = "d-auea-info-cae-01"
cae_dns_name                        = "cae.azurecontainerapps.io"
cae_dns_a_record_name               = "azurecontainerapps.io"
subnet2_id                          = "/subscriptions/b867f15c-4e36-4dda-b7a9-53ba28fe2d21/resourceGroups/d-auea-info-rg-prcp-cust/providers/Microsoft.Network/virtualNetworks/d-auea-info-vn-prcp-cust/subnets/d-auea-info-sn-con"
aw_name                             = "analyticsworkspace"
subnet3_id                          = "/subscriptions/b867f15c-4e36-4dda-b7a9-53ba28fe2d21/resourceGroups/d-auea-info-rg-prcp-cust/providers/Microsoft.Network/virtualNetworks/d-auea-info-vn-prcp-cust/subnets/d-auea-info-sn-vmss"

#Variables for bastion hosts
bastion_subnet_id                   = ""
bastion_pip_name                    = "bastion-pip-01"
bastion_name                        = "bastion-dev-01"

#Variables for Windows vm
virtual_machine_name                = "bastion-vm-dev"
admin_username                      = "DemoAzure"
