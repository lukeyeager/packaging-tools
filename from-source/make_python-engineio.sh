#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/python-engineio/archive/v0.9.2.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/python-engineio/archive/debian/0.9.2.tar.gz

cd `dirname $0`
make build
