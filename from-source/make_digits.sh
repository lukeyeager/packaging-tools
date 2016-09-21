#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/DIGITS/archive/setup.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/DIGITS/archive/debian/master.tar.gz

cd `dirname $0`
make build
