#!/bin/sh
set -ex

if [[ "$PKG_NAME" == "libortools" ]]; then
    mkdir temp_prefix
    cmake --install ./build-cpp --prefix=./temp_prefix
    # install only library components & headers
    cp -R ./temp_prefix/lib/* $PREFIX/lib
    cp -R ./temp_prefix/include/* $PREFIX/include
    rm -rf temp_prefix
elif [[ "$PKG_NAME" == "ortools-cpp" ]]; then
    mkdir temp_prefix
    cmake --install ./build-cpp --prefix=./temp_prefix
    # install selected binaries & share
    cp -R ./temp_prefix/share/* $PREFIX/share
    cp ./temp_prefix/bin/fzn-ortools $PREFIX/bin
    cp ./temp_prefix/bin/sat_runner $PREFIX/bin
    cp ./temp_prefix/bin/solve $PREFIX/bin
else
    # install everything else (samples)
    cmake --install ./build-cpp --prefix=$PREFIX
fi
