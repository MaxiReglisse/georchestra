#!/bin/bash

# script de déploiement des sources de geosync entre /$GEOSYNC/bin
#                                                 et /$GEORCHESTRA/georchestra/docker/ssh_data.mshe
# pour les deux utilisateurs georchestra-ouvert et georchestra-restreint

GEOSYNC=/home/geosync
GEORCHESTRA=/home/georchestra

rsync --delete -av --exclude ".git/*" --exclude ".davfs2/cache/*" /$GEOSYNC/bin /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-ouvert
cp /$GEOSYNC/bin/.geosync-open.conf /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-ouvert/bin/.geosync.conf
cp /$GEOSYNC/.davfs2/secrets-open /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-ouvert/.davfs2/secrets
chmod 600 /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-ouvert/.davfs2/secrets
cp /$GEOSYNC/.pgpass-open /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-ouvert/.pgpass

rsync --delete -av --exclude ".git/*" --exclude ".davfs2/cache/*" /$GEOSYNC/bin /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-restreint
cp /$GEOSYNC/bin/.geosync-rsct.conf /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-restreint/bin/.geosync.conf
cp /$GEOSYNC/.davfs2/secrets-rsct /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-restreint/.davfs2/secrets
chmod 600 /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-restreint/.davfs2/secrets
cp /$GEOSYNC/.pgpass-rsct /$GEORCHESTRA/georchestra/docker/ssh_data.mshe/georchestra-restreint/.pgpass

