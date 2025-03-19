.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## initialize
	tofu init -upgrade

fmt: ## format
	tofu fmt

plan: ## plan
	tofu plan -out=terraform.plan

apply: ## apply
	tofu apply terraform.plan

destroy: ## destroys the infrastructure
	tofu destroy
