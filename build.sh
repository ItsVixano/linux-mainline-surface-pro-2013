#!/bin/bash

# Init vars
MY_DIR="${PWD}"
SURFACE_LINUX_DIR="${MY_DIR}"/linux-mainline-surface-pro-2013

# Copy and regenerate the config file
cp "${SURFACE_LINUX_DIR}"/config "${MY_DIR}"/.config
make ARCH=x86 olddefconfig
kernelversion=$(make -s kernelversion)
cp "${MY_DIR}"/.config "${SURFACE_LINUX_DIR}"/config
cd "${SURFACE_LINUX_DIR}"
git add config && git commit -m "config: Regen config for linux-mainline ${kernelversion}"
cd "${MY_DIR}"

# Build the kernel
make ARCH=x86 -j$(nproc)
make ARCH=x86 bzImage
make ARCH=x86 modules

# Install the kernel
sudo cp -v arch/x86/boot/bzImage /boot/vmlinuz-linux-mainline
sudo cp System.map /boot/System.map-linux-mainline
sudo ln -sf /boot/System.map-linux-mainline /boot/System.map
sudo make ARCH=x86 install modules

# Regenerate mkinitcpio
sudo cp "${SURFACE_LINUX_DIR}"/configs/linux-mainline.preset /etc/mkinitcpio.d/
sudo mkinitcpio -p linux-mainline

# Add systemd-boot loader
sudo cp "${SURFACE_LINUX_DIR}"/configs/linux-mainline.conf /boot/loader/entries/
sudo systemctl reboot --boot-loader-entry=linux-mainline.conf

echo -e "\nDone :D"
