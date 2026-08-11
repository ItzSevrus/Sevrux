# Building the Cross Toolchain (Docker)

The Sevrux toolchain is built inside a Debian container to ensure a clean and reproducible environment. This prevents host system libraries from interfering with the build.

## Requirements

- Docker
- Git
- Internet connection

Verify Docker is installed:

```bash
docker --version
```
> If **dependencies** are not installed, you can find instructions [Here!](INSTALL.md)
---

## Start the Build Environment

From the Sevrux repository root, launch a Debian container:

```bash
docker run -it \
    --name sevrux-toolchain \
    -v "$PWD":/workspace \
    -w /workspace \
    debian:stable
```

> **Note**
>
> The project directory is mounted into `/workspace` inside the container.

---

## Install Build Dependencies

Inside the container run:

```bash
apt update

apt install -y \
    build-essential \
    bison \
    flex \
    texinfo \
    wget \
    curl \
    xz-utils \
    gawk \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    libisl-dev \
    zlib1g-dev \
    python3
```

---

## Build the Toolchain

Move into the toolchain directory:

```bash
cd /workspace/Toolchain
```

Run the provided scripts:

```bash
./scripts/binutils.sh
./scripts/gcc.sh
```
- **binutils.sh** - This script compiles the **binutils**.
- **gcc.sh** - This script compiles the **GCC Compiler**.
---

## Configure the Environment

After the build completes:
- You have to set these **environment variables**.
```bash
export PREFIX=/workspace/Toolchain/install
export TARGET=x86_64-elf
export PATH="$PREFIX/bin:$PATH"
```

- You can use this command to set those variables automatically.
```bash
source toolchain.sh
```
---

## Verify the Installation

```bash
x86_64-elf-gcc --version
x86_64-elf-g++ --version
x86_64-elf-as --version
x86_64-elf-ld --version
x86_64-elf-objdump --version
```

Expected output:

```
x86_64-elf-gcc (GCC) 14.3.0
GNU ld (GNU Binutils) 2.45
GNU assembler (GNU Binutils) 2.45
...
```

---

## Re-entering the Container

If you stopped the container, restart it with:

```bash
docker start -ai sevrux-toolchain
```

The mounted project directory and installed packages will still be available.
