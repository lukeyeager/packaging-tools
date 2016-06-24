#!/bin/sh
set -e

export GIT_URL=https://github.com/lukeyeager/Flask-SocketIO.git
export GIT_SRC=v0.6.0
export GIT_DEB=origin/debian/0.6.0

make
