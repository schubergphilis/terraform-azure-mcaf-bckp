resource "azurerm_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_recovery_services_vault" "vault" {
  name                          = var.vault.name
  location                      = var.vault.location
  resource_group_name           = azurerm_resource_group.rg.name
  sku                           = var.vault.sku
  soft_delete_enabled           = var.vault.soft_delete_enabled
  public_network_access_enabled = var.vault.public_network_access_enabled
}

resource "azurerm_storage_account" "sa" {
  name                          = var.storage_account.name
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.storage_account.location
  access_tier                   = var.storage_account.access_tier
  account_tier                  = var.storage_account.account_tier
  account_replication_type      = var.storage_account.account_replication_type
  account_kind                  = "storagev2"
  min_tls_version               = var.storage_account.min_tls_version
  public_network_access_enabled = var.storage_account.public_network_access_enabled
}

resource "azurerm_private_endpoint" "recovery_services_vault_pe" {
  name                = "${var.vault.name}-pe"
  location            = var.vault.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.vault.name}-pe-connection"
    private_connection_resource_id = azurerm_recovery_services_vault.vault.id
    subresource_names              = ["AzureBackup"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "storage_account_pe" {
  name                = "${var.storage_account.name}-pe"
  location            = var.storage_account.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.storage_account.name}-pe-connection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
