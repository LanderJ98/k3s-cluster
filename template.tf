# module "server_template" {
#   source = "./modules/terraform-oci-templates"
#   compartment_ocid = var.compartment_ocid
#   display_name = var.server_display_name
#   availability_domain = data.oci_identity_availability_domain.ad_2.name
#   subnet_id = module.network.instance_subnet_id
#   nsg_ids = null
#   template_name = var.server_template_name
#   user_data = data.cloudinit_config.k3s_server_tpl.rendered
#   public_key = "~/.ssh/id_rsa"
#   compute_shape = var.server_compute_shape
#   memory_in_gbs = "12"
#   ocpus = "2"
#   os_image_id = var.server_os_image_id
# }

# module "worker_template" {
#   source = "./modules/terraform-oci-templates"
#   compartment_ocid = var.compartment_ocid
#   display_name = var.worker_display_name
#   availability_domain = data.oci_identity_availability_domain.ad_1.name
#   subnet_id = module.network.instance_subnet_id
#   nsg_ids = [module.network.lb_to_instances_id]
#   template_name = var.worker_template_name
#   user_data = data.cloudinit_config.k3s_worker_tpl.rendered
#   public_key = "~/.ssh/id_rsa"
#   compute_shape = var.worker_compute_shape
#   memory_in_gbs = "1"
#   ocpus = "1"
#   os_image_id = var.worker_os_image_id
# }