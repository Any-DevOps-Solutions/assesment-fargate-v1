.EXPORT_ALL_VARIABLES:

.NOTPARALLEL:

.PHONY: help terraform

help:
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy: ## Deploy Infrastructure
	@echo "Deploy infrastructure"
	@cd terraform/aws
	@terraform plan -out=plan.out
	@terraform apply plan.out

test: ## Test infrastructure
	@echo "Run the tests"
	@cd tests
	@go test -v -run TestFargate


cleanup: ## Cleanup Infrastructure
	@echo "Cleanup infrastructure"
	@cd terraform/aws
	@terraform destroy
