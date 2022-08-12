module "public_k3s_lb" {
  source = "./modules/terraform-oci-network-load-balancer"
  compartment_ocid = var.compartment_ocid
  public_load_balancer_name = public_load_balancer_name
  lb_subnet_id = module.network.lb_subnet_id
  public_lb_nsg_ids = [module.network.public_lb_nsg_id]
  http_lb_port = var.http_lb_port
  k3s_server_pool_size = var.k3s_server_pool_size
  worker_instances = module.worker_instances.instances
  https_lb_port = var.https_lb_port
}

module "internal_k3s_lb" {
  source = "./modules/terraform-oci-load-balancer"
  compartment_ocid = var.compartment_ocid
  k3s_internal_load_balancer_name = var.k3s_internal_load_balancer_name
  lb_shape = var.lb_shape
  internal_lb_subnet_ids = [module.network.lb_subnet_id]
  kube_api_port = var.kube_api_port
  k3s_server_pool_size = var.k3s_server_pool_size
  server_private_ips = module.k3s_server.private_ips
}