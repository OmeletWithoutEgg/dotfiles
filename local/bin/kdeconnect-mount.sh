#!/bin/bash

set -e

function echoerr() { echo "$@" 1>&2; }

echoerr "kdeconnect-cli listing devices..."

function choose() {
  rofi -dmenu -sync "$@"
}

function query_dbus() {
  qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$PHONE_ID"/sftp "$@"
}

PHONE_ID=$(kdeconnect-cli --list-devices --id-only | choose -p phone_id)
echoerr "phone_id=$PHONE_ID"

MOUNTED=$(query_dbus isMounted)
echoerr "MOUNTED=$MOUNTED"

if [[ "$MOUNTED" == "false" ]]; then
  echoerr "mounting..."
  query_dbus mountAndWait # >/dev/null
  echoerr "mount done!"
fi

MOUNT_POINT=$(query_dbus getDirectories | choose -p mount_point | cut -f 1 -d ':')
echo $MOUNT_POINT
