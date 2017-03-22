FROM panubo/cron

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# environment variables
ENV GEO_USER_PASS  georchestra-ouvert

# install some packages
RUN apt-get update && \
    apt-get install -y python

# install other packages
RUN apt-get install -y davfs2 fuse ca-certificates

RUN apt-get install -y python-dev python-pip rsync curl libxml2-utils gdal-bin postgis

RUN pip install owslib

# add user data
RUN groupadd --gid 991 geosync

RUN useradd -ms /bin/bash --home /home/geosync_user \
            -p $(echo "print crypt("${GEO_USER_PASS:-password}", "salt")" | perl) \
            --uid 996 --gid 991 geosync_user

RUN chown -R geosync_user:geosync /home/geosync_user
RUN adduser geosync_user crontab

# add geosync source code
RUN mkdir /geosync

RUN mkdir /var/log/geosync
RUN chown geosync_user:geosync  /var/log/geosync

# configure webdav
RUN chmod u+s /sbin/mount.davfs
RUN perl -p -i -e "s/#\s*use_locks\s*1/use_locks 0/" /etc/davfs2/davfs2.conf
RUN adduser geosync_user davfs2
RUN echo "https://owncloud-mshe.univ-fcomte.fr/owncloud/remote.php/webdav /home/geosync_user/owncloud davfs rw,user,noauto 0 0" >> /etc/fstab

# entrypoint
COPY entry.sh /

ENTRYPOINT ["/entry.sh"]

# several processes
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]

