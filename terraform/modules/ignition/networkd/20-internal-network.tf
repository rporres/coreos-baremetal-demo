data "ignition_networkd_unit" "20_internal0_network" {
  name    = "20-internal0.network"
  content = "${file("${path.module}/files/20-internal-network")}"
}

output "20_internal0_network" {
  value = "${data.ignition_networkd_unit.20_internal0_network.id}"
}
