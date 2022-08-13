resource "oci_core_instance_pool" "instances" {

  lifecycle {
    ignore_changes        = [load_balancers, freeform_tags]
  }

  display_name              = var.display_name
  compartment_id            = var.compartment_ocid
  instance_configuration_id = var.instance_configuration_id

  placement_configurations {
    availability_domain = var.availability_domain
    primary_subnet_id   = var.subnet_id
    fault_domains       = var.fault_domains
  }

  size = var.k3s_instance_pool_size
}