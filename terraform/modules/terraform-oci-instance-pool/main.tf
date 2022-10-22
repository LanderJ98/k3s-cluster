resource "oci_core_instance" "instance" {
  count               = var.instances
  display_name        = format("%s-%s", var.display_name, count.index + 1)
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain
  fault_domain        = var.fault_domain

  shape = var.instance_shape

  shape_config {
    memory_in_gbs = var.memory_in_gbs
    ocpus         = var.ocpus
  }
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.subnet_id
    nsg_ids          = var.nsg_ids != null ? var.nsg_ids : null
  }

  metadata = {
    "ssh_authorized_keys" = file(var.public_key)
  }

  source_details {
    source_id   = var.os_image_id
    source_type = "image"
  }
}