resource "oci_core_instance_configuration" template" {

  compartment_id = var.compartment_ocid
  display_name   = var.display_name

  instance_details {
    instance_type = "compute"

    launch_details {

      agent_config {
        is_management_disabled = "false"
        is_monitoring_disabled = "false"

        plugins_config {
          desired_state = "DISABLED"
          name          = "Vulnerability Scanning"
        }

        plugins_config {
          desired_state = "ENABLED"
          name          = "Compute Instance Monitoring"
        }

        plugins_config {
          desired_state = "DISABLED"
          name          = "Bastion"
        }
      }

      availability_domain = var.availability_domain
      compartment_id      = var.compartment_ocid

      create_vnic_details {
        assign_public_ip = true
        subnet_id        = var.subnet_id
        nsg_ids = var.nsg_ids != null ? var.nsg_ids : null
      }

      display_name = var.template_name

      metadata = {
        "ssh_authorized_keys" = file(var.public_key)
        "user_data"           = var.user_data
      }

      shape = var.compute_shape
      shape_config {
        memory_in_gbs = var.memory_in_gbs
        ocpus         = var.ocpus
      }
      source_details {
        image_id    = var.os_image_id
        source_type = "image"
      }
    }
  }
}