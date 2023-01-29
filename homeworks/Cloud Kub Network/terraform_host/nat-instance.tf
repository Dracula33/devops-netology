
module "nat-instance" {
  source = "./modules/cheep-instance"
  instance_name = "nat-instance"
  family = "nat-instance-ubuntu"
  subnet_id = "${yandex_vpc_subnet.public.id}"
  local_ip = "192.168.10.254"
}

output "external_ip_address_nat-instance" {
  value = "${module.nat-instance.external-ip}"
}
