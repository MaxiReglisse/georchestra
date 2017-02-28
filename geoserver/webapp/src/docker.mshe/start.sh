#!/bin/bash

echo "creating geoserer directories"
/root/geosync.sh

echo "starting java geoserver process"
sh -c exec java -Djava.io.tmpdir=/tmp/jetty \
-Dgeofence.dir=/etc/georchestra/geoserver/geofence \
-DGEOSERVER_DATA_DIR=/mnt/geoserver_datadir \
-DGEOWEBCACHE_CACHE_DIR=/mnt/geoserver_tiles \
-DENABLE_JSONP=true \
-Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2 \
-Dorg.geotools.image.reduceWarpAffine=false \
-Xms$XMS -Xmx$XMX \
-XX:SoftRefLRUPolicyMSPerMB=36000 \
-XX:+UseParallelGC \
-XX:-UsePerfData \
${JAVA_OPTIONS} \
-jar /usr/local/jetty/start.jar

