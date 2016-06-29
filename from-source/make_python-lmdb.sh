#!/bin/sh
set -e

export GIT_URL=https://github.com/lukeyeager/py-lmdb.git
export GIT_SRC=py-lmdb_0.87
export GIT_DEB=origin/debian/0.87

make build
