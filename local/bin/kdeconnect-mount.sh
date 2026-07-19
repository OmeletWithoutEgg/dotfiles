#!/bin/bash

set -e

function echoerr() { echo "$@" 1>&2; }

function choose() {
  if [[ "wayland" == "$XDG_SESSION_TYPE" ]]; then
    GTK_IM_MODULE="" wofi --dmenu "$@"
  else
    rofi -dmenu -sync "$@"
  fi
}

function query_dbus() {
  qdbus6 org.kde.kdeconnect /modules/kdeconnect/devices/"$PHONE_ID"/sftp "$@"
}

function main() {
  echoerr "kdeconnect-cli listing devices..."
  PHONE_ID=$(choose -p phone_id <<<$(kdeconnect-cli --list-devices --id-name-only) | cut -f 1 -d ' ')
  echoerr "phone_id=$PHONE_ID"

  MOUNTED=$(query_dbus isMounted)
  echoerr "MOUNTED=$MOUNTED"

  if [[ "$MOUNTED" == "false" ]]; then
    echoerr "mounting..."
    query_dbus mountAndWait # >/dev/null
    echoerr "mount done!"
  fi

  MOUNT_POINT=$(query_dbus getDirectories | choose -p mount_point | cut -f 1 -d ':')
  echo "$MOUNT_POINT"
}

main
