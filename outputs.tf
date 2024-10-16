output "azurerm_resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "azurerm_recovery_services_vault_id" {
  value = azurerm_recovery_services_vault.vault.id
}

output "azurerm_backup_policy_vm_id" {
  value = azurerm_backup_policy_vm.vmbackuppolicy[0].id
}

output "azurerm_storage_account_id" {
  value = azurerm_storage_account.sa.id
}

output "azurerm_private_endpoint_recovery_services_vault_id" {
  value = azurerm_private_endpoint.recovery_services_vault_pe.id
}

output "azurerm_private_endpoint_storage_account_id" {
  value = azurerm_private_endpoint.storage_account_pe.id
}