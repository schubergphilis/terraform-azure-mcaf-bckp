variable "deploy_backup_policy_vm" {
  description = "Deploy Backup Policy VM (Required)"
  type        = bool # Set to true (Deploy) or false (don't deploy) (Required)
}

variable "resource_group" {
  description = "Resource Group (Required)"
  type = object({
    name     = string # Resource Group Name (Required)
    location = string # Resource Group Location (Required)
  })
}

variable "azurerm_recovery_services_vault" {
  description = "Recovery Services Vault (Optional)"
  type = object({
    name     = string # Vault Name (Required)
    location = string # Vault Location (Optional, defaults to resource_group.location)
    sku      = string # SKU (Optional, defaults to 'standard')
  })
}

variable "backup_policy_vm" {
  description = "Backup Policy VM (Required)"
  type = object({
    timezone                 = string # Timezone (Required)
    runtime                  = string # Runtime (Required)
    retention_daily_count    = number # Retention Daily Count (Required)
    retention_weekly_count   = number # Retention Weekly Count (Required)
    retention_weekly_weekday = string # Retention Weekly Weekday (Required)
    retention_monthly_count  = number # Retention Monthly Count (Required)
    retention_monthly_weeks  = string # Retention Monthly Weeks (Required)
    retention_yearly_count   = number # Retention Yearly Count (Required)
    retention_yearly_months  = string # Retention Yearly Months (Required)
  })
}

variable "storage_account" {
  description = "Storage Account (Optional)"
  type = object({
    name                     = string # Storage Account Name (Required)
    location                 = string # Storage Account Location (Optional, defaults to resource_group.location)
    access_tier              = string # Access Tier (Required)
    account_tier             = string # Account Tier (Required)
    account_replication_type = string # Account Replication Type (Required)
  })
}

variable "recovery_services_vault_pe" {
  description = "Recovery Services Vault Private Endpoint (Optional)"
  type = object({
    name      = string # Private Endpoint Name (Required)
    location  = string # Private Endpoint Location (Optional, defaults to resource_group.location)
    subnet_id = string # Subnet ID (Required)
  })
}

variable "storage_account_pe" {
  description = "Storage Account Private Endpoint (Optional)"
  type = object({
    name      = string # Private Endpoint Name (Required)
    location  = string # Private Endpoint Location (Optional, defaults to resource_group.location)
    subnet_id = string # Subnet ID (Required)
  })
}
