#!/bin/bash

set -eu

TARGETS+=("aarch64-linux-musl")
TARGETS+=("armv7-linux-musleabihf")
TARGETS+=("x86_64-linux-musl")

NPROC=$(($(getconf _NPROCESSORS_ONLN) - 1))

export CC=gcc
export CXX=g++

export MAKE="make"
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
    make -C musl-cross-make MAKE=make TARGET="${TARGET}"
		make -C musl-cross-make MAKE=make TARGET="${TARGET}" install OUTPUT="${OUTPUT}"
done
