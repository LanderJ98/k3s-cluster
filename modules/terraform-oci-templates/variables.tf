variable "compartment_ocid" {
    type = string
}

variable "display_name" {
    type = string
}

variable "availability_domain" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "nsg_ids" {
    type = list(string)
    default = null
}

variable "template_name" {
    type = string
}

variable "public_key" {
    type = string
}

variable "user_data" {
    type = string
}

variable "compute_shape" {
    type = string
}

variable "memory_in_gbs" {
  type        = string
}

variable "ocpus" {
    default = string
}

variable "os_image_id" {
  type        = string
}
