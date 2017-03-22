#!/usr/bin/env bash

# Fail on errors
set -e
[ "${DEBUG:-false}" == 'true' ] && set -x

# Defaults
: ${HOSTNAME:=$(hostname)}
: ${EMAIL_FROM:='cron'}
: ${EMAIL_TO:='cron'}
: ${SMTP_HOST:='localhost'}
: ${SMTP_PORT:='25'}
: ${SMTP_USER:=''}
: ${SMTP_PASS:=''}

# Config checks
[ ! -f "/crontab" ] && echo "Error: crontab must be mounted at /crontab" && exit 128 || true

# Create the crontab
crontab -u cron /crontab

# Configure Mail Sending
cat > /etc/ssmtp/ssmtp.conf << EOF
root=${EMAIL_TO}
mailhub=${SMTP_HOST}:${SMTP_PORT}
hostname=${HOSTNAME}
EOF

# if username / pass set
if [ -n "${SMTP_USER}" ] && [ -n "${SMTP_PASS}" ]; then
    {
        echo "UseSTARTTLS=Yes"
        echo "AuthUser=${SMTP_USER}"
        echo "AuthPass=${SMTP_PASS}"
    } >> /etc/ssmtp/ssmtp.conf
fi

cat > /etc/ssmtp/revaliases << EOF
root:${EMAIL_FROM}:${SMTP_HOST}:${SMTP_PORT}
cron:${EMAIL_FROM}:${SMTP_HOST}:${SMTP_PORT}
EOF

# Ernest
echo "Updating /etc/ssl/certs and ca-certificates.crt"
/usr/sbin/update-ca-certificates

cp /crontab /var/spool/cron/crontabs/geosync_user
chmod 0600  /var/spool/cron/crontabs/geosync_user
chown geosync_user:geosync /var/spool/cron/crontabs/geosync_user

su geosync_user -c '/geosync/init_data.sh'

# Start supervisord
exec $@
