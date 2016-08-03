#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/python-socketio/archive/v1.4.3.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/python-socketio/archive/debian/1.4.3.tar.gz
export PPA_NAME=luke-yeager/digits

cd `dirname $0`
make build
