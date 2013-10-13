#!/bin/bash

###############################################################################
#
# SCRIPT TO MOUNT DISK
#
###############################################################################

. ../include.sh

MOUNT=${BUILD}/mount
DISK=${TEST}/disk.img

# Check we're not already looped
ISLO=$(losetup -j $DISK)
if [ -n "$ISLO" ]; then
	ISLO=true
else
	ISLO=false
fi

# Check we're not already mounted
ISMOUNT=false
if mount | grep "$MOUNT" >/dev/null; then
	exit 0
fi

# Make sure directory exists
if [ ! -d $MOUNT ]; then
	mkdir $MOUNT
	if [ $? -ne 0 ]; then
		echo "Could not create mount point $MOUNT" 1>&2
		exit 1
	fi
fi

# Attach loop device if necessary
if ! $ISLO; then
	# Get a free loop device
	LOOP=$(losetup -f)
	if [ $? -ne 0 ]; then
		echo "Could not get a free loop device" 1>&2
		exit 1
	fi

	# Check disk exists
	if [ ! -f $DISK ]; then
		echo "Disk file $DISK does not exist" 1>&2
		exit 1
	fi

	# Attach loop device
	losetup $LOOP $DISK
fi

# Mount
mount $DISK $MOUNT -o offset=512,uid=$(stat -c '%u' $MOUNT),gid=$(stat -c '%g' $MOUNT),rw,user &>/dev/null
