#!/bin/bash

###############################################################################
#
# TEST CONFIGURATION FILE
# 
# Do not edit this, edit config.sh instead.
#
###############################################################################

# Include config defaults
. ${TEST}/config-defaults.sh

# Include the config file
. ${TEST}/config.sh

# Calculate disk geometry and check sanity
DISK_SECTORS=$((DISK_CYLINDERS * DISK_HEADS * DISK_SECTORS_PER_TRACK))
if [ "$DISK_SECTORS" -lt "16" ]; then
    echo "DISK_SECTORS is a nonsensical value: $DISK_SECTORS" 1>&2
    return 1
fi

# Bochs overrides
if [ -z "$BOCHS" ]; then
    BOCHS=`command -v bochs`
    if [ $? -ne 0 ]; then
        echo "Could not find Bochs" 1>&2
	return 1
    fi
fi
