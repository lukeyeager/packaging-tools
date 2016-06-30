#!/bin/sh
set -e

export SOURCE_TARBALL=https://github.com/lukeyeager/wtforms/archive/2.0.1.tar.gz
export DEBIAN_TARBALL=https://github.com/lukeyeager/wtforms/archive/debian/2.0.1.tar.gz

make build
