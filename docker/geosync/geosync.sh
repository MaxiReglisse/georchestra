#!/bin/bash

echo "Preparing logs dir"
mkdir /var/log/geosync-open
chown -R georchestra-ouvert:georchestra /var/log/geosync-open

mkdir /var/log/geosync-rsct
chown -R georchestra-restreint:georchestra /var/log/geosync-rsct

# le serveur DNS de google, 8.8.8.8, ne résoud pas les adresses privées.
echo "Setting resolv.conf"
echo "nameserver 194.57.91.200" >> /etc/resolv.conf

# on intègre le certificat racine DigiCertCA.crt
echo "Updating /etc/ssl/certs and ca-certificates.crt"
/usr/sbin/update-ca-certificates

# on positionne les variables d'environnement
echo "Setting environment variables"
perl -p -i -e "s|SERVER_URL|$SERVER_URL|" /home/georchestra-ouvert/bin/.geosync.conf
perl -p -i -e "s|SERVER_URL|$SERVER_URL|" /home/georchestra-restreint/bin/.geosync.conf
perl -p -i -e "s|OPEN_USER_DAVPASS|$OPEN_USER_DAVPASS|" /home/georchestra-ouvert/bin/.geosync.conf
perl -p -i -e "s|RSCT_USER_DAVPASS|$RSCT_USER_DAVPASS|" /home/georchestra-restreint/bin/.geosync.conf
perl -p -i -e "s|OPEN_USER_DAVPASS|$OPEN_USER_DAVPASS|" /home/georchestra-ouvert/.davfs2/secrets
perl -p -i -e "s|RSCT_USER_DAVPASS|$RSCT_USER_DAVPASS|" /home/georchestra-restreint/.davfs2/secrets
perl -p -i -e "s|OCL_URL|$OCL_URL|" /home/georchestra-ouvert/.davfs2/secrets
perl -p -i -e "s|OCL_URL|$OCL_URL|" /home/georchestra-restreint/.davfs2/secrets

# on positionne le service 
perl -p -i -e "s|dbhost=localhost|dbhost=database|" /home/georchestra-ouvert/.pgpass
perl -p -i -e "s|dbhost=localhost|dbhost=database|" /home/georchestra-restreint/.pgpass

# on crée les espaces de travail et les entrepôts
su georchestra-ouvert    -c '$HOME/bin/init_data.sh'
su georchestra-restreint -c '$HOME/bin/init_data.sh'

