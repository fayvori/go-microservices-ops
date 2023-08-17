terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.96.1"
    }
  }
}

variable "cloud-id" {
  type        = string
  description = "You can get cloud-id using cli by running `yc resource-manager folder get --name YOUR_FOLDER_NAME`"
  nullable    = false

  default = "b1gca94j09c4qsuvfjib"
}

variable "folder-id" {
  type        = string
  description = "You can get folder-id using cli by running `yc resource-manager folder get --name YOUR_FOLDER_NAME`"
  nullable    = false

  default = "b1gqslkq5licbr663741"
}

variable "token" {
  type        = string
  description = "You can generate yc token using yandex cli by running `yc iam create-token`"
  nullable    = false

  default = "t1.9euelZqUx5SPmMuNm4-YyJyejM_Jnu3rnpWaxsyKm4yRzJmPjo6KkpfLmJDl8_dpfyJZ-e8NT0wX_d3z9ykuIFn57w1PTBf9zef1656Vms2biZiZxsjNl4qUicbLkZrM7_zF656Vms2biZiZxsjNl4qUicbLkZrM.G1ZhlElOgTgZA8L0QKKQvD3QjAZi-gbJpkRsn5Pj5f3JM4-ml6CuWhfULeK15oMG6Qn2AhbYXXIIvjFN7xutCQ"
}

variable "zone" {
  type        = string
  description = "yandex zone where all the resources will create"
  default     = "ru-central1-a"
}

variable "k8s-cluster-version" {
  type        = string
  description = "version which will be installed on yandex k8s cluster (e.g 1.24)"
  default     = "1.24"
}

provider "yandex" {
  cloud_id  = var.cloud-id
  folder_id = var.folder-id
  token     = var.token
  zone      = var.zone
}
