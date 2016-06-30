#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/Flask-SocketIO/archive/v0.6.0.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/Flask-SocketIO/archive/debian/0.6.0.tar.gz

cd `dirname $0`
make build
