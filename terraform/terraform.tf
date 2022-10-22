terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.86.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "RG-TF-STATE"
    storage_account_name = "azjltfstate"
    container_name       = "terraform"
    key                  = "k3sterraform.tfstate"
  }
  
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key      = var.private_key
  fingerprint      = var.fingerprint
  region           = "uk-london-1"
}