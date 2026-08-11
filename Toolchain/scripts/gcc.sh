#!/usr/bin/env bash

set -euo pipefail

# ==========================================================
# Configuration
# ==========================================================

export TOOLCHAIN_ROOT="/workspace/Toolchain"
export PREFIX="$TOOLCHAIN_ROOT/install"
export TARGET="x86_64-elf"
export PATH="$PREFIX/bin:$PATH"

cd "$TOOLCHAIN_ROOT"

echo "=========================================="
echo "      Building GCC 14.3.0 Cross Compiler"
echo "=========================================="

# ==========================================================
# Clean previous build
# ==========================================================

echo "[*] Cleaning previous build..."

rm -rf src/gcc-14.3.0
rm -rf build/gcc
rm -f downloads/gcc-14.3.0.tar.xz

mkdir -p downloads
mkdir -p src
mkdir -p build

# ==========================================================
# Download GCC
# ==========================================================

echo
echo "[*] Downloading GCC 14.3.0..."

cd downloads

wget https://ftp.gnu.org/gnu/gcc/gcc-14.3.0/gcc-14.3.0.tar.xz

# ==========================================================
# Extract
# ==========================================================

echo
echo "[*] Extracting..."

tar -xf gcc-14.3.0.tar.xz
mv gcc-14.3.0 ../src/

# ==========================================================
# Download prerequisites
# ==========================================================

echo
echo "[*] Downloading prerequisites..."

cd ../src/gcc-14.3.0

./contrib/download_prerequisites

# ==========================================================
# Configure
# ==========================================================

echo
echo "[*] Configuring..."

cd ../../

mkdir -p build/gcc
cd build/gcc

../../src/gcc-14.3.0/configure \
    --target="$TARGET" \
    --prefix="$PREFIX" \
    --disable-nls \
    --enable-languages=c,c++ \
    --without-headers

# ==========================================================
# Build
# ==========================================================

echo
echo "[*] Building GCC..."

make all-gcc -j"$(nproc)"

echo
echo "[*] Building libgcc..."

make all-target-libgcc -j"$(nproc)"

# ==========================================================
# Install
# ==========================================================

echo
echo "[*] Installing GCC..."

make install-gcc

echo
echo "[*] Installing libgcc..."

make install-target-libgcc

# ==========================================================
# Verify
# ==========================================================

echo
echo "=========================================="
echo "Toolchain Installed Successfully!"
echo "=========================================="

echo
"$PREFIX/bin/x86_64-elf-gcc" --version

echo
"$PREFIX/bin/x86_64-elf-g++" --version

echo
"$PREFIX/bin/x86_64-elf-ld" --version

echo
echo "[✓] Cross compiler is ready."
