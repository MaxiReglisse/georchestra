#!/bin/bash
set -e

if [ "$USER_PASS" ]; then
    echo geoserver:"$USER_PASS" |chpasswd
fi

echo "configuring geosync"
/root/geosync.sh

echo "starting cron"
/etc/init.d/cron start

# start openssh server
exec /usr/sbin/sshd -D

