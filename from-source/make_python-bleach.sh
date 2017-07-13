#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/bleach/archive/v1.5.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/bleach/archive/debian/1.5.tar.gz

cd `dirname $0`
make build
