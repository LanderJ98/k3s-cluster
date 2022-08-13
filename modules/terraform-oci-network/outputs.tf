output "instance_subnet_id" {
    value = oci_core_subnet.instance_subnet.id
}

output "lb_subnet_id" {
    value = oci_core_subnet.lb_subnet.id
}

output  "public_lb_nsg_id" {
    value = oci_core_network_security_group.public_lb_nsg.id
}

output "lb_to_instances_id" {
    value = oci_core_network_security_group.lb_to_instances.id
}