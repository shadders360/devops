# terraform.hcl
locals {
    # Automatically load subscription variables
    subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))

    # Automatically load region-level variables
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

    # Automatically load environment-level variables
    environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

    storage_account_name = "strpa${local.environment}tfstates"

    location          = local.region_vars.locals.location
    environment       = local.environment_vars.locals.environment
    subscription_id   = local.subscription_vars.locals.subscription_id

    tags = {
        environment   = local.environment_vars.locals.environment
        service_code  = "888"
        service_name  = "instana"
    }
}   

# Generate Azure providers
generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
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
            instana = {
                source = "gessnerfl/instana"
                version = "1.5.2"
            }
        }

    }

    provider "azurerm" {
        features {}
        subscription_id = "${local.subscription_id}"
    }

EOF
}

remote_state {
    backend = "azurerm"
    config = {
        subscription_id = "${local.subscription_id}"
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "dvla-rpa-tfstate-rg"
        storage_account_name = local.storage_account_name
        container_name = "environment-states"
    }
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-subscription configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.subscription_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  tomap({default_tags = local.tags})
)







