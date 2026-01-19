provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# -----------------------------
# Resource Group
# -----------------------------
resource "azurerm_resource_group" "security_rg" {
  name     = var.resource_group_name
  location = var.location
}

# -----------------------------
# Centralized Logging (Prevents AP-003)
# -----------------------------
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-security-baseline"
  location            = azurerm_resource_group.security_rg.location
  resource_group_name = azurerm_resource_group.security_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "subscription_logs" {
  name                       = "subscription-activity-logs"
  target_resource_id         = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  log {
    category = "Administrative"
    enabled  = true
  }

  log {
    category = "Security"
    enabled  = true
  }

  log {
    category = "Policy"
    enabled  = true
  }
}

# -----------------------------
# IAM Guardrail (Mitigates AP-001)
# -----------------------------
resource "azurerm_role_definition" "limited_operator" {
  name        = "Limited-Security-Operator"
  scope       = "/subscriptions/${var.subscription_id}"
  description = "Restricted role enforcing least privilege"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Compute/virtualMachines/read"
    ]
    not_actions = [
      "Microsoft.Authorization/*"
    ]
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}"
  ]
}
