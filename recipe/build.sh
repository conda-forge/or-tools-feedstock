#!/bin/sh
set -ex

mkdir build
cd build

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_DEPS=OFF \
    -DBUILD_GLOP=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_SAMPLES=OFF \
    -DUSE_SCIP=OFF \
    ..

cmake --build .
