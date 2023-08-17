resource "yandex_vpc_network" "kubernetes-cluster-vpc" {
  name        = "kubernetes-cluster-vpc"
  description = "VPC for kubernetes cluster"
}

resource "yandex_vpc_subnet" "kubernetes-cluster-vpc-subnet" {
  name           = "kubernetes-cluster-vpc-subnet"
  description    = "Subnet for kubernetes cluster instance"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.zone
  network_id     = yandex_vpc_network.kubernetes-cluster-vpc.id
}
