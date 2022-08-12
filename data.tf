data "oci_identity_availability_domain" "ad_1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_identity_availability_domain" "ad_2" {
  compartment_id = var.tenancy_ocid
  ad_number      = 2
}

data "cloudinit_config" "k3s_server_tpl" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/files/k3s-install-server.sh", {
      k3s_token                               = var.k3s_token,
      is_k3s_server                           = true,
      install_nginx_ingress                   = var.install_nginx_ingress,
      install_certmanager                     = var.install_certmanager,
      certmanager_release                     = var.certmanager_release,
      certmanager_email_address               = var.certmanager_email_address,
      compartment_ocid                        = var.compartment_ocid,
      availability_domain                     = data.oci_identity_availability_domain.ad_2.name,
      k3s_url                                 = oci_load_balancer_load_balancer.k3s_load_balancer.ip_addresses[0],
      k3s_tls_san                             = oci_load_balancer_load_balancer.k3s_load_balancer.ip_addresses[0],
      install_longhorn                        = var.install_longhorn,
      longhorn_release                        = var.longhorn_release,
      nginx_ingress_controller_http_nodeport  = var.nginx_ingress_controller_http_nodeport,
      nginx_ingress_controller_https_nodeport = var.nginx_ingress_controller_https_nodeport,
    })
  }
}

data "cloudinit_config" "k3s_worker_tpl" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/files/k3s-install-agent.sh", {
      k3s_token                               = var.k3s_token,
      is_k3s_server                           = false,
      k3s_url                                 = oci_load_balancer_load_balancer.k3s_load_balancer.ip_addresses[0],
      http_lb_port                            = var.http_lb_port,
      https_lb_port                           = var.https_lb_port,
      nginx_ingress_controller_http_nodeport  = var.nginx_ingress_controller_http_nodeport,
      nginx_ingress_controller_https_nodeport = var.nginx_ingress_controller_https_nodeport,
    })
  }
}