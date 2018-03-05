data "ignition_systemd_unit" "locksmithd_service" {
  name = "locksmithd.service"

  dropin {
    name    = "40-etcd-lock.conf"
    content = "${file("${path.module}/files/40-etcd-lock.conf")}"
  }
}

output "locksmithd_service" {
  value = "${data.ignition_systemd_unit.locksmithd_service.id}"
}
