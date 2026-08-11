# Installing Dependencies
You can install the required dependencies using your distribution's package manager.

### 1. Debian / Ubuntu / Linux Mint / Pop!_OS

```bash
sudo apt update
sudo apt install docker.io git
```

### 2. Arch Linux / EndeavourOS / Manjaro

```bash
sudo pacman -S docker git
```

### 3. Fedora

```bash
sudo dnf install docker git
```

### 4. RHEL / Rocky Linux / AlmaLinux

```bash
sudo dnf install docker git
```

> **Note:** Docker is available through the Docker CE repository on some RHEL-based distributions. If `docker` isn't found, install Docker CE by following Docker's official installation guide.

### 5. openSUSE (Leap / Tumbleweed)

```bash
sudo zypper install docker git
```

### 6. Alpine Linux

```bash
sudo apk add docker git
```

### 7. Void Linux

```bash
sudo xbps-install -S docker git
```

### 8. Gentoo

```bash
sudo emerge --ask app-containers/docker dev-vcs/git
```

---

After installing Docker, enable and start its service:

```bash
sudo systemctl enable --now docker
```

(Optional) Allow your user to run Docker without `sudo`:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in (or reboot) for the group change to take effect.
