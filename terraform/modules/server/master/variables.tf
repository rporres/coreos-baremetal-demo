variable "mac_address" {
  description = "Mac adress"
}

variable "hostname" {
  description = "Hostname"
}

variable "container_linux_version" {
  description = "Container Linux version"
  default     = "1465.8.0"
}

variable "etcd_initial_cluster" {
  description = "ETCD_INITIAL_CLUSTER env variable value"
}

variable "matchbox_http_endpoint" {
  description = "Matchbox HTTP endpoint"
  default     = "provisioner-1.infra.local:8080"
}

variable "matchbox_rpc_endpoint" {
  description = "Matchbox gRPC endpoint"
  default     = "provisioner-1.infra.local:8081"
}
