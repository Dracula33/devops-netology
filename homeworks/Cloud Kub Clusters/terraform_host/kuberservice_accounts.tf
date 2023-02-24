resource "yandex_iam_service_account" "kuber-account" {
  name      = "kuber-account"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.kuber-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "image-puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.kuber-account.id}"
}

