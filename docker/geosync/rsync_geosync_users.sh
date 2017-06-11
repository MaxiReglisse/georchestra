#!/bin/bash

rsync --delete -av --exclude .viminfo --exclude .bash_history --exclude .davfs2/cache --exclude .davfs2/certs /home/georchestra-ouvert    /home/georchestra/georchestra/docker/geosync/
rsync --delete -av --exclude .viminfo --exclude .bash_history --exclude .davfs2/cache --exclude .davfs2/certs /home/georchestra-restreint /home/georchestra/georchestra/docker/geosync/

