#!/bin/bash

rsync --delete -av --exclude ".git/*"  /home/geosync/geosync /home/georchestra/georchestra/docker/cron_geosync/

