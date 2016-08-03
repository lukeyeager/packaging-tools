FROM ubuntu:14.04

RUN apt-get -q update
RUN apt-get -q install -y --no-install-recommends --force-yes \
        build-essential \
        ca-certificates \
        debhelper \
        devscripts \
        fakeroot \
        lintian \
        wget

RUN mkdir /build
WORKDIR /build

ARG OLD_PACKAGE
ARG NEW_VERSION
ARG DEBEMAIL
ARG DEBFULLNAME

ADD debian-rules debian-rules
ADD .invalidate-cache .invalidate-cache

RUN wget -q $OLD_PACKAGE -O orig.deb

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
        mkdir debian/source/ && \
        echo "maintainer-script-lacks-debhelper-token" >> debian/source/lintian-overrides && \
        cat usr/share/lintian/overrides/$PKG_NAME | cut -d: -f2- > debian/${PKG_NAME}.lintian-overrides && \
        rm usr/share/lintian/overrides/$PKG_NAME || true && \
        mv ../debian-rules debian/rules && \
        rm debian/control && \
        echo "Source: $PKG_NAME" >> debian/control && \
        echo "Maintainer: $PKG_MAINTAINER" >> debian/control && \
        echo "Section: $PKG_SECTION" >> debian/control && \
        echo "Priority: $PKG_PRIORITY" >> debian/control && \
        echo "Build-Depends: debhelper (>= 9)" >> debian/control && \
        echo "Standards-Version: 3.9.5" >> debian/control && \
        echo "" >> debian/control && \
        echo "Package: $PKG_NAME" >> debian/control && \
        echo "Architecture: $PKG_ARCH" >> debian/control && \
        echo "Section: $PKG_SECTION" >> debian/control && \
        echo "Priority: $PKG_PRIORITY" >> debian/control && \
        echo "Depends: \${misc:Depends}" >> debian/control && \
        echo "Description: $PKG_DESC" >> debian/control && \
        echo "9" >> debian/compat && \
        find . -type d -empty -delete && \
        tar czvf ../${PKG_NAME}_${SOURCE_VERSION}.orig.tar.gz --exclude debian . && \
        debuild --no-lintian -uc -us -b && \
        lintian ../*.deb | head -n -1 | awk '{ print $3 }' | sort | uniq >> debian/${PKG_NAME}.lintian-overrides && \
        debuild --no-lintian -uc -us -b && \
        debuild --no-lintian -uc -us -S -sa && \
        lintian ../*.changes && \
        mkdir -p /install/$PKG_NAME && \
        ( cp ../* /install/$PKG_NAME/ || true )

