#!/bin/sh
set -e

export GIT_URL=https://github.com/lukeyeager/DIGITS.git
export GIT_SRC=v3.0.0
export GIT_DEB=origin/debian/3.0.0

make
