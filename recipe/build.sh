#!/bin/sh
set -ex

mkdir build
cd build

if [[ "${target_platform}" != "${build_platform}" ]]; then
    CMAKE_ARGS="${CMAKE_ARGS} -DProtobuf_PROTOC_EXECUTABLE=$BUILD_PREFIX/bin/protoc"
fi

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_DEPS=OFF \
    -DBUILD_FLATZINC=ON \
    -DBUILD_GLOP=OFF \
    -DBUILD_LP_PARSER=ON \
    -DBUILD_PDLP=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_SAMPLES=OFF \
    -DUSE_COINOR=ON \
    -DUSE_CPLEX=OFF \
    -DUSE_GLPK=OFF \
    -DUSE_HIGHS=OFF \
    -DUSE_PDLP=ON \
    -DUSE_SCIP=OFF \
    -DUSE_XPRESS=OFF \
    ..

cmake --build .
