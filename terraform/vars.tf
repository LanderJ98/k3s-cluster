variable "tenancy_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "region" {
  type = string
}

variable "compartment_ocid" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "fault_domain" {
  type    = string
}

variable "public_key" {
  type        = string
  description = "Path to your public key"
}

variable "server_os_image_id" {
  type    = string
}

variable "server_compute_shape" {
  type    = string
}

variable "worker_os_image_id" {
  type    = string
}

variable "worker_compute_shape" {
  type    = string
}

variable "lb_shape" {
  type    = string
}

variable "server_display_name" {
  type = string
}

variable "server_template_name" {
  type = string
}

variable "worker_display_name" {
  type = string
}

variable "worker_template_name" {
  type = string
}

variable "oci_identity_dynamic_group_name" {
  type        = string
  description = "Dynamic group which contains all instance in this compartment"
}

variable "oci_identity_policy_name" {
  type        = string
  description = "Policy to allow dynamic group, to read OCI api without auth"
}

variable "oci_core_vcn_dns_label" {
  type    = string
}

variable "oci_core_instance_subnet_dns_label" {
  type    = string
}

variable "oci_core_lb_subnet_dns_label" {
  type    = string
}

variable "oci_core_vcn_cidr" {
  type    = string
}

variable "oci_core_instance_subnet_cidr" {
  type    = string
}

variable "oci_core_lb_subnet_cidr" {
  type    = string
}

variable "kube_api_port" {
  type    = number
}

variable "k3s_load_balancer_name" {
  type    = string
}

variable "public_load_balancer_name" {
  type    = string
}

variable "k3s_internal_load_balancer_name" {
  type = string
}

variable "http_lb_port" {
  type    = number
}

variable "https_lb_port" {
  type    = number
}

variable "k3s_server_pool_size" {
  type    = number
}

variable "k3s_worker_pool_size" {
  type    = number
}

variable "my_public_ip_cidr" {
  type        = string
  description = "My public ip CIDR"
}