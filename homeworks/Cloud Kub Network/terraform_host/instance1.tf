
module "test-instance1" {
  source = "./modules/cheep-instance"
  instance_name = "test-instance1"
  subnet_id = "${yandex_vpc_subnet.public.id}"
}

output "external_ip_address_test-instance1" {
  value = "${module.test-instance1.external-ip}"
}
