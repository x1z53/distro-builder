#!/bin/bash

set -e

echo "::group:: ===$(basename "$0")==="

sudo podman exec iso-builder su - builder -c "
  cd ~
  git clone https://altlinux.space/x1z53/alt-mobile-mkimage-profiles mkimage-profiles
  cd mkimage-profiles
  mki-build -- make \
    vm/alt-mobile-phosh-{def,pine}.img \
    BRANCH='sisyphus' ARCH='aarch64' \
    DEBUG=1 STDOUT=1 REPORT=1 CLEAN=1 VM_SAVE_TARBALL=tar
  mki-build -- make \
    vm/alt-mobile-phosh-{lt11i,rocknix}.img \
    BRANCH='sisyphus' ARCH='aarch64' \
    DEBUG=1 STDOUT=1 REPORT=1 CLEAN=1 VM_SAVE_TARBALL=tar
  mki-build -- make \
    vm/alt-mobile-phosh-def.img \
    BRANCH='sisyphus' ARCH='x86_64' \
    DEBUG=1 STDOUT=1 REPORT=1 CLEAN=1
  mki-build -- make \
    vm/alt-mobile-phosh-def.img \
    BRANCH='sisyphus' ARCH='riscv64' \
    DEBUG=1 STDOUT=1 REPORT=1 CLEAN=1
"

echo "::endgroup::"
