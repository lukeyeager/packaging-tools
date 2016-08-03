FROM ubuntu:14.04

RUN apt-get update -q
RUN apt-get install -q -y --no-install-recommends --force-yes \
        build-essential \
        ca-certificates \
        devscripts \
        equivs \
        lintian \
        wget

RUN mkdir /build
WORKDIR /build

ARG SOURCE_TARBALL
ARG DEBIAN_TARBALL

ADD .invalidate-cache .invalidate-cache

RUN wget -q $SOURCE_TARBALL -O source.tar && tar xf source.tar
RUN wget -q $DEBIAN_TARBALL -O debian.tar && tar xf debian.tar --strip 1
RUN echo y | mk-build-deps -i -r debian/control

# All in one command for dynamic envvars
RUN PKG_NAME=`dpkg-parsechangelog --show-field Source` && \
        PKG_VERSION=`dpkg-parsechangelog --show-field Version | rev | cut -d'-' -f2- | rev` && \
        PKG_DIR=`tar tf source.tar | cut -d'/' -f1 | sort | uniq` && \
        mv source.tar ${PKG_NAME}_${PKG_VERSION}.orig.tar.gz && \
        cd $PKG_DIR && \
        mv ../debian . && \
        debuild --no-lintian -i -uc -us -b && \
        debuild --no-lintian -i -uc -us -S -sa && \
        lintian ../*.changes && \
        mkdir -p /install/$PKG_NAME && \
        ( cp ../* /install/$PKG_NAME/ || true )

