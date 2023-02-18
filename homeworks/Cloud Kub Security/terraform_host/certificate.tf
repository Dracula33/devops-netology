resource "yandex_cm_certificate" "my-cert" {
  name    = "my-cert"

  self_managed {
    certificate = "${file("./cert.pem")}"
    private_key = "${file("./key.pem")}"
  }
}
