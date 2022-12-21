# output "rg_name" {
#     value = azurerm_resource_group.bootstrap.name
# }

# output "storage_account_name" {
#     value = azurerm_storage_account.bootstrap.name
# }

output "azureca_names" {
    value = azurecaf_name.bootstrap_name
}