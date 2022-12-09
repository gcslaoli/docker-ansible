# These can be overidden with env vars.
REGISTRY ?= gcslaoli
IMAGE_NAME ?= ansible
IMAGE_TAG ?= latest
IMAGE ?= $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)
PLATFORM ?= "linux/amd64,linux/arm64"


.PHONY: help
help: ## 查看帮助
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
run: ## 启动服务
	@docker-compose pull
	@docker-compose run --rm ansible bash

# 初始化环境
.PHONY: init
init: export DOCKER_BUILDKIT=1
init:	## Creates the buildx instance
	$(info Initializing Builder...)
	docker run --privileged --rm tonistiigi/binfmt --install all
	docker buildx create --use --name=qemu
	docker buildx inspect --bootstrap

.PHONY: clean
clean:	## Removes all dangling build cache
	$(info Removing all dangling build cache)
	echo Y | docker buildx prune

.PHONY: build
build:	## Build all of the project Docker images
	$(info Building $(IMAGE) for $(PLATFORM)...)
	cd src && docker buildx build --pull --platform=$(PLATFORM) --tag $(IMAGE) --push .
	echo "Build $(IMAGE) for $(PLATFORM) success on $(shell date +'%Y-%m-%d %H:%M:%S')" >> build.log