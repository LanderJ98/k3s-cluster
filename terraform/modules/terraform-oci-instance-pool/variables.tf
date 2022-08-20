variable "display_name" {
    type = string
}

variable "compartment_ocid" {
    type = string
}

variable "instances" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "availability_domain" {
    type = string
}

variable "fault_domain" {
    type = string
}

variable "nsg_ids" {
    type = list(string)
    default = null
}

variable "public_key" {
    type = string
}

variable "instance_shape" {
    type = string
}

variable "memory_in_gbs" {
  type        = string
}

variable "ocpus" {
    type = string
}

variable "os_image_id" {
  type        = string
}