#!/bin/sh
set -ex

mkdir build-cpp
cd build-cpp

if [[ "${target_platform}" != "${build_platform}" ]]; then
    CMAKE_ARGS="${CMAKE_ARGS} -DProtobuf_PROTOC_EXECUTABLE=$BUILD_PREFIX/bin/protoc"
fi

if [[ "${target_platform}" == "linux-64" ]]; then
    # https://github.com/conda-forge/scipoptsuite-feedstock not built for aarch/ppc yet
    CMAKE_ARGS="${CMAKE_ARGS} -DUSE_SCIP=ON"
else
    CMAKE_ARGS="${CMAKE_ARGS} -DUSE_SCIP=OFF"
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
    -DBUILD_SAMPLES=ON \
    -DUSE_COINOR=ON \
    -DUSE_CPLEX=OFF \
    -DUSE_GLPK=OFF \
    -DUSE_HIGHS=OFF \
    -DUSE_PDLP=ON \
    -DUSE_XPRESS=OFF \
    ..

cmake --build .
