#!/bin/sh
set -e

export OLD_PACKAGE=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-license-7-5_7.5-18_amd64.deb
export NEW_VERSION=7.5-18ppa4

cd `dirname $0`
make build
