.PHONY : all build

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

build:
	docker build -t debian-build:base -f Dockerfile.base .
	docker build -t debian-build:build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GIT_URL=$(GIT_URL) \
		--build-arg GIT_SRC=$(GIT_SRC) \
		--build-arg GIT_DEB=$(GIT_DEB) \
		-f Dockerfile.build .
	docker create --name=debian-build debian-build:build
	docker cp debian-build:/install $(LOCAL_DIR)
	docker rm debian-build
	docker rmi debian-build:build
