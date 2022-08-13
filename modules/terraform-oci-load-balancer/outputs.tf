output "internal_k3s_lb_url" {
    value = oci_load_balancer_load_balancer.load_balancer.ip_addresses[0]
} 