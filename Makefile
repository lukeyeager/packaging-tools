.PHONY : build

ifndef GIT_URL
	$(error GIT_URL unset)
endif
ifndef GIT_SRC
	$(error GIT_SRC unset)
endif
ifndef GIT_DEB
	$(error GIT_DEB unset)
endif

LOCAL_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOCKER_NAME := "debian-build"

build:
	docker build -t $(DOCKER_NAME):base -f Dockerfile.base .
	docker build -t $(DOCKER_NAME):build \
		--build-arg GIT_URL=$(GIT_URL) \
		--build-arg GIT_SRC=$(GIT_SRC) \
		--build-arg GIT_DEB=$(GIT_DEB) \
		.
	docker create --name=$(DOCKER_NAME) $(DOCKER_NAME):build
	-docker cp $(DOCKER_NAME):/install $(LOCAL_DIR)
	-docker rm $(DOCKER_NAME)

clean:
	docker images -q $(DOCKER_NAME) | xargs docker rmi
