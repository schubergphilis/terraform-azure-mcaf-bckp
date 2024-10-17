# Boolean variable to determine if the backup policy for VMs should be deployed
variable "deploy_backup_policy_vm" {
  type = bool
  default = false
}

# Object variable to define the resource group details
variable "resource_group" {
  type = object({
    name     = string # Name of the resource group
    location = string # Location of the resource group 
  })
}

# Object variable to define the vault details
variable "vault" {
  type = object({
    name     = string # Name of the vault
    location = string # Location of the vault - Unless specified, it will be the same as the resource group location
    sku      = string # SKU (pricing tier) of the vault
  })
}

# Object variable to define the backup policy for VMs
variable "backup_policy_vm" {
  type = object({
    timezone                   = string       # Timezone for the backup policy
    time                       = string       # Set the time you want the backup to run
    retention_daily_count      = number       # Number of daily backups to retain
    retention_weekly_count     = number       # Number of weekly backups to retain
    retention_weekly_weekday   = list(string) # List of weekdays for weekly backups
    retention_monthly_count    = number       # Number of monthly backups to retain
    retention_monthly_weeks    = list(string) # List of weeks for monthly backups
    retention_monthly_weekdays = list(string) # List of weekdays for monthly backups
    retention_yearly_count     = number       # Number of yearly backups to retain
    retention_yearly_weekdays  = list(string) # List of weekdays for yearly backups
    retention_yearly_weeks     = list(string) # List of weeks for yearly backups
    retention_yearly_months    = list(string) # List of months for yearly backups
  })
}

# Object variable to define the storage account details
variable "storage_account" {
  type = object({
    name                     = string # Name of the storage account
    location                 = string # Location of the storage account - Unless specified, it will be the same as the resource group location
    access_tier              = string # Access tier of the storage account (e.g., Hot, Cool)
    account_tier             = string # Account tier of the storage account (e.g., Standard, Premium)
    account_replication_type = string # Replication type of the storage account (e.g., LRS, GRS)
  })
}

# Object variable to define the recovery services vault private endpoint details
variable "recovery_services_vault_pe" {
  type = object({
    name      = string # Name of the private endpoint
    location  = string # Location of the private endpoint - Unless specified, it will be the same as the vault location
    subnet_id = string # Subnet ID for the private endpoint
  })
}

# Object variable to define the storage account private endpoint details
variable "storage_account_pe" {
  type = object({
    name      = string # Name of the private endpoint
    location  = string # Location of the private endpoint - Unless specified, it will be the same as the storage account location
    subnet_id = string # Subnet ID for the private endpoint
  })
}
