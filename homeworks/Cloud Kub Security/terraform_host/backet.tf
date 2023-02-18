
resource "yandex_iam_service_account" "storage-account" {
  name      = "storage-account"
}

resource "yandex_resourcemanager_folder_iam_member" "storage-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.storage-account.id}"
}

resource "yandex_iam_service_account_static_access_key" "storage-account-static-key" {
  service_account_id = yandex_iam_service_account.storage-account.id
  description        = "static access key for object storage"

  depends_on = [
    yandex_resourcemanager_folder_iam_member.storage-admin
  ]
}

resource "yandex_storage_bucket" "bucket" {
  access_key = yandex_iam_service_account_static_access_key.storage-account-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage-account-static-key.secret_key
  bucket = "hw-bucket"
  max_size = 1073741824
  default_storage_class = "COLD"
  force_destroy = true

  anonymous_access_flags {
    read = true
    list = true
  }

#  server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        kms_master_key_id = yandex_kms_symmetric_key.my-symmetric-key.id
#        sse_algorithm     = "aws:kms"
#      }
#    }
#  }

  https {
    certificate_id = yandex_cm_certificate.my-cert.id
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

}
