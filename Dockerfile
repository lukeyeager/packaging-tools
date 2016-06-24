FROM debian-build:base

RUN apt-get update

ARG GIT_URL
ARG GIT_SRC
ARG GIT_DEB

RUN mkdir -p /build
WORKDIR /build

# All in one command because we need dynamic envvars
RUN git clone $GIT_URL package && \
    cd package && \
    git checkout $GIT_DEB && \
    export PACKAGE_NAME=`dpkg-parsechangelog --show-field Source` && \
    export PACKAGE_VERSION=`dpkg-parsechangelog --show-field Version | rev | cut -d'-' -f2- | rev` && \
    cd .. && \
    mv package $PACKAGE_NAME && \
    cd $PACKAGE_NAME && \
    git archive $GIT_SRC -o ../${PACKAGE_NAME}_${PACKAGE_VERSION}.orig.tar.gz && \
    git -c user.name="nobody" -c user.email="no@email" merge $GIT_SRC && \
    echo y | mk-build-deps -i -r debian/control && \
    debuild -S -uc -us -sa && \
    mkdir -p /install/$PACKAGE_NAME && \
    cp ../* /install/$PACKAGE_NAME/ || true
