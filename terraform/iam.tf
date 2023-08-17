resource "yandex_iam_service_account" "kubernetes-sa" {
  name        = "kubernetes-service-account"
  description = "A separate sa for managing kubernetes clusters"
}

resource "yandex_iam_service_account_iam_binding" "kubernetes-sa-binding" {
  service_account_id = yandex_iam_service_account.kubernetes-sa.id

  role = "admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.kubernetes-sa.id}"
  ]
}
