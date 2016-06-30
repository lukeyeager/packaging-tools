#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/flask-wtf/archive/v0.11.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/flask-wtf/archive/debian/0.11.tar.gz

cd `dirname $0`
make build
