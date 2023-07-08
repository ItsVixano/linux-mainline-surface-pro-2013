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
git add config && git commit -m "config: Regen config for linux ${kernelversion}"
cd "${MY_DIR}"
