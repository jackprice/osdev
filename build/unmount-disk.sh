#!/bin/bash

###############################################################################
#
# SCRIPT TO UNMOUNT DISK
#
###############################################################################

. ../include.sh

MOUNT=${BUILD}/mount
DISK=${TEST}/disk.img

# Try and unmount
umount $MOUNT &>/dev/null

# Try and detach loopback device
LODEV=$(losetup -j ../test/disk.img | grep -e "/dev/loop[0-9]" -o) &>/dev/null
if [ $? -eq 0 ]; then 
	losetup -d $LODEV &>/dev/null
fi
