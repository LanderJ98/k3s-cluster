resource "oci_identity_dynamic_group" "compute_dynamic_group" {
  compartment_id = var.tenancy_ocid
  description    = "Dynamic group which contains all instance in this compartment"
  matching_rule  = "All {instance.compartment.id = '${var.compartment_ocid}'}"
  name           = var.oci_identity_dynamic_group_name

}

resource "oci_identity_policy" "compute_dynamic_group_policy" {
  compartment_id = var.tenancy_ocid
  description    = "Policy to allow dynamic group ${oci_identity_dynamic_group.compute_dynamic_group.name} to read OCI api"
  name           = var.oci_identity_policy_name
  statements = [
    "allow dynamic-group ${oci_identity_dynamic_group.compute_dynamic_group.name} to read instance-family in tenancy",
    "allow dynamic-group ${oci_identity_dynamic_group.compute_dynamic_group.name} to read compute-management-family in tenancy"
  ]
}