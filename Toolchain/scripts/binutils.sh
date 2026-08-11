#!/usr/bin/env bash
set -e

export PREFIX="$HOME/workspace/Toolchain/install"
export TARGET="x86_64-elf"
export PATH="$PREFIX/bin:$PATH"

echo "[*] Cleaning trash"
rm -rf src/binutils-2.45
rm -rf build/binutils
rm -rf downloads/binutils-2.45.tar.xz

echo "[*] Downloading..."

cd downloads
wget https://ftp.gnu.org/gnu/binutils/binutils-2.45.tar.xz

echo -e "[*] Extracting...\n"

tar -xf binutils-2.45.tar.xz
mv binutils-2.45 ../src
mkdir -p ../build/binutils
cd ../build/binutils

echo -e "[*] Configuring...\n"

../../src/binutils-2.45/configure \
    --target=$TARGET \
    --prefix=$PREFIX \
    --with-sysroot \
    --disable-nls \
    --disable-werror

echo -e "[*] Compiling...\n"
make -j$(nproc)

echo -e "[*] Installing...\n"
make install
