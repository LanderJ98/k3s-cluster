resource "oci_network_load_balancer_network_load_balancer" "k3s_public_lb" {
  compartment_id             = var.compartment_ocid
  display_name               = var.public_load_balancer_name
  subnet_id                  = var.lb_subnet_id
  network_security_group_ids = var.public_lb_nsg_ids

  is_private                     = false
  is_preserve_source_destination = false
}

# HTTP
resource "oci_network_load_balancer_listener" "k3s_http_listener" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3s_http_backend_set.name
  name                     = "k3s_http_listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
  port                     = var.http_lb_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "k3s_http_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.http_lb_port
  }

  name                     = "k3s_http_backend"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "k3s_http_backend" {
  count                    = var.k3s_instance_pool_size
  backend_set_name         = oci_network_load_balancer_backend_set.k3s_http_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
  name                     = format("%s:%s", "Network HTTP", var.http_lb_port)
  port                     = var.http_lb_port
  ip_address                = var.private_ips[count.index]
}

# HTTPS
resource "oci_network_load_balancer_listener" "k3s_https_listener" {
  default_backend_set_name = oci_network_load_balancer_backend_set.k3s_https_backend_set.name
  name                     = "k3s_https_listener"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
  port                     = var.https_lb_port
  protocol                 = "TCP"
}

resource "oci_network_load_balancer_backend_set" "k3s_https_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = var.https_lb_port
  }

  name                     = "k3s_https_backend"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
  policy                   = "FIVE_TUPLE"
  is_preserve_source       = true
}

resource "oci_network_load_balancer_backend" "k3s_https_backend" {
  count                    = var.k3s_instance_pool_size
  backend_set_name         = oci_network_load_balancer_backend_set.k3s_https_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.k3s_public_lb.id
  name                     = format("%s:%s","Network HTTPS", var.https_lb_port)
  port                     = var.https_lb_port
  ip_address                = var.private_ips[count.index]
}