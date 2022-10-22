resource "local_file" "ansible_vars" {
  content = templatefile("templates/ansible_vars.tpfl", {
    k3s_version                             = "v1.23.10-rc1%2Bk3s1"
    ansible_user                            = "ubuntu"
    systemd_dir                             = "/etc/systemd/system"
    controller_1_private_ip                 = module.server_instances.private_ips[0]
    controller_2_private_ip                 = module.server_instances.private_ips[1]
    kube_api_lb_ip                          = module.k3s_load_balancer.k3s_lb_url
    private_ips                             = concat(module.server_instances.private_ips, module.worker_instances.private_ips)
    extra_server_args                       = "--disable traefik --flannel-iface enp0s3 --tls-san ${module.k3s_load_balancer.k3s_lb_url} --tls-san ${module.server_instances.public_ips[0]}"
    extra_agent_args                        = ""
    nginx_dir                               = "/etc/nginx"
    nginx_ingress_controller_https_nodeport = var.nginx_ingress_controller_https_nodeport
    nginx_ingress_controller_http_nodeport  = var.nginx_ingress_controller_http_nodeport
    https_lb_port                           = var.https_lb_port
    http_lb_port                            = var.http_lb_port
  })
  filename        = "../bootstrap_cluster/inventory/group_vars/all.yaml"
  file_permission = 0644
}

resource "local_file" "hosts" {
  content = templatefile("templates/hosts.ini.tpfl", {
    controller1      = module.server_instances.public_ips[0]
    controller2      = module.server_instances.public_ips[1]
    worker_instances = module.worker_instances.public_ips
    ansible_user     = "ubuntu"
  })
  filename        = "../bootstrap_cluster/inventory/hosts.ini"
  file_permission = 0644
}
