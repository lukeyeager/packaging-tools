#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/py-lmdb/archive/py-lmdb_0.87.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/py-lmdb/archive/debian/0.87.tar.gz

cd `dirname $0`
make build
