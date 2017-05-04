FROM debian

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# install some packages
RUN apt-get update && \
    apt-get install -y python

# install other packages
RUN apt-get install -y python-dev python-pip libxml2-utils gdal-bin postgis
RUN pip install owslib

# add geosync source code
ADD geosync /usr/local/

# declare a volume
VOLUME /usr/local/geosync

# entrypoint
#COPY entry.sh /

#ENTRYPOINT ["/entry.sh"]

# 
CMD ["/bin/true"]

