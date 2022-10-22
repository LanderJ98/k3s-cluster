module "network" {
  source                             = "./modules/terraform-oci-network"
  compartment_ocid                   = var.compartment_ocid
  oci_core_vcn_cidr                  = var.oci_core_vcn_cidr
  oci_core_vcn_dns_label             = var.oci_core_vcn_dns_label
  oci_core_instance_subnet_cidr      = var.oci_core_instance_subnet_cidr
  oci_core_instance_subnet_dns_label = var.oci_core_instance_subnet_dns_label
  oci_core_lb_subnet_cidr            = var.oci_core_lb_subnet_cidr
  oci_core_lb_subnet_dns_label       = var.oci_core_lb_subnet_dns_label
  my_public_ip_cidr                  = var.my_public_ip_cidr
  http_lb_port                       = var.http_lb_port
  https_lb_port                      = var.https_lb_port
}