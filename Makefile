# The binary to build (just the basename).
REPONAME := python-docker-devtools

# Where to push the container image.
DOCKER_HUB_USER ?= tuteco

IMAGE_NAME := $(DOCKER_HUB_USER)/$(REPONAME)

# determine the development version by git tag
LOCAL_VERSION := $(shell git describe --tags --always --dirty)

.PHONY: help build-local shell version docker-clean

.DEFAULT:
	help

help: version
	@echo " "
	@echo "Please use \`make <target>\` where <target is one of:"
	@echo "  build-local    create the container for local dev purpose with PyCharm"
	@echo "  shell          start the local container interactively"
	@echo "  docker-clean   remove local containers"
	@echo ""

build-local:
	@echo "Building Development image with labels:"
	./container/gen_container.sh $(IMAGE_NAME) $(LOCAL_VERSION)

# Example: make shell PYVER="3.9" CMD="-c 'date > datefile'"
shell:
	@echo "Launching a shell in the containerized build environment..."
		@docker run                                                 \
			-ti                                                     \
			--rm                                                    \
			--entrypoint /bin/bash                                  \
			-u $$(id -u):$$(id -g)                                  \
			$(IMAGE_NAME)-$(PYVER):$(LOCAL_VERSION)										    \
			$(CMD)

version:
	@echo "current local version is set to:"
	@echo $(LOCAL_VERSION)

docker-clean:
	@docker system prune -f --filter "label=name=$(MODULE)"