# output "k3s_lb_url" {
#     value = module.internal_k3s_lb.internal_k3s_lb_url
# }

output "lb_ip" {
    value = module.k3s_load_balancer.k3s_lb_url
}