data "ignition_file" "hostname" {
  filesystem = "root"
  path       = "/etc/hostname"
  mode       = "0644"

  content {
    content = "${var.hostname}"
  }
}

output "hostname" {
  value = "${data.ignition_file.hostname.id}"
}
