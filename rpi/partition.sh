#!/usr/bin/env bash

set -o xtrace
set -o errexit
set -o nounset

DISK_IDENTIFIER=$1

if [[ $# -lt 1 ]]; then
  echo "Not enough args"
  exit 1
fi;

function info {
  echo -n "==== "
  echo $1
  echo " ===="
}


TAR_FILE="ArchLinuxARM-rpi-aarch64-latest.tar.gz"
if [[ ! -f ${TAR_FILE} ]]; then
  info "Downloading..."
  curl -LO http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz
fi


info "Make label dos"
parted /dev/${DISK_IDENTIFIER} --script -- mklabel msdos
info "Primary fat32"
parted /dev/${DISK_IDENTIFIER} --script -- mkpart primary fat32 1 128
info "Primary ext4 (root)"
parted /dev/${DISK_IDENTIFIER} --script -- mkpart primary ext4 128 100%
info "Set boot"
parted /dev/${DISK_IDENTIFIER} --script -- set 1 boot on
info "Status:"
parted /dev/${DISK_IDENTIFIER} --script print

info "Make vfat"
mkfs.vfat -F32 "/dev/${DISK_IDENTIFIER}p1"

info "Make ext4"
mkfs.ext4 -F "/dev/${DISK_IDENTIFIER}p2"

info "Making folders"
mkdir -p {boot,root}

info "Mounting..."
mount "/dev/${DISK_IDENTIFIER}p1" boot
mount "/dev/${DISK_IDENTIFIER}p2" root

info "Untarring..."
tar -xf ${TAR_FILE} -C root

info "Moving..."
mv root/boot/* boot
umount boot root
