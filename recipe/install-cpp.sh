#!/bin/sh
set -ex

if [[ "$PKG_NAME" == "libortools" ]]; then
    mkdir temp_prefix
    cmake --install ./build --prefix=./temp_prefix
    # install only library components & headers
    cp -R ./temp_prefix/lib/* $PREFIX/lib
    cp -R ./temp_prefix/include/* $PREFIX/include
else
    # install everything else (binaries/share ...)
    cmake --install ./build --prefix=$PREFIX
fi
