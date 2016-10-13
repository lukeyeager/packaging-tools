#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/scikit-fmm/archive/v0.0.9.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/scikit-fmm/archive/debian/0.0.9.tar.gz

cd `dirname $0`
make build
