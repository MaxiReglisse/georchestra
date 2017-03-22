FROM debian:jessie

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN echo Europe/Paris | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# environment variables
ENV GEOSERVER_PASS  geoserver
ENV GEO_USER_PASS  georchestra-restreint

# install some packages
RUN apt-get update && \
    apt-get install -y openssh-server \
                       python \
                       cron

# install other packages
RUN apt-get install -y davfs2 fuse ca-certificates

RUN apt-get install -y python-dev python-pip rsync curl libxml2-utils gdal-bin postgis

RUN pip install owslib

# add data
RUN groupadd --gid 999 geoserver
RUN useradd -ms /bin/bash --home /home/geoserver \
            -p $(echo "print crypt("${GEOSERVER_PASS:-geoserver}", "salt")" | perl) \
            --uid 999 --gid 999 geoserver

RUN mkdir /home/geoserver/data
RUN chown -R 999:999 /home/geoserver/data

RUN groupadd --gid 991 geosync

RUN useradd -ms /bin/bash --home /home/geo_user \
            -p $(echo "print crypt("${GEO_USER_PASS:-password}", "salt")" | perl) \
            --uid 993 --gid 991 geo_user

RUN mkdir /home/geo_user/owncloud
RUN chown -R geo_user:geosync /home/geo_user

RUN chmod u+s /sbin/mount.davfs
RUN perl -p -i -e "s/#\s*use_locks\s*1/use_locks 0/" /etc/davfs2/davfs2.conf
RUN adduser geo_user davfs2
RUN echo "https://owncloud-mshe.univ-fcomte.fr/owncloud/remote.php/webdav /home/geo_user/owncloud davfs rw,user,noauto 0 0" >> /etc/fstab

#ADD crontab /var/spool/cron/crontabs/geo_user
#RUN chmod 0600        /var/spool/cron/crontabs/geo_user
#RUN chown geo_user:geosync /var/spool/cron/crontabs/geo_user

#ADD config-geosync.sh /root/
#RUN chmod +x /root/config-geosync.sh

#RUN mkdir /var/run/sshd
#RUN chmod 0755 /var/run/sshd

#ADD start.sh /root/
#RUN chmod +x /root/start.sh

#EXPOSE 22

#CMD /root/start.sh

#CMD ["/bin/true"]
#CMD ["/bin/bash"]
#CMD ping localhost
CMD ["crond","f"]

