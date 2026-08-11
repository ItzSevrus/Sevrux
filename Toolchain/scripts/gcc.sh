#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../toolchain.sh"

echo "=========================================="
echo "      Building GCC ${GCC_VERSION}"
echo "=========================================="

echo "[*] Cleaning previous build..."

rm -rf "$SRC/gcc-${GCC_VERSION}"
rm -rf "$BUILD/gcc"
rm -f "$DOWNLOADS/gcc-${GCC_VERSION}.tar.xz"

mkdir -p "$DOWNLOADS" "$SRC" "$BUILD"

echo
echo "[*] Downloading GCC ${GCC_VERSION}..."

cd "$DOWNLOADS"

wget "https://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz"

echo
echo "[*] Extracting..."

tar -xf "gcc-${GCC_VERSION}.tar.xz"
mv "gcc-${GCC_VERSION}" "$SRC/"

echo
echo "[*] Downloading prerequisites..."

cd "$SRC/gcc-${GCC_VERSION}"

./contrib/download_prerequisites

echo
echo "[*] Configuring..."

mkdir -p "$BUILD/gcc"
cd "$BUILD/gcc"

"$SRC/gcc-${GCC_VERSION}/configure" \
    --target="$TARGET" \
    --prefix="$PREFIX" \
    --disable-nls \
    --enable-languages=c,c++ \
    --without-headers

echo
echo "[*] Building GCC..."

make all-gcc ${MAKEFLAGS:-"-j$(nproc)"}

echo
echo "[*] Building libgcc..."

make all-target-libgcc ${MAKEFLAGS:-"-j$(nproc)"}

echo
echo "[*] Installing GCC..."

make install-gcc

echo
echo "[*] Installing libgcc..."

make install-target-libgcc

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
