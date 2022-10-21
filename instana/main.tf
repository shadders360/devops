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

resource "azurerm_resource_group" "resource_rg" {
    name      = "rg-${var.service_name}-${var.environment}-${var.deployment_number}"
    location  = var.location
    tags      = var.default_tags
}

resource "instana_application_config" "rpa_application" {
  label              = "AzNonProdRPA"
  match_specification = "entity.azure.resourcegroup:rg-uipathapps-nonprod-001"
}
