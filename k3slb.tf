# module "public_k3s_lb" {
#   source = "./modules/terraform-oci-network-load-balancer"
#   compartment_ocid = var.compartment_ocid
#   public_load_balancer_name = var.public_load_balancer_name
#   instance_pool_id = module.k3s_workers.instance_pool_id
#   lb_subnet_id = module.network.lb_subnet_id
#   public_lb_nsg_ids = [module.network.public_lb_nsg_id]
#   http_lb_port = var.http_lb_port
#   k3s_instance_pool_size = var.k3s_worker_pool_size
#   https_lb_port = var.https_lb_port
# }

# module "internal_k3s_lb" {
#   source = "./modules/terraform-oci-load-balancer"
#   compartment_ocid = var.compartment_ocid
#   k3s_internal_load_balancer_name = var.k3s_internal_load_balancer_name
#   instance_pool_id = module.k3s_servers.instance_pool_id
#   lb_shape = var.lb_shape
#   internal_lb_subnet_ids = [module.network.lb_subnet_id]
#   kube_api_port = var.kube_api_port
#   k3s_instance_pool_size = var.k3s_server_pool_size
# }