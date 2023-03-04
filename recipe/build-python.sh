#!/bin/sh
set -ex

cmake -G Ninja \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_DEPS=OFF \
      -DUSE_SCIP=OFF \
      -S. \
      -Bbuild \
      -DBUILD_SAMPLES=OFF \
      -DBUILD_EXAMPLES=OFF \
      -DBUILD_PYTHON=ON \
      -DBUILD_pybind11=OFF \
      -DFETCH_PYTHON_DEPS=OFF \
      -DBUILD_TESTING=OFF \
      -DPython3_EXECUTABLE="$PYTHON"

cmake --build build -j${CPU_COUNT}

echo Install begins here

${PYTHON} -m pip install --no-index --find-links=build/python/dist ortools -vv
