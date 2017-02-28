#
# Dockerfile for the geOrchestra openldap service
# with saslauth authentification and Active Directory
#

FROM dinkel/openldap

RUN apt-get update && \
    apt-get install -y ldap-utils

RUN echo Europe/Paris | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# environment variables
ENV NAME_SERVER              194.57.91.200
ENV SLAPD_PASSWORD           secret
#ENV SLAPD_DOMAIN             georchestra.univ-fcomte.fr
ENV SLAPD_DOMAIN             georchestra.org
#ENV SLAPD_DC_STRING          dc=georchestra,dc=univ-fcomte,dc=fr
ENV SLAPD_DC_STRING          dc=georchestra,dc=org
#ENV AD_PASSWORD              ad_secret
ENV AD_PASSWORD              SeaSex&S1
ENV AD_DOMAIN                umrthema.univ-fcomte.fr
ENV AD_DC_STRING             dc=umrthema,dc=univ-fcomte,dc=fr
ENV AD_SERVER                thema-serv3.umrthema.univ-fcomte.fr
ENV SLAPD_ADDITIONAL_MODULES groupofmembers

# install some packages
RUN apt-get install -y python
RUN apt-get install -y python-apt
RUN apt-get install -y python-ldap
RUN apt-get install -y cron
RUN apt-get install -y sasl2-bin
RUN rm -rf /var/lib/apt/lists/*

# add ldif files which will be integrated by docker-entrypoint.d
USER openldap
ADD groupofmembers.ldif /etc/ldap.dist/modules/
ADD docker/indexes.ldif /tmp/
ADD memberof.ldif /tmp/
ADD georchestra.ldif /tmp/

# add scripts in docker-entrypoint.d
USER root
RUN mkdir /docker-entrypoint.d
ADD docker/docker-entrypoint.d/* /docker-entrypoint.d/
ADD docker/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.d/*

# add ldif files which will be integrated by docker-entrypoint.d
RUN mkdir                 /tmp/LDAP
ADD cn-config.ldif        /tmp/LDAP/cn-config.ldif
ADD open-user.ldif        /tmp/LDAP/open-user.ldif
ADD rsct-user.ldif        /tmp/LDAP/rsct-user.ldif
ADD open-user-groups.ldif /tmp/LDAP/open-user-groups.ldif
ADD rsct-user-groups.ldif /tmp/LDAP/rsct-user-groups.ldif

# configure saslauth
ADD saslauthd      /etc/default/saslauthd
ADD saslauthd.conf /etc/saslauthd.conf

# add configuration files for LDAP
ADD slapd.conf     /tmp/LDAP/slapd.conf
ADD ldap.conf      /tmp/LDAP/ldap.conf

# resolv.conf for private adresses
ADD resolv.conf    /tmp/LDAP/resolv.conf

# openldap must be in sasl group
RUN adduser openldap sasl

# create a log directory for georchestra
RUN mkdir /var/log/georchestra

# root will integrate AD users in georchestra LDAP
ADD dot.ldap.conf   /root/.ldap.conf
ADD ad2ldap_sync.py /root/ad2ldap_sync.py
RUN chmod +x        /root/ad2ldap_sync.py

ADD root_crontab /var/spool/cron/crontabs/root
RUN chmod 0600   /var/spool/cron/crontabs/root

# Generate script to run at startup
ADD start.sh /root/
RUN chmod +x /root/start.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["/root/start.sh"]

