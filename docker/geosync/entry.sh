#!/usr/bin/env bash

# Fail on errors
set -e

echo "Updating /etc/ssl/certs and ca-certificates.crt"
/usr/sbin/update-ca-certificates

# test if already initialized
if [ ! -d /var/log/georchestra-ouvert ]; then

    echo "Crontab for georchestra-ouvert"
    cp /home/georchestra-ouvert/crontab/georchestra-ouvert /var/spool/cron/crontabs/georchestra-ouvert
    chmod 0600  /var/spool/cron/crontabs/georchestra-ouvert
    chown georchestra-ouvert:geosync /var/spool/cron/crontabs/georchestra-ouvert

    echo "Crontab for georchestra-restreint"
    cp /home/georchestra-restreint/crontab/georchestra-restreint /var/spool/cron/crontabs/georchestra-restreint
    chmod 0600  /var/spool/cron/crontabs/georchestra-restreint
    chown georchestra-restreint:geosync /var/spool/cron/crontabs/georchestra-restreint

    echo "Log directory for geosync"
    mkdir /var/log/georchestra-ouvert
    mkdir /var/log/georchestra-restreint
    chown -R georchestra-ouvert:geosync    /var/log/georchestra-ouvert
    chown -R georchestra-restreint:geosync /var/log/georchestra-restreint
    ln -s /var/log/georchestra-ouvert    /home/georchestra-ouvert/log
    ln -s /var/log/georchestra-restreint /home/georchestra-restreint/log

    echo "setting server url in .geosync.conf"
    perl -p -i -e "s|SERVER_URL|$SERVER_URL|" /home/georchestra-ouvert/.geosync.conf
    perl -p -i -e "s|SERVER_URL|$SERVER_URL|" /home/georchestra-restreint/.geosync.conf

    echo "Initializing geosync"
    su georchestra-ouvert    -c '/usr/local/geosync/bin/init_data.sh'
    su georchestra-restreint -c '/usr/local/geosync/bin/init_data.sh'

else
    echo "geosync already initialized !"
fi

exec $@

