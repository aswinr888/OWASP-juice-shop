provider "azurerm" {
    features {}
  
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name = var.appservicename
}

resource "azurerm_app_service_plan" "appplan" {
    location = azurerm_resource_group.rg.location
    name = "cybrpwn-appserviceplan"
    resource_group_name = azurerm_resource_group.rg.name
    sku {
      size = "S1"
      tier = "Standard"
    }
}

resource "azurerm_app_service" "appservice" {
  app_service_plan_id = azurerm_app_service_plan.appplan.id
  location = azurerm_resource_group.rg.location
  name = "CyberPWN-appservice"
  resource_group_name = azurerm_resource_group.rg.name

  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = "true"
    remote_debugging_version = "VS2019"
  }
  backup {
    name = "cyberpwnbackup"
    storage_account_url = "https://cyberpwndevsecops.blob.core.windows.net/cyberpwn?sv=2021-06-08&ss=bfqt&srt=c&sp=rwdlacupiytfx&se=2023-02-03T19:17:18Z&st=2023-02-03T11:17:18Z&spr=https&sig=HSVeCbFWgRhTTUeuqeymSlalQakQPkeWfvp%2Bgg327nU%3D&sr=b"
    schedule {
      frequency_interval = 30
      frequency_unit = "Day"
    }
  }
}
