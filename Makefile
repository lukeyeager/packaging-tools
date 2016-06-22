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

BUILD_DIR := $(shell pwd)/build

build:
	docker build -t debian-build:base -f Dockerfile.base .
	docker build -t debian-build:build \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GIT_URL=$(GIT_URL) \
		--build-arg GIT_SRC=$(GIT_SRC) \
		--build-arg GIT_DEB=$(GIT_DEB) \
		-f Dockerfile.build .
	mkdir -p $(BUILD_DIR)
	docker run --rm -v $(BUILD_DIR):/result debian-build:build
	docker rmi debian-build:build
