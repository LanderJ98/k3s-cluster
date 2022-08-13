output "public_lb_id" {
  value = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
}

output "public_lb_ip" {
  value = oci_network_load_balancer_network_load_balancer.k3s_public_lb.ip_addresses[0]
}

output "k3s_https_backend_set_name" {
  value = oci_network_load_balancer_backend_set.k3s_https_backend_set.name
}

output "k3s_http_backend_set_name" {
  value = oci_network_load_balancer_backend_set.k3s_http_backend_set.name
}