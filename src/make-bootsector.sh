#!/bin/bash

###############################################################################
#
# SCRIPT TO GENERATE BOOTLOADER
#
###############################################################################

. ../include.sh

function offset {
	echo "TIMES $1 - (\$ - \$\$) DB 0"
}

PARTITION_END_HEAD=$((DISK_HEADS - 1))
PARTITION_END_SECTOR=$DISK_SECTORS_PER_TRACK
PARTITION_END_CYLINDER=$((DISK_CYLINDERS - 1))
PARTITION_SECTORS=$((DISK_SECTORS - 1))

# Compile bootstrap code
echo 'org 0x7c00' > .bootstrap.asm
cat bootstrap.asm >> .bootstrap.asm
fasm .bootstrap.asm bootstrap.bin >/dev/null
if [ $? -ne 0 ]; then
	echo "Failed to compile bootstrap code" 1>&2
	exit 1
fi

# Check the size of it
size=$(stat -c '%s' bootstrap.bin)
maxsize=437
if [ $size -ge $maxsize ]; then
	echo "Bootstrap is too large!" 1>&2
	exit 1
fi

cat <<END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Automatically generated bootloader
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Loaded by BIOS as 0x7c00
org 0x7c00

; Automatically compiled bootstrap code
file 'bootstrap.bin'

; Unique disk ID
`offset 0x1b4` ; Offset 0x1b4
disk_id:
	DB "OSTestDisk"

; MBR Partition table
`offset 0x1be` ; Offset 0x1be
MBR_partition_table:

; First partition table entry
PT0:
	DB 0x80 ; Active
	DB 0x00 ; Starting head
	DB 0x01 ; Starting sector
	DB 0x00 ; Starting cylinder
	DB 0x0c ; System ID (0x06 is FAT16)
	DB $PARTITION_END_HEAD ; Ending head
	DB $PARTITION_END_SECTOR ; Ending sector
	DB $PARTITION_END_CYLINDER ; Ending cylinder
	DD 0x00000001 ; LBA of first sector
	DD $PARTITION_SECTORS ; Sectors in partition

; Boot signature
`offset 510`
DW 0xAA55

END
