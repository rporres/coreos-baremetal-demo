data "template_file" "40_etcd_cluster_conf" {
  template = "${file("${path.module}/files/40-etcd-cluster.conf.tpl")}"

  vars {
    etcd_image_tag          = "${var.etcd_image_tag}"
    etcd_name               = "${var.etcd_name}"
    etcd_fqdn               = "${var.etcd_fqdn}"
    etcd_initial_cluster    = "${var.etcd_initial_cluster}"
    etcd_listen_client_urls = "${var.etcd_listen_client_urls}"
    etcd_listen_peers_urls  = "${var.etcd_listen_peers_urls}"
    etcd_data_dir           = "${var.etcd_data_dir}"
  }
}

data "ignition_systemd_unit" "etcd_member_service" {
  name    = "etcd-member.service"
  enabled = true

  dropin {
    name    = "40-etcd-cluster.conf"
    content = "${data.template_file.40_etcd_cluster_conf.rendered}"
  }
}

output "etcd_member_service" {
  value = "${data.ignition_systemd_unit.etcd_member_service.id}"
}
