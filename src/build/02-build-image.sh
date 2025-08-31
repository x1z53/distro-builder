#!/bin/bash

set -e

echo "::group:: ===$(basename "$0")==="

sudo podman exec iso-builder su - builder -c "
  cd ~ && \
  git clone https://github.com/${GITHUB_REPOSITORY} --branch ${GITHUB_REF##*/} test-builder && \
  cd test-builder/src/source && \
  git clone -b next https://altlinux.space/mkimage-profiles/mkimage-profiles.git mkimage-profiles && \
  cd mkimage-profiles && \
  git checkout bb3408169b8c8dbe6fd7ff941887c6cffaa86998 && \
  cd ../ && \
  cp -rf mkimage/* mkimage-profiles && \
  cd mkimage-profiles
  make \
  IMAGEDIR=\"/workspace/out\" \
  BUILDLOG=\"/workspace/out/build.log\" \
  regular-gnome-atomic.iso"

echo "::endgroup::"
