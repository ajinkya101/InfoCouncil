tags = {
  Environment = "Dev"
  Developer   = "Depal Dhir"
  Workload    = "PRCP"
  Team        = "Hybrid Cloud"
  Purpose     = "Pipeline 1"
}

#Variables for Resource Groups
rg_name                             = "d-auea-info-rg-prcp-cust"
location                            = "australiaeast"
tenant_id                           = "4b7e7b89-9ba4-473a-a11b-42f5f814c887"

# #Variables for SQL Server
ss_name = "d-auea-info-ss-01"

#Variables for Elastic Pool
ss_ep_name = "d-auea-info-ep-01"

# #Variables for Container Apps (CA)
cae_name = "d-auea-info-cae-01"

# #Variables for Container Registry
user_identity           = "camapi"
container_registry_name = "daueainfocouncilcrcust01"

#Variables for Keyvault
kv_name = "d-auea-info-kv-01"