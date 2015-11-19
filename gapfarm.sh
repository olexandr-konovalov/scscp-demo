#!/bin/sh
#
# This scripts starts a farm 64 GAP SCSCP servers
# listening at localhost to ports from 26101 to 26164.
# Each of the servers is configured in gapd.sh script.
# This script is as plain as possible to run everywhere.
#
./gapd.sh -p 26101
./gapd.sh -p 26102


