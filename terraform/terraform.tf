terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.86.0"
    }
  }
  backend "http" {
    address = "https://objectstorage.uk-london-1.oraclecloud.com/p/wa-KNtnUGXIu7SFZf7B-pgprWwfQEVhfIK4QGBIPbvSZeed-BSe-5eBOky-h2Kws/n/lrf1h4bvm7lg/b/oci-tf-state/o/terraform.tfstate"
    update_method = "PUT"
  }
  
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key      = var.private_key
  fingerprint      = var.fingerprint
  region           = "uk-london-1"
}