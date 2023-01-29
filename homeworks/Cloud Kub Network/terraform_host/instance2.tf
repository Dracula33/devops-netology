module "test-instance2" {
  source = "./modules/cheep-instance"
  instance_name = "test-instance2"
  subnet_id = "${yandex_vpc_subnet.private.id}"
  need_nat = false
}

output "local_ip_address_test-instance2" {
  value = "${module.test-instance2.local-ip}"
}
