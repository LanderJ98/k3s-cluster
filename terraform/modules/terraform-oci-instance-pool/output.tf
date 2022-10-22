output "instance_ids" {
  value = [for instance in oci_core_instance.instance : instance.id]
}

output "private_ips" {
  value = [for instance in oci_core_instance.instance : instance.private_ip]
}

output "public_ips" {
  value = [for instance in oci_core_instance.instance : instance.public_ip]
}
