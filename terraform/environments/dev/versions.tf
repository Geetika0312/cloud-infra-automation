terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  backend "azurerm" {
    # Deliberately empty - see README / terraform init command below.
    # Filling these in here would mean committing the storage account name
    # to git. Instead they're supplied at `terraform init` time.
  }
}

provider "azurerm" {
  features {}
}
