#!/bin/bash
# Used to change the version of a deb package
set -e

if [ "$#" -ne 2 ]; then
    echo 'Usage: $0 OLD_PACKAGE NEW_VERSION' >&2
    exit 1
fi

set -x

OLD_PACKAGE=$1
PACKAGE_NAME=`dpkg-deb -f $OLD_PACKAGE PACKAGE`
NEW_VERSION=$2
BUILD_DIR=/tmp/$PACKAGE_NAME

pushd .
rm -rf $BUILD_DIR
dpkg-deb -R $OLD_PACKAGE $BUILD_DIR
cd ${BUILD_DIR}/usr/share/doc/$PACKAGE_NAME
CHANGELOG_FILENAME_ZIPPED=`ls changelog*`
gunzip $CHANGELOG_FILENAME_ZIPPED
CHANGELOG_FILENAME_UNZIPPED=`ls changelog*`
dch -c $CHANGELOG_FILENAME_UNZIPPED -v $NEW_VERSION 'Change version'
dch -c $CHANGELOG_FILENAME_UNZIPPED -r ''
gzip $CHANGELOG_FILENAME_UNZIPPED
popd
dpkg-deb -b $BUILD_DIR ${PACKAGE_NAME}_${NEW_VERSION}.deb
