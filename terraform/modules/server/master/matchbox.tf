provider "matchbox" {
  endpoint    = "${var.matchbox_rpc_endpoint}"
  client_cert = "${file("~/.matchbox/infra-local/client.crt")}"
  client_key  = "${file("~/.matchbox/infra-local/client.key")}"
  ca          = "${file("~/.matchbox/infra-local/ca.crt")}"
}

resource "matchbox_group" "master" {
  name    = "${var.hostname}"
  profile = "${matchbox_profile.master.name}"

  selector {
    mac = "${var.mac_address}"
  }
}

resource "matchbox_profile" "master" {
  name   = "${var.hostname}"
  kernel = "/assets/coreos/${var.container_linux_version}/coreos_production_pxe.vmlinuz"

  initrd = [
    "/assets/coreos/${var.container_linux_version}/coreos_production_pxe_image.cpio.gz",
  ]

  args = [
    "coreos.config.url=http://${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
    "coreos.first_boot=yes",
    "console=tty0",
    "initrd=coreos_production_pxe_image.cpio.gz",
  ]

  raw_ignition = "${data.ignition_config.master.rendered}"
}
