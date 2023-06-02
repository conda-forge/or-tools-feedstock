#!/bin/sh
set -ex

# do not use the same folder as global build.sh,
# but delete it from any previous python builds
rm -rf build-py || true
mkdir build-py
cd build-py

if [[ "${target_platform}" != "${build_platform}" ]]; then
    CMAKE_ARGS="${CMAKE_ARGS} -DProtobuf_PROTOC_EXECUTABLE=$BUILD_PREFIX/bin/protoc"
fi

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_CXX=OFF \
    -DBUILD_DEPS=OFF \
    -DBUILD_GLOP=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_SAMPLES=OFF \
    -DBUILD_TESTING=OFF \
    -DBUILD_PYTHON=ON \
    -DFETCH_PYTHON_DEPS=OFF \
    -DBUILD_pybind11=OFF \
    -DPython3_EXECUTABLE="$PYTHON" \
    ..

cmake --build . -j${CPU_COUNT}
cd ..

echo Install begins here

${PYTHON} -m pip install --no-index --find-links=build-py/python/dist ortools -vv
