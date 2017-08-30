 * a [docker composition](https://github.com/georchestra/docker/blob/master/docker-compose.yml), which pulls pre-built images from [docker hub](https://hub.docker.com/u/georchestra/), is perfect for a quick start. Provided you have a good download speed and recent machine (8Gb required), you'll be up and running within 10 minutes. Read [how to run geOrchestra on Docker](https://github.com/georchestra/docker/blob/master/README.md) here.
 * a contributed [ansible playbook](https://github.com/georchestra/ansible) allows you to spin an instance in a few minutes. This is probably the easiest way to create a small production server, since it takes care of installing the middleware, fetching the webapps and configuring them.
 * generic [debian (or yum) packages](https://packages.georchestra.org/) are perfect to create complex architectures, but you'll have to [install and configure the middleware](docs/setup.md) first.
 * you could also use the [generic wars](https://packages.georchestra.org/wars-master/) with their "[datadir](https://github.com/georchestra/datadir)", as an alternate method. The above packages provide both.
 * finally, [building from the sources](docs/build.md) is the most flexible solution, since it allows you to customize the webapps very deeply. You get custom WAR files, packages or docker images that you can [deploy](docs/deploy.md) to dev, test, or production servers. 

If you opt for the middleware setup by yourself, there are several [optimizations](docs/optimizations.md), [good practices](docs/good_practices.md) and [tutorials](docs/tutorials.md) that are worth reading. 
Note that the minimum system requirement is 2 cores and 4Gb RAM, but we recommend at least 4 cores and 8 Gb RAM for a production instance.
More RAM is of course better !

