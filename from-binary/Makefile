.PHONY : build clean

ifndef OLD_PACKAGE
	$(error OLD_PACKAGE unset)
endif
NEW_VERSION ?= ""

LOCAL_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOCKER_NAME := "debian-build-from-binary"

build:
	echo `date '+%s'` >> .build-log.txt
	docker build -t $(DOCKER_NAME) \
		--build-arg OLD_PACKAGE=$(OLD_PACKAGE) \
		--build-arg NEW_VERSION="$(NEW_VERSION)" \
		--build-arg DEBFULLNAME="`git config --get user.name`" \
		--build-arg DEBEMAIL="`git config --get user.email`" \
		.
	docker create --name=$(DOCKER_NAME) $(DOCKER_NAME)
	-docker cp $(DOCKER_NAME):/install $(LOCAL_DIR)
	-docker rm $(DOCKER_NAME)

clean:
	docker images -q $(DOCKER_NAME) | xargs docker rmi
