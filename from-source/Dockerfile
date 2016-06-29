FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends --force-yes \
        build-essential \
        ca-certificates \
        devscripts \
        equivs \
        git \
        lintian

RUN mkdir /build
WORKDIR /build

ARG GIT_URL
ARG GIT_SRC
ARG GIT_DEB
ADD .invalidate-cache .invalidate-cache

RUN git clone $GIT_URL package
RUN cd package && git checkout $GIT_SRC && \
        git -c user.name="nobody" -c user.email="no@email" merge $GIT_DEB
RUN echo y | mk-build-deps -i -r package/debian/control

# All in one command because we need dynamic envvars
RUN PKG_NAME=`dpkg-parsechangelog -lpackage/debian/changelog --show-field Source` && \
        PKG_VERSION=`dpkg-parsechangelog -lpackage/debian/changelog --show-field Version | rev | cut -d'-' -f2- | rev` && \
        mv package $PKG_NAME && \
        cd $PKG_NAME && \
        git archive $GIT_SRC -o ../${PKG_NAME}_${PKG_VERSION}.orig.tar.gz && \
        debuild --no-lintian -i -uc -us -b && \
        debuild --no-lintian -i -uc -us -S -sa && \
        lintian ../*.changes && \
        mkdir -p /install/$PKG_NAME && \
        cp ../* /install/$PKG_NAME/ || true
