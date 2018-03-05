data "template_file" "10_internal_link" {
  template = "${file("${path.module}/files/10-internal-link.tpl")}"

  vars {
    mac_address = "${var.internal_mac_address}"
    mtu_bytes   = "${var.internal_mtu_bytes}"
  }
}

data "ignition_networkd_unit" "10_internal0_link" {
  name    = "10-internal0.link"
  content = "${data.template_file.10_internal_link.rendered}"
}

output "10_internal0_link" {
  value = "${data.ignition_networkd_unit.10_internal0_link.id}"
}
