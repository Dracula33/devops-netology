CLUSTER_ID = $(shell cd ./terraform_host && terraform output -json | jq -r ".cluster_id.value")

default: create_virt get_kubectl_config deploy

all: create_virt get_kubectl_config deploy destroy

create_virt:
	cd ./terraform_host && terraform init
	cd ./terraform_host && terraform validate
	cd ./terraform_host && terraform plan
	cd ./terraform_host && terraform apply -auto-approve
	echo "Still creating" && sleep 30

get_kubectl_config:
	yc managed-kubernetes cluster get-credentials --id $(CLUSTER_ID) --external --force

deploy:
	kubectl apply -f manifest

destroy:
	cd ./terraform_host && terraform destroy -auto-approve