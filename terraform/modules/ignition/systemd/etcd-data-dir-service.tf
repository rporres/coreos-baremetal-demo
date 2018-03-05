data "template_file" "etcd_data_dir_service" {
  template = "${file("${path.module}/files/etcd-data-dir.service.tpl")}"

  vars {
    etcd_data_dir = "${var.etcd_data_dir}"
  }
}

data "ignition_systemd_unit" "etcd_data_dir_service" {
  name    = "etcd-data-dir.service"
  enabled = true
  content = "${data.template_file.etcd_data_dir_service.rendered}"
}

output "etcd_data_dir_service" {
  value = "${data.ignition_systemd_unit.etcd_data_dir_service.id}"
}
