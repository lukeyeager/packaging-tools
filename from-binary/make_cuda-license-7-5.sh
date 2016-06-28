#!/bin/sh
set -e

wget -nc http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-license-7-5_7.5-18_amd64.deb
export OLD_PACKAGE=cuda-license-7-5_7.5-18_amd64.deb
export NEW_VERSION=7.5-18ppa4

make
