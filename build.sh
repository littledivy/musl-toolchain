#!/bin/bash

set -eu

TARGETS+=("aarch64-linux-musl")
TARGETS+=("armv7-linux-musleabihf")
TARGETS+=("x86_64-linux-musl")

NPROC=$(($(getconf _NPROCESSORS_ONLN) - 1))

export MAKEFLAGS="-j ${NPROC}"
export NINJAFLAGS="-j ${NPROC}"

for TARGET in "${TARGETS[@]}"; do
    OUTPUT=${PWD}/toolchain

    if [ -f "${OUTPUT}/bin/${TARGET}-gcc" ]; then
        echo "toolchain for ${TARGET} present"
        continue
    fi

    echo "building toolchain for ${TARGET}"

    cp config.mak musl-cross-make

    if ! make -C musl-cross-make TARGET="${TARGET}" &> "build-${TARGET}.log"; then
        echo "Build failed for ${TARGET}. Log output:"
        cat "build-${TARGET}.log"
        exit 1
    fi
    make -C musl-cross-make TARGET="${TARGET}" install OUTPUT="${OUTPUT}"
done
