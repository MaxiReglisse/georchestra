# How to run geOrchestra on Docker

## 3 easy steps

**First step**

Download the `docker-compose.yml` file and its complementary file:
```
wget https://raw.githubusercontent.com/georchestra/georchestra/master/docker-compose.yml
wget https://raw.githubusercontent.com/georchestra/georchestra/master/docker-compose.override.yml
```
These files describe:
 * which images / webapps will run,
 * how they are linked together,
 * where the configuration and data volumes are

Feel free to comment out the apps you do not need.

Note: the `docker-compose.override.yml` file adds services to interact with your geOrchestra instance:
 * reverse proxy / load balancer
 * ssh / rsync services,
 * smtp, webmail.


**Second step**

Create a configuration directory on your host machine:
```
sudo mkdir /etc/georchestra
sudo chown unprivileged_user /etc/georchestra
```
Then, as `unprivileged_user`:
```
git clone -b docker-master https://github.com/georchestra/datadir.git /etc/georchestra
```

Optional, but recommended: [adjust the configuration](https://github.com/georchestra/datadir/blob/docker-master/README.md) in `/etc/georchestra` according to your needs.


**Third step**

From the directory where you downloaded the `docker-compose` files, pull / update geOrchestra docker images to their latest version with:
```
sed -i '/build:/d' docker-compose.* && docker-compose pull
```

Run geOrchestra with
```
docker-compose up
```

Edit your `/etc/hosts` file with the following:
```
127.0.1.1	georchestra.mydomain.org
```

Open [https://georchestra.mydomain.org/](https://georchestra.mydomain.org/) in your browser.

To login, use these credentials:
 * `testuser` / `testuser`
 * `testadmin` / `testadmin`

To upload data into the GeoServer data volume (`geoserver_geodata`), use rsync:
```
rsync -arv -e 'ssh -p 2222' /path/to/geodata/ geoserver@georchestra.mydomain.org:/mnt/geoserver_geodata/
```
(password is: `geoserver`)

Files uploaded into this volume will also be available to the geoserver instance in `/mnt/geoserver_geodata/`.


## Notes

The base docker composition does not include any standalone geowebcache instance, nor the atlas, downloadform, catalogapp modules. 
If you need them, you have to include a complementary docker-compose file at run-time:
```
docker-compose -f docker-compose.yml -f docker-compose.other-apps.yml up
```

In the above guide, images are pulled from docker hub, which means they've been compiled by our CI. 
In case you have to build these images by yourself, please refer to the [docker images build instructions](../docker/README.md) or simply, to build all of them at once, clone the current repository, and, from the repository root:
```
make docker-build
```
