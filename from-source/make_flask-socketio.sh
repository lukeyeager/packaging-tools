#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/Flask-SocketIO/archive/v2.6.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/Flask-SocketIO/archive/debian/2.6.tar.gz
export PPA_NAME=luke-yeager/digits

cd `dirname $0`
make build
