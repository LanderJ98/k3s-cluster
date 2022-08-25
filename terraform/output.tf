output "k3s_lb_url" {
    value = module.public_k3s_lb.public_lb_ip
}

output "lb_ip" {
    value = module.k3s_load_balancer.k3s_lb_url
}

output "server_private_ips" {
    value = module.server_instances.private_ips
}

output "server_public_ips" {
    value = module.server_instances.public_ips
}

output "worker_private_ips" {
    value = module.worker_instances.private_ips
}

output "worker_public_ips" {
    value = module.worker_instances.public_ips
}