FROM debian

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# install locales
RUN apt-get update && \
    apt-get install -y locales

# Change locale RUN apt-get update -y && apt-get install -y locales
RUN dpkg-reconfigure locales && locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG='C.UTF-8'
RUN echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LC_ALL='C.UTF-8' LANG='fr_FR.UTF-8' LANGUAGE='fr_FR.UTF-8'

# environment variables
ENV GEO_USER_PASS  georchestra-ouvert

# install some packages
RUN apt-get update && \
    apt-get install -y cron python

# install other packages
RUN apt-get install -y davfs2 fuse rsync curl ca-certificates
RUN apt-get install -y python-dev python-owslib python-lxml libxml2-utils gdal-bin postgis libsaxonb-java dbview

# install debug tools packages
RUN apt-get install -y colordiff less vim openssh-client

# create geosync group users
RUN groupadd --gid 991 geosync

# add geosync user : georchestra-ouvert
ADD georchestra-ouvert /home/georchestra-ouvert
RUN useradd -s /bin/bash \
            -p $(echo "print crypt("${GEO_USER_PASS:-password}", "salt")" | perl) \
            --uid 992 --gid 991 georchestra-ouvert
RUN rm -rf /home/georchestra-ouvert/.davfs2/cache
RUN chmod 600 /home/georchestra-ouvert/.davfs2/secrets
RUN chmod 600 /home/georchestra-ouvert/.pgpass
RUN chown -R georchestra-ouvert:geosync /home/georchestra-ouvert
RUN adduser georchestra-ouvert crontab

# add geosync user georchestra-restreint
ADD georchestra-restreint /home/georchestra-restreint
RUN useradd -s /bin/bash \
            -p $(echo "print crypt("${GEO_USER_PASS:-password}", "salt")" | perl) \
            --uid 993 --gid 991 georchestra-restreint
RUN rm -rf /home/georchestra-restreint/.davfs2/cache
RUN chmod 600 /home/georchestra-restreint/.davfs2/secrets
RUN chmod 600 /home/georchestra-restreint/.pgpass
RUN chown -R georchestra-restreint:geosync /home/georchestra-restreint
RUN adduser georchestra-restreint crontab

# configure webdav
RUN chmod u+s /sbin/mount.davfs
RUN perl -p -i -e "s/#\s*use_locks\s*1/use_locks 0/" /etc/davfs2/davfs2.conf
RUN adduser georchestra-ouvert davfs2
RUN adduser georchestra-restreint davfs2
RUN echo "https://owncloud-mshe.univ-fcomte.fr/owncloud/remote.php/webdav /home/georchestra-ouvert/owncloud davfs rw,user,noauto 0 0" >> /etc/fstab
RUN echo "https://owncloud-mshe.univ-fcomte.fr/owncloud/remote.php/webdav /home/georchestra-restreint/owncloud davfs rw,user,noauto 0 0" >> /etc/fstab

# add geosync source code
COPY geosync /usr/local/geosync

# on expose le volume /home... c'est utile/inutile ??
VOLUME /home

# entrypoint
COPY entry.sh /

ENTRYPOINT ["/entry.sh"]

# Start cron daemon in the foreground
CMD ["/usr/sbin/cron","-f"]

