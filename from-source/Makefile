.PHONY : none build run clean invalidate-cache

LOCAL_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOCKER_ID := "debian-build-from-source"

none:
	@:

build:
	[ -e ".invalidate-cache" ] || touch .invalidate-cache
	docker build -t $(DOCKER_ID) \
		--build-arg GIT_URL=$(GIT_URL) \
		--build-arg GIT_SRC=$(GIT_SRC) \
		--build-arg GIT_DEB=$(GIT_DEB) \
		.
	docker create --name=$(DOCKER_ID) $(DOCKER_ID)
	-docker cp $(DOCKER_ID):/install $(LOCAL_DIR)
	-docker rm $(DOCKER_ID)

run:
	docker run --rm -it $(DOCKER_ID) bash

clean:
	-docker rm $(DOCKER_ID)
	docker images -q $(DOCKER_ID) | xargs -r docker rmi
	-docker images --filter "dangling=true" -q | xargs -r docker rmi
	rm -f .invalidate-cache

invalidate-cache:
	echo `date '+%s'` >> .invalidate-cache
