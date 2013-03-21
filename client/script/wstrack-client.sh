#!/bin/bash

# get directory of this script
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# command line argument 1
# status (required) - login or logout
STATUS="$1"
if [ -z "$STATUS" ]; then
  echo "Status is required (login or logout)"
  exit 1
fi

# command line argument 2
# environment (optional) - server to contact (prod, stage, dev, or local) 
ENVIRONMENT=local
if [ -n "$2" ]; then
  ENVIRONMENT="$2"
fi

# command line argument 3
# debug (optional) - display debugging information
DEBUG="false"
if [ -n "$3" ]; then
  DEBUG="$3"
fi

# gather information about this host
COMPUTERNAME=$(/usr/sbin/scutil --get ComputerName)
OSNAME=$(/usr/bin/sw_vers -productName)
OSVER=$(/usr/bin/sw_vers -productVersion)

# send information to workstation tracking server
java \
  -Dwstrack.debug="$DEBUG" \
  -Dwstrack.env="$ENVIRONMENT" \
  -Dwstrack.computerName="$COMPUTERNAME" \
  -Dwstrack.status="$STATUS" \
  -Dwstrack.username="$USER" \
  -Dwstrack.os="$OSNAME $OSVER" \
  -jar "$DIR"/wstrack-client.jar
