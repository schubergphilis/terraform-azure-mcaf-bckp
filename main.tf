resource "azurerm_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_recovery_services_vault" "vault" {
  name                          = var.vault.name
  location                      = coalesce(var.vault.location, azurerm_resource_group.rg.location)
  resource_group_name           = azurerm_resource_group.rg.name
  sku                           = var.vault.sku
  soft_delete_enabled           = true
  public_network_access_enabled = false
}

resource "azurerm_storage_account" "sa" {
  name                          = var.storage_account.name
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = coalesce(var.storage_account.location, azurerm_resource_group.rg.location)
  access_tier                   = var.storage_account.access_tier
  account_tier                  = var.storage_account.account_tier
  account_replication_type      = var.storage_account.account_replication_type
  account_kind                  = "StorageV2"
  min_tls_version               = "tls1_2"
  public_network_access_enabled = false
}

resource "azurerm_backup_policy_vm" "vmbackuppolicy" {
  count               = var.deploy_backup_policy_vm ? 1 : 0
  name                = "${var.vault.name}-vmpolicy"
  resource_group_name = azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  timezone            = var.backup_policy_vm.timezone
  backup {
    frequency = "Daily"
    time      = var.backup_policy_vm.runtime
  }
  retention_daily {
    count = var.backup_policy_vm.retention_daily_count
  }
  retention_weekly {
    count    = var.backup_policy_vm.retention_weekly_count
    weekdays = var.backup_policy_vm.retention_weekly_weekday
  }
  retention_monthly {
    count = var.backup_policy_vm.retention_monthly_count
    weeks = var.backup_policy_vm.retention_monthly_weeks
  }
  retention_yearly {
    count  = var.backup_policy_vm.retention_yearly_count
    months = var.backup_policy_vm.retention_yearly_months
  }
}

resource "azurerm_private_endpoint" "recovery_services_vault_pe" {
  name                = "${var.vault.name}-pe"
  location            = coalesce(var.vault.location, azurerm_resource_group.rg.location)
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.recovery_services_vault_pe.subnet_id

  private_service_connection {
    name                           = "${var.vault.name}-pe-connection"
    private_connection_resource_id = azurerm_recovery_services_vault.vault.id
    subresource_names              = ["AzureBackup"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "storage_account_pe" {
  name                = "${var.storage_account.name}-pe"
  location            = coalesce(var.storage_account.location, azurerm_resource_group.rg.location)
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.storage_account_pe.subnet_id

  private_service_connection {
    name                           = "${var.storage_account.name}-pe-connection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
