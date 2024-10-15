variable "resource_group" {
  description = "Resource Group"
  type        = object({
    name     = string
    location = string
  })
}

variable "storage_account" {
    description = "Storage Account"
    type        = object({
        name                     = string
        location                 = string
        account_tier             = string
        account_replication_type = string
    })
  
}