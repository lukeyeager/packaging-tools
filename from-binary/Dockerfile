FROM ubuntu:14.04

RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
        build-essential \
        debhelper \
        devscripts \
        fakeroot \
        && rm -rf /var/lib/apt/lists/*


ARG OLD_PACKAGE
ARG NEW_VERSION
ARG DEBEMAIL
ARG DEBFULLNAME

ENV BUILD_DIR /build
WORKDIR $BUILD_DIR

ADD $OLD_PACKAGE orig.deb
ADD debian-rules debian-rules

# All in one command because we need dynamic envvars
RUN PKG_NAME=`dpkg-deb -f orig.deb Package` && \
        PKG_VERSION=`dpkg-deb -f orig.deb Version` && \
        SOURCE_VERSION=`echo $PKG_VERSION | rev | cut -d'-' -f2- | rev` && \
        PKG_MAINTAINER=`dpkg-deb -f orig.deb Maintainer` && \
        PKG_ARCH=`dpkg-deb -f orig.deb Architecture` && \
        PKG_SECTION=`dpkg-deb -f orig.deb Section` && \
        PKG_PRIORITY=`dpkg-deb -f orig.deb Priority` && \
        PKG_DESC=`dpkg-deb -f orig.deb Description` && \
        dpkg-deb -R orig.deb $PKG_NAME && \
        rm orig.deb && \
        cd $PKG_NAME && \
        mv DEBIAN debian && \
        mv usr/share/doc/$PKG_NAME/copyright debian/ && \
        mv usr/share/doc/$PKG_NAME/changelog* debian/changelog.gz && \
        gunzip debian/changelog.gz && \
        dch -v $NEW_VERSION "PPA Build" && \
        dch -r "" && \
        mv usr/share/lintian/overrides/$PKG_NAME debian/lintian-overrides || true && \
        mv ../debian-rules debian/rules && \
        rm debian/control && \
        echo "Source: $PKG_NAME" >> debian/control && \
        echo "Maintainer: $PKG_MAINTAINER" >> debian/control && \
        echo "Section: $PKG_SECTION" >> debian/control && \
        echo "Priority: $PKG_PRIORITY" >> debian/control && \
        echo "Build-Depends: debhelper (>= 9)" >> debian/control && \
        echo "Standards-Version: 3.9.8" >> debian/control && \
        echo "" >> debian/control && \
        echo "Package: $PKG_NAME" >> debian/control && \
        echo "Architecture: $PKG_ARCH" >> debian/control && \
        echo "Section: $PKG_SECTION" >> debian/control && \
        echo "Priority: $PKG_PRIORITY" >> debian/control && \
        echo "Description: $PKG_DESC" >> debian/control && \
        echo "9" >> debian/compat && \
        find . -type d -empty -delete && \
        tar czvf ../${PKG_NAME}_${SOURCE_VERSION}.orig.tar.gz --exclude debian . && \
        debuild -S -uc -us -sa && \
        mkdir -p /install/$PKG_NAME && \
        cp ../* /install/$PKG_NAME/ || true
