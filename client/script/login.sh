#!/bin/sh
if [ -z "$USER" ]; then
  if [ -n "$1" ]; then
    export USER="$1"
  fi
fi
cd /wstrack
./wstrack-client.sh login
exit 0
