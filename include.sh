#!/bin/bash

###############################################################################
#
# INCLUDE EVERYTHING RELEVANT
#
###############################################################################

TOPLEVEL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BUILD=${TOPLEVEL}/build
TEST=${TOPLEVEL}/test
SOURCE=${TOPLEVEL}/src

. ${TEST}/include-config.sh

USER=$(whoami)
GID=$(getent group $(whoami) | grep -Po "(?<=:)[0-9]*(?=:)")
