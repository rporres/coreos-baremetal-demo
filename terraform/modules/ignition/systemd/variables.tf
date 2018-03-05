variable "etcd_name" {
  description = "Etcd node name"
  default     = "local1"
}

variable "etcd_fqdn" {
  description = "Etcd fully qualified domain name"
  default     = "localhost.localdomain"
}

variable "etcd_image_tag" {
  description = "Etcd container image tag"
  default     = "v3.2.9"
}

variable "etcd_data_dir" {
  description = "ETCD_DATA_DIR variable"
  default     = "/data/etcd"
}

variable "etcd_initial_cluster" {
  description = "ETCD_INITIAL_CLUSTER env variable value"
}

variable "etcd_listen_client_urls" {
  description = "ETCD_LISTEN_CLIENT_URLS env variable"
  default     = "http://0.0.0.0:2379"
}

variable "etcd_listen_peers_urls" {
  description = "ETCD_LISTEN_PEER_URLS env variable"
  default     = "http://0.0.0.0:2380"
}

## ETCD

