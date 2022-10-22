variable "compartment_ocid" {
  type = string

}

variable "k3s_internal_load_balancer_name" {
  type = string

}
variable "lb_shape" {
  type = string

}
variable "internal_lb_subnet_ids" {
  type = list(string)

}
variable "kube_api_port" {
  type = string

}
variable "k3s_instance_pool_size" {
  type = number
}

variable "private_ips" {
  type = list(string)
}