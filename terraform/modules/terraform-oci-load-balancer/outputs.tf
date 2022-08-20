output "k3s_lb_url" {
    value = oci_load_balancer_load_balancer.load_balancer.ip_addresses[0]
}

output "load_balancer_id"{
  value       = oci_load_balancer_load_balancer.load_balancer.id
}

output "kube_api_backend_set_name" {
    value = oci_load_balancer_backend_set.k3s_kube_api_backend_set.name
}