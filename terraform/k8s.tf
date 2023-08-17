resource "yandex_kubernetes_cluster" "zonal-kubernetes-cluster" {
  name        = "observability-k8s"
  description = "cluster for deploing observability stack on kubernetes"

  network_id = yandex_vpc_network.kubernetes-cluster-vpc.id

  master {
    version = var.k8s-cluster-version
    zonal {
      zone      = yandex_vpc_subnet.kubernetes-cluster-vpc-subnet.zone
      subnet_id = yandex_vpc_subnet.kubernetes-cluster-vpc-subnet.id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "15:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = yandex_iam_service_account.kubernetes-sa.id
  node_service_account_id = yandex_iam_service_account.kubernetes-sa.id

  release_channel = "STABLE"
}

resource "yandex_kubernetes_node_group" "kubernetes-node-group" {
  cluster_id  = yandex_kubernetes_cluster.zonal-kubernetes-cluster.id
  name        = "observability-kubernetes-cluster-node-group"
  description = "Observability node group for k8s cluster"
  version     = var.k8s-cluster-version

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.kubernetes-cluster-vpc-subnet.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}
