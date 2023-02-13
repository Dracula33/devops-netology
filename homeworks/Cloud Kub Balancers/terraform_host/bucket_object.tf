resource "yandex_storage_object" "pic-object" {
  access_key = yandex_iam_service_account_static_access_key.storage-account-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage-account-static-key.secret_key
  bucket     = yandex_storage_bucket.bucket.id
  content_type = "image/jpeg"
  key        = "pic.jpg"
  source     = "./pic.jpg"
}
