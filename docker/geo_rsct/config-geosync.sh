#!/bin/bash

echo "Preparing logs dir"
mkdir /var/log/geosync
chown -R geo_user:geosync /var/log/geosync

# le serveur DNS de google, 8.8.8.8, ne résoud pas les adresses privées.
echo "Setting resolv.conf"
echo "nameserver 194.57.91.200" >> /etc/resolv.conf

# on intègre le certificat racine DigiCertCA.crt
echo "Updating /etc/ssl/certs and ca-certificates.crt"
/usr/sbin/update-ca-certificates

# on crée les espaces de travail et les entrepôts
## su geo_user -c '$HOME/bin/init_data.sh'

