#!/bin/sh
set -ex

# clean up remnants from cpp build phase
rm -rf build
mkdir build
cd build

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_DEPS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_SAMPLES=OFF \
    -DBUILD_TESTING=OFF \
    -DBUILD_PYTHON=ON \
    -DFETCH_PYTHON_DEPS=OFF \
    -DBUILD_pybind11=OFF \
    -DPython3_EXECUTABLE="$PYTHON" \
    -DUSE_SCIP=OFF \
    ..

cmake --build . -j${CPU_COUNT}
cd ..

echo Install begins here

${PYTHON} -m pip install --no-index --find-links=build/python/dist ortools -vv
