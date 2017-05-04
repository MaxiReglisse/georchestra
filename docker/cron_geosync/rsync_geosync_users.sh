#!/bin/bash

rsync --delete -av --exclude .viminfo --exclude .bash* --exclude .davfs2/cache --exclude .davfs2/certs /home/georchestra-ouvert    /home/georchestra/georchestra/docker/cron_geosync/
rsync --delete -av --exclude .viminfo --exclude .bash* --exclude .davfs2/cache --exclude .davfs2/certs /home/georchestra-restreint /home/georchestra/georchestra/docker/cron_geosync/

