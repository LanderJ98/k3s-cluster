module "server_instances" {
  source              = "./modules/terraform-oci-instance-pool"
  instances           = 2
  compartment_ocid    = var.compartment_ocid
  display_name        = var.server_display_name
  availability_domain = data.oci_identity_availability_domain.ad_2.name
  fault_domain        = var.fault_domain
  subnet_id           = module.network.instance_subnet_id
  nsg_ids             = null
  public_key          = "~/.ssh/id_rsa.pub"
  instance_shape      = var.server_compute_shape
  memory_in_gbs       = "12"
  ocpus               = "2"
  os_image_id         = var.server_os_image_id
  depends_on = [
    oci_identity_dynamic_group.compute_dynamic_group,
    oci_identity_policy.compute_dynamic_group_policy
  ]
}

module "worker_instances" {
  source              = "./modules/terraform-oci-instance-pool"
  instances           = 2
  compartment_ocid    = var.compartment_ocid
  display_name        = var.worker_display_name
  fault_domain        = var.fault_domain
  availability_domain = data.oci_identity_availability_domain.ad_1.name
  subnet_id           = module.network.instance_subnet_id
  nsg_ids             = [module.network.lb_to_instances_id]
  public_key          = "~/.ssh/id_rsa.pub"
  instance_shape      = var.worker_compute_shape
  memory_in_gbs       = "1"
  ocpus               = "1"
  os_image_id         = var.worker_os_image_id
}