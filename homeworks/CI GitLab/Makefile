CLUSTER_ID = $(shell cd ./terraform_host && terraform output -json | jq ".kuber_cluster_id.value")

default: create_infrastructure

create_infrastructure:
	cd ./terraform_host && terraform init
	cd ./terraform_host && terraform validate
	cd ./terraform_host && terraform plan
	cd ./terraform_host && terraform apply -auto-approve
	echo "Still creating" && sleep 30

connect:
	yc managed-kubernetes cluster get-credentials $(CLUSTER_ID) --external --force
	kubectl cluster-info

config:
	kubectl apply -f gitlab-admin-service-account.yaml
	kubectl -n kube-system get secrets -o json | \
	    jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | \
	    base64 --decode

create_runner:
	helm repo add gitlab https://charts.gitlab.io
	helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
	kubectl get pods -n default | grep gitlab-runner

destroy:
	cd ./terraform_host && terraform destroy -auto-approve