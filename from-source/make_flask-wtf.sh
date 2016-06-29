#!/bin/sh
set -e

export GIT_URL=https://github.com/lukeyeager/flask-wtf.git
export GIT_SRC=v0.11
export GIT_DEB=origin/debian/0.11

make build
