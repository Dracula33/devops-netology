
default: create_virt

all: create_virt destroy

create_virt:
	cd ./terraform_host && terraform init
	cd ./terraform_host && terraform validate
	cd ./terraform_host && terraform plan
	cd ./terraform_host && terraform apply -auto-approve
	echo "Still creating" && sleep 30

destroy:
	cd ./terraform_host && terraform destroy -auto-approve