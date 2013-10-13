#!/bin/bash

###############################################################################
#
# SCRIPT TO BUILD OS
# 
# Copies the bootsector from the compiled binary to the bootsector of the 
# disk image.
#
###############################################################################

# Bootsector
dd conv=notrunc of=../test/disk.img bs=512 if=bootsector.bin
