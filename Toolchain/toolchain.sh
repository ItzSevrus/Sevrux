#!/usr/bin/env bash

export TOOLCHAIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export PREFIX="$TOOLCHAIN_ROOT/install"
export TARGET="x86_64-elf"

export DOWNLOADS="$TOOLCHAIN_ROOT/downloads"
export SRC="$TOOLCHAIN_ROOT/src"
export BUILD="$TOOLCHAIN_ROOT/build"
export SCRIPTS="$TOOLCHAIN_ROOT/scripts"

export BINUTILS_VERSION="2.45"
export GCC_VERSION="14.3.0"

export MAKEFLAGS="-j$(nproc)"

export PATH="$PREFIX/bin:$PATH"
