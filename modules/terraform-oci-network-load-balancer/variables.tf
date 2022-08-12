variable "compartment_ocid" {
    type = string
}

variable "public_load_balancer_name" {
    type = string
}

variable "lb_subnet_id" {
    type = string
}

variable "public_lb_nsg_ids" {
    type = list(string)
}

variable "http_lb_port" {
    type = string
}

variable "k3s_server_pool_size" {
    type = number
}

variable "worker_instances" {
    type = list(string)
}

variable "https_lb_port" {
    type = string
}