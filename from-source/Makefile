.PHONY : build clean

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
DOCKER_ID := "debian-build-from-source"

build:
	docker build -t $(DOCKER_ID) \
		--build-arg GIT_URL=$(GIT_URL) \
		--build-arg GIT_SRC=$(GIT_SRC) \
		--build-arg GIT_DEB=$(GIT_DEB) \
		.
	docker create --name=$(DOCKER_ID) $(DOCKER_ID)
	-docker cp $(DOCKER_ID):/install $(LOCAL_DIR)
	-docker rm $(DOCKER_ID)

clean:
	docker images -q $(DOCKER_ID) | xargs docker rmi
