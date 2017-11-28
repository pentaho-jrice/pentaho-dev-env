#!/bin/sh
set -x

SHARE_NAME=$1
MOUNT_FOLER=$2


sudo mount -t vboxsf $SHARE_NAME $MOUNT_FOLER
