# PKGBUILD For Docker

[Docker installation guide](https://www.digitalocean.com/community/tutorial_collections/how-to-install-and-use-docker)

### Post Docker installation
```bash
# Create a Docker container
docker run -it archlinux

# Initial setup
pacman-key --init
pacman -Sy --noconfirm base-devel nano wget git
sed -i '/E_ROOT/d' /usr/bin/makepkg

# Compile the kernel
mkdir build
cd build
wget https://raw.githubusercontent.com/ItsVixano/linux-mainline-surface-pro-2013/master/build/PKGBUILD
MAKEFLAGS="-j$(nproc)"  makepkg -s --noconfirm --skippgpcheck
```

### You will endup with 2 tars
- linux-mainline-6.1-1-x86_64.pkg.tar.zst "Contains kernel images and modules"
- linux-mainline-headers-6.1.1-x86_64.pkg.tar.zst "Contains kernel headers"

Use tar to extract them

```bash
tar --use-compress-program=unzstd -xvf file.tar.zst
```

Use curl to upload the tars

```bash
curl -T file.tar.zst https://oshi.at
```
