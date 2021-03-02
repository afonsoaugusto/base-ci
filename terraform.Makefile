terraform-generate-backend:
	cd ./${TERRAFORM_FOLDER}/ && \
	echo -e "terraform {\nbackend "s3" {}\n}" > backend.tf && \
	terraform fmt

terraform-tfsec:
	cd ./${TERRAFORM_FOLDER}/ && \
	tfsec . --no-color

terraform-validate:
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform validate

terraform-clean:
	cd ./${TERRAFORM_FOLDER}/ && \
	rm -rf .terraform/ && \
	rm -rf .terraform.* && \
	rm -rf backend.tf && \
	rm -rf terraform.tfstate.d && \
	rm -rf .terraform.lock.hcl && \
	rm -rf tf.plan

terraform-fmt:
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform fmt -recursive

terraform-init: terraform-generate-backend
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform init \
	-backend-config="key=${PROJECT_NAME}/terraform.tfstate" \
	-backend-config="region=${AWS_REGION}" \
	-backend-config="bucket=${BUCKET_NAME}" 

terraform-select-workspace: terraform-init
	- cd ./${TERRAFORM_FOLDER}/ && \
	terraform workspace new $(env) 
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform workspace select $(env)

terraform-plan: terraform-select-workspace terraform-validate terraform-tfsec
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform plan -var-file=vars/global.tfvars -var-file=vars/${env}.tfvars -out tf.plan

terraform-deploy: terraform-select-workspace
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform apply -auto-approve tf.plan
	
terraform-destroy: terraform-select-workspace
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform destroy -auto-approve -var-file=vars/global.tfvars -var-file=vars/${env}.tfvars