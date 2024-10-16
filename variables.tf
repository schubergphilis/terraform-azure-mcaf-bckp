variable "resource_group" {
  description = "Resource Group"
  type = object({
    name     = string
    location = string
  })
}

variable "azurerm_recovery_services_vault" {
  description = "Recovery Services Vault"
  type = object({
    name                          = string
    location                      = string
    sku                           = string
    soft_delete_enabled           = bool
    public_network_access_enabled = bool
  })
  default = {
    location                      = var.resource_group.location
    sku                           = "standard"
    soft_delete_enabled           = true
    public_network_access_enabled = false
  }
}

variable "storage_account" {
  description = "Storage Account"
  type = object({
    name                          = string
    location                      = string
    access_tier                   = string
    account_tier                  = string
    account_replication_type      = string
    min_tls_version               = string
    public_network_access_enabled = bool
  })
  default = {
    location                      = var.resource_group.location
    min_tls_version               = "1.2"
    public_network_access_enabled = false
  }
}

variable "recovery_services_vault_pe" {
  description = "Recovery Services Vault Private Endpoint"
  type = object({
    name      = string
    location  = string
    subnet_id = string
  })
  default = {
    location  = var.resource_group.location
  }
}

variable "storage_account_pe" {
  description = "Storage Account Private Endpoint"
  type = object({
    name      = string
    location  = string
    subnet_id = string
  })
  default = {
    location  = var.resource_group.location
  }
}