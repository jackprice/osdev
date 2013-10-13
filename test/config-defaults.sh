#!/bin/bash

###############################################################################
#
# DEFAULT CONFIGURATION FILE 
#
# Do not edit this, edit config.sh instead.
# 
###############################################################################

# Disk geometry
DISK_CYLINDERS=980
DISK_HEADS=5
DISK_SECTORS_PER_TRACK=17
DISK_BYTES_PER_SECTOR=512

# ROM (BIOS) image
ROMIMAGE="file=/usr/share/bochs/BIOS-bochs-latest"

# ROM (VGA) image
VGAIMAGE="file=/usr/share/vgabios/vgabios.bin"

# How much memory to give our test machine
MEMORY=64

# Processor
IPS=2
