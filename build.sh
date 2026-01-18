#!/bin/bash

set -eu

TARGETS+=("x86_64-linux-musl")
TARGETS+=("i686-linux-musl")
TARGETS+=("aarch64-linux-musl")
TARGETS+=("aarch64_be-linux-musl")
TARGETS+=("arm-linux-musleabi")
TARGETS+=("arm-linux-musleabihf")
TARGETS+=("armeb-linux-musleabi")
TARGETS+=("armeb-linux-musleabihf")
TARGETS+=("riscv64-linux-musl")

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
