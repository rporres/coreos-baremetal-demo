variable "etcd_initial_cluster" {
  default = "master-1=http://master-1.infra.local:2380,master-2=http://master-2.infra.local:2380,master-3=http://master-3.infra.local:2380"
}

module "master_1" {
  source = "../modules/server/master"
  hostname = "master-1.infra.local"
  mac_address = "08:00:27:ab:10:01"
  etcd_initial_cluster = "${var.etcd_initial_cluster}"
}

module "master_2" {
  source = "../modules/server/master"
  hostname = "master-2.infra.local"
  mac_address = "08:00:27:ab:10:02"
  etcd_initial_cluster = "${var.etcd_initial_cluster}"
}

module "master_3" {
  source = "../modules/server/master"
  hostname = "master-3.infra.local"
  mac_address = "08:00:27:ab:10:03"
  etcd_initial_cluster = "${var.etcd_initial_cluster}"
}
