terraform {
     
    required_version = "~>1.3.0"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">=3.21.1"
        }
        azuread = {
            source  = "hashicorp/azuread"
            version = ">=2.28.1"
        }
        random = {
            source  = "hashicorp/random"
            version = ">=3.4.2"
        }
    }

  
}


resource "instana_application_config" "rpa_application" {
  label              = "AzSubRpaNonProd"
  scope               = "INCLUDE_ALL_DOWNSTREAM"  #Optional, default = INCLUDE_NO_DOWNSTREAM
  boundary_scope      = "INBOUND"  #Optional, default = INBOUND
  tag_filter       =  "cloud.azure.zone EQUALS 'uksouth'"
}
