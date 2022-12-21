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
        azurecaf = {
            source = "aztfmod/azurecaf"
            version = "2.0.0-preview3"
         }
    }

}

provider "azurerm" {
    features {}
}

resource "azurecaf_name" "bootstrap_name" {
    name            = "shadware"
    resource_types  = [ "azurerm_resource_group", "azurerm_storage_account" ]
    # prefixes        = ["a", "b"]
    suffixes        = ["us", "001"]
    random_length   = 5
    clean_input     = true
}

# resource "azurerm_resource_group" "bootstrap" {
#     location = var.location
#     name     = azurecaf_name.bootstrap_name.results["azurerm_resource_group"]
# }

# resource "azurerm_storage_account" "bootstrap" {
#     name                     = azurecaf_name.bootstrap_name.results["azurerm_storage_account"]
#     resource_group_name      = azurerm_resource_group.bootstrap.name
#     location                 = azurerm_resource_group.bootstrap.location
#     account_tier             = "Standard"
#     account_replication_type = "GRS"

# }

# resource "azurerm_storage_container" "terraform_state"  { 
#     name = "environment-states"  
#     storage_account_name = azurerm_storage_account.bootstrap.name
# }


#Storage account test
resource "azurecaf_name" "classic_st" {
  name          = "demo"
  resource_type = "azurerm_storage_account"
}

output "caf_name_classic_st" {
  value       = azurecaf_name.classic_st.result
  description = "Random result based on the resource type"
}
