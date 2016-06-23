#!/bin/sh
set -e

export GIT_URL=https://github.com/lukeyeager/wtforms.git
export GIT_SRC=2.0.1
export GIT_DEB=origin/debian/2.0.1

make
