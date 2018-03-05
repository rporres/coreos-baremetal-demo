data "ignition_config" "master" {
  networkd = [
    "${module.ignition_networkd.10_internal0_link}",
    "${module.ignition_networkd.20_internal0_network}",
  ]

  users = [
    "${module.ignition_users.demo}"
  ]

  systemd = [
    "${module.ignition_systemd.etcd_data_dir_service}",
    "${module.ignition_systemd.etcd_member_service}",
    "${module.ignition_systemd.locksmithd_service}",
  ]

  files = [
    "${module.ignition_files.hostname}"
  ]
}

module "ignition_networkd" {
  source               = "../../ignition/networkd"
  internal_mac_address = "${var.mac_address}"
}

module "ignition_users" {
  source = "../../ignition/users"
}

module "ignition_systemd" {
  source               = "../../ignition/systemd"
  etcd_name            = "${element(split(".", var.hostname), 0)}"
  etcd_initial_cluster = "${var.etcd_initial_cluster}"
  etcd_fqdn            = "${var.hostname}"
}

module "ignition_files" {
  source   = "../../ignition/files"
  hostname = "${var.hostname}"
}
