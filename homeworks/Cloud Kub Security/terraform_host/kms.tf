resource "yandex_kms_symmetric_key" "my-symmetric-key" {
  name              = "my-symmetric-key"
  description       = "Ключ для шифрования бакета"
  default_algorithm = "AES_128"
  rotation_period   = "24h"
}
