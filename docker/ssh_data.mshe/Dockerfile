FROM debian:jessie

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# environment variables
ENV GEOSERVER_PASS  geoserver

# install some packages
RUN apt-get update && \
    apt-get install -y openssh-server \
                       ca-certificates \
                       python python-dev python-pip libxml2-utils \
                       gdal-bin postgis

# install owslib
RUN pip install owslib

# add geoserver user
RUN groupadd --gid 999 geoserver
RUN useradd -ms /bin/bash --home /home/geoserver \
            -p $(echo "print crypt("${GEOSERVER_PASS:-geoserver}", "salt")" | perl) \
            --uid 999 --gid 999 geoserver

RUN mkdir /home/geoserver/data
RUN chown -R 999:999 /home/geoserver/data

# add geosync source code
ADD geosync /usr/local/geosync

# declare a volume
VOLUME /usr/local/geosync

# add start.sh
ADD start.sh /root/
RUN chmod +x /root/start.sh

RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

EXPOSE 22

CMD /root/start.sh

