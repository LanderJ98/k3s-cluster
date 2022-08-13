variable "display_name" {
    type = string
}

variable "compartment_ocid" {
    type = string
}

variable "instance_configuration_id" {
    type = string
}

variable "availability_domain" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "fault_domains" {
    type = list(string)
}

variable "k3s_instance_pool_size" {
    type = string
}