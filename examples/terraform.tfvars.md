deploy_backup_policy_vm = false

resource_group = {
    name     = "rg-backupservicetst-gs"
    location = "westeurope"
}

vault = {
    name     = "example-vault"
    location = ""
    sku      = "Standard"
}

backup_policy_vm = {
    timezone                 = "UTC"
    runtime                  = "23:00"
    retention_daily_count    = 7
    retention_weekly_count   = 4
    retention_weekly_weekday = ["Monday"]
    retention_monthly_count  = 12
    retention_monthly_weeks  = ["First"]
    retention_monthly_weekdays = ["Monday"]
    retention_yearly_count   = 2
    retention_yearly_months  = ["January"]
    retention_yearly_weeks   = ["First"]
    retention_yearly_weekdays = ["Monday"]
}

storage_account = {
    name                     = "stgbckservice12"
    location                 = ""
    access_tier              = "Hot"
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

recovery_services_vault_pe = {
    name      = "example-pe"
    location  = ""
    subnet_id = "/subscriptions/b5f5e722-d325-4261-98e1-81d2d707bd86/resourceGroups/gs-backupservice-vnet/providers/Microsoft.Network/virtualNetworks/backupservice-vnet/subnets/backup"
}

storage_account_pe = {
    name      = "example-pe"
    location  = ""
    subnet_id = "/subscriptions/b5f5e722-d325-4261-98e1-81d2d707bd86/resourceGroups/gs-backupservice-vnet/providers/Microsoft.Network/virtualNetworks/backupservice-vnet/subnets/strorage"
}