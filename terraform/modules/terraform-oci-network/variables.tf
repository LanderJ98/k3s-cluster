variable "oci_core_vcn_cidr" {
  type = string
}

variable "compartment_ocid" {
  type = string
}
variable "oci_core_vcn_dns_label" {
  type = string
}
variable "oci_core_instance_subnet_cidr" {
  type = string
}
variable "oci_core_instance_subnet_dns_label" {
  type = string
}
variable "oci_core_lb_subnet_cidr" {
  type = string
}

variable "oci_core_lb_subnet_dns_label" {
  type = string
}

variable "my_public_ip_cidr" {
  type = string
}

variable "http_lb_port" {
  type = string
}

variable "https_lb_port" {
  type = string
}