terraform {
  backend "remote" {
    organization = "azure_website_gh_action"
    workspaces {
      name = "azure-rs"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}




