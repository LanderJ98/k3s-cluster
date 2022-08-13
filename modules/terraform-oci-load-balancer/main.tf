resource "oci_load_balancer_load_balancer" "load_balancer" {
  compartment_id = var.compartment_ocid
  display_name   = var.k3s_internal_load_balancer_name
  shape          = var.lb_shape
  subnet_ids     = var.internal_lb_subnet_ids

  ip_mode    = "IPV4"
  is_private = true

  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_listener" "k3s_kube_api_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.k3s_kube_api_backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.load_balancer.id
  name                     = "K3s__kube_api_listener"
  port                     = var.kube_api_port
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend_set" "k3s_kube_api_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.kube_api_port
  }
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  name             = "K3s__kube_api_backend_set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "k3s_kube_api_backend" {
  count            = var.k3s_instance_pool_size
  backendset_name  = oci_load_balancer_backend_set.k3s_kube_api_backend_set.name
  ip_address       = data.oci_core_instance.k3s_servers_instances_ips[count.index].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
  port             = var.kube_api_port
}