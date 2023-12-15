#!/usr/bin/env bash

set -eux

if [ ! -d build ]; then
    mkdir -p build
    cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Debug || rm -rf build
fi
if [ -d build ]; then
    cmake --build build
    cmake --install build --prefix install
fi
