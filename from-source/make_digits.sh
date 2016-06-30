#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/DIGITS/archive/v3.0.0.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/DIGITS/archive/debian/3.0.0.tar.gz

make build
