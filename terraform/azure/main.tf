provider "azurerm" {
  features {}
}

resource "azurerm_log_analytics_workspace" "security_logs" {
  name                = "law-security-baseline"
  location            = "East US"
  resource_group_name = "rg-security"
  sku                 = "PerGB2018"
}

resource "azurerm_monitor_diagnostic_setting" "activity_logs" {
  name                       = "activity-logs"
  target_resource_id         = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.security_logs.id

  log {
    category = "Administrative"
    enabled  = true
  }

  log {
    category = "Security"
    enabled  = true
  }
}
