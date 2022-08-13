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
  default = "uk-london-1"
}

variable "compartment_ocid" {
  type = string
  default = "ocid1.compartment.oc1..aaaaaaaap3s7xpddwma2atfzfuzfvsw4bouaadg46yrvhhqfb3ex26jen76q"
}

variable "cluster_name" {
  type = string
  default = "jl-k3s-cluster"
}

variable "fault_domains" {
  type    = list(any)
  default = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
}

variable "public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to your public key"
}

variable "k3s_token" {
  type = string
  default = "reG6jI8pU6tLM4svBkTFQtsnKqGtm7HM"
}

variable "server_os_image_id" {
  type    = string
  default = "ocid1.image.oc1.uk-london-1.aaaaaaaa72ynvd4a3boeqxdq7btyjmbrutrqvx42vvqt7iet3sgqtbxk2xma" # Canonical-Ubuntu-20.04-aarch64-2022.01.18-0
}

variable "server_compute_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "worker_os_image_id" {
  type    = string
  default = "ocid1.image.oc1.uk-london-1.aaaaaaaaihgwj54qo6gzqkaegzgq7xf2ho4cguj5rsue323mdlglqvjiymnq" # Canonical-Ubuntu-20.04-arch64-2022.01.18-0
}

variable "worker_compute_shape" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "lb_shape" {
  type    = string
  default = "flexible"
}

variable "server_display_name" {
  type = string
  default = "Ubuntu 20.04 k3s servers"
}

variable "server_template_name" {
  type = string
  default = "Ubuntu 20.04 k3s servers configuration"
}

variable "worker_display_name" {
  type = string
  default = "Ubuntu 20.04 k3s workers"
}

variable "worker_template_name" {
  type = string
  default = "Ubuntu 20.04 k3s workers configuration"
}

variable "oci_identity_dynamic_group_name" {
  type        = string
  default     = "Compute_Dynamic_Group"
  description = "Dynamic group which contains all instance in this compartment"
}

variable "oci_identity_policy_name" {
  type        = string
  default     = "Compute_To_Oci_Api_Policy"
  description = "Policy to allow dynamic group, to read OCI api without auth"
}

variable "oci_core_vcn_dns_label" {
  type    = string
  default = "defaultvcn"
}

variable "oci_core_instance_subnet_dns_label" {
  type    = string
  default = "instancesubnet"
}

variable "oci_core_lb_subnet_dns_label" {
  type    = string
  default = "lbsubnet"
}

variable "oci_core_vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "oci_core_instance_subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "oci_core_lb_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "kube_api_port" {
  type    = number
  default = 6443
}

variable "k3s_load_balancer_name" {
  type    = string
  default = "k3s internal load balancer"
}

variable "public_load_balancer_name" {
  type    = string
  default = "K3s public LB"
}

variable "k3s_internal_load_balancer_name" {
  type = string
  default = "k3s internal api load balancer"
}

variable "http_lb_port" {
  type    = number
  default = 80
}

variable "https_lb_port" {
  type    = number
  default = 443
}

variable "nginx_ingress_controller_http_nodeport" {
  type    = number
  default = 30080
}

variable "nginx_ingress_controller_https_nodeport" {
  type    = number
  default = 30443
}

variable "k3s_server_pool_size" {
  type    = number
  default = 2
}

variable "k3s_worker_pool_size" {
  type    = number
  default = 2
}

variable "my_public_ip_cidr" {
  type        = string
  description = "My public ip CIDR"
  default = "86.20.112.87/32"
}

variable "install_nginx_ingress" {
  type    = bool
  default = true
}

variable "install_certmanager" {
  type    = bool
  default = true
}

variable "certmanager_release" {
  type    = string
  default = "v1.8.2"
}

variable "certmanager_email_address" {
  type    = string
  default = "jl&k8sdev.io"
}

variable "install_longhorn" {
  type    = bool
  default = true
}

variable "longhorn_release" {
  type    = string
  default = "v1.2.3"
}