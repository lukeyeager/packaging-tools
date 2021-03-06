.PHONY : none build run clean superclean invalidate-cache

LOCAL_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOCKER_ID := "debian-build-from-source"

none:
	@:

build:
	[ -e ".invalidate-cache" ] || touch .invalidate-cache
	docker build -t $(DOCKER_ID) \
		--build-arg SOURCE_TARBALL=$(SOURCE_TARBALL) \
		--build-arg DEBIAN_TARBALL=$(DEBIAN_TARBALL) \
		--build-arg PPA_NAME=$(PPA_NAME) \
		.
	docker create --name=$(DOCKER_ID) $(DOCKER_ID)
	-docker cp $(DOCKER_ID):/install $(LOCAL_DIR)
	-docker rm $(DOCKER_ID)

run:
	docker run --rm -it $(DOCKER_ID) bash

clean:
	-docker rm $(DOCKER_ID)
	docker images -q $(DOCKER_ID) | xargs -r docker rmi
	rm -f .invalidate-cache
	rm -rf install/

superclean:
	docker ps -aq -f status=exited | xargs -r docker rm
	-docker images -q -f dangling=true | xargs -r docker rmi

invalidate-cache:
	echo `date '+%s'` >> .invalidate-cache
