#!/bin/bash

###############################################################################
#
# SCRIPT TO MAKE DISK IMAGE
#
###############################################################################

. ../include.sh
. include-config.sh

if [ -f ${TEST}/disk.img ]; then
	exit 0
fi

dd if=/dev/zero of=${TEST}/disk.img bs=512 count=$DISK_SECTORS
if [ $? -ne 0 ]; then
	echo "Failed to create blank disk image" 1>&2
	exit 1
fi

chown $(stat -c '%u' ${BUILD}/mount):$(stat -c '%g' ${BUILD}/mount) ${TEST}/disk.img
