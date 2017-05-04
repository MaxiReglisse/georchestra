#!/bin/bash
set -e

if [ "$USER_PASS" ]; then
    echo geoserver:"$USER_PASS" |chpasswd
fi

echo "Updating /etc/ssl/certs and ca-certificates.crt"
/usr/sbin/update-ca-certificates

# start openssh server
exec /usr/sbin/sshd -D

