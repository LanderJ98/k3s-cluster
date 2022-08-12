module "k3s_servers" {
  source = "./modules/terraform-oci-instance-ppols"
  display_name = "k3-servers"
  compartment_ocid = var.compartment_ocid
  instance_configuration_id = module.server_template.instance_configuration_id
  availability_domain = data.oci_identity_availability_domain.ad_2.name
  subnet_id = module.network.instance_subnet_id
  fault_domains = var.fault_domains
  depends_on = [
    oci_identity_dynamic_group.compute_dynamic_group,
    oci_identity_policy.compute_dynamic_group_policy
  ]
}

module "k3s_workers" {
  source = "./modules/terraform-oci-instance-ppols"
  display_name = "k3-workers"
  compartment_ocid = var.compartment_ocid
  instance_configuration_id = module.worker_template.instance_configuration_id
  availability_domain = data.oci_identity_availability_domain.ad_2.name
  subnet_id = module.network.instance_subnet_id
  fault_domains = var.fault_domains
  depends_on = [
    module.internal_k3s_lb
  ]
}