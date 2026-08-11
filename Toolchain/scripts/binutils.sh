#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../toolchain.sh"

echo "=========================================="
echo "   Building Binutils ${BINUTILS_VERSION}"
echo "=========================================="

echo "[*] Cleaning..."

rm -rf "$SRC/binutils-${BINUTILS_VERSION}"
rm -rf "$BUILD/binutils"
rm -f "$DOWNLOADS/binutils-${BINUTILS_VERSION}.tar.xz"

echo "[*] Downloading..."

mkdir -p "$DOWNLOADS"
cd "$DOWNLOADS"

wget "https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.xz"

echo
echo "[*] Extracting..."

tar -xf "binutils-${BINUTILS_VERSION}.tar.xz"

mkdir -p "$SRC"
mv "binutils-${BINUTILS_VERSION}" "$SRC/"

echo
echo "[*] Configuring..."

mkdir -p "$BUILD/binutils"
cd "$BUILD/binutils"

"$SRC/binutils-${BINUTILS_VERSION}/configure" \
    --target="$TARGET" \
    --prefix="$PREFIX" \
    --with-sysroot \
    --disable-nls \
    --disable-werror

echo
echo "[*] Compiling..."

make ${MAKEFLAGS}

echo
echo "[*] Installing..."

make install

echo
echo "=========================================="
echo " Binutils Installed Successfully!"
echo "=========================================="

echo
"$PREFIX/bin/x86_64-elf-as" --version

echo
"$PREFIX/bin/x86_64-elf-ld" --version

echo
"$PREFIX/bin/x86_64-elf-objdump" --version

echo
echo "[✓] Binutils is ready."
