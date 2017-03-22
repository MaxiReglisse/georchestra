Construire l'image

    docker build -t "mshe/open_geosync" .

Lancer le conteneur, en lui donnant un nom

    docker run -d --name mshe_open_geosync_1 -v $(pwd)/crontab/open_geosync:/crontab -e TZ=Europe/Paris mshe/open_geosync

Lancer le conteneur en lui permettant de charger le module fuse de l'hôte

    docker run -d --name mshe_open_geosync_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse -v $(pwd)/crontab/open_geosync:/crontab -e TZ=Europe/Paris mshe/open_geosync

La meme chose, mais avec un partage de données
    docker run -d --name mshe_open_geosync_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse -v $(pwd)/crontab/open_geosync:/crontab -v /home/open_geosync:/home/geo_user -e TZ=Europe/Paris mshe/open_geosync

    docker run -d --name mshe_open_geosync_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse -v $(pwd)/crontab/open_geosync:/crontab -v /home/open_geosync:/home/geo_user -v /home/geosync/bin:/geosync -e TZ=Europe/Paris mshe/open_geosync

Lancer le conteneur en lui positionnant un serveru SMTP

    docker run --rm -t -i -v $(pwd)/crontab/open_geosync:/crontab -e TZ=Europe/Paris -e SMTP_HOST=smtp.univ-fcomte.fr mshe/open_geosync

Se connecter sur le conteneur

    docker exec -it mshe_open_geosync_1 bash

Arrêter le conteneur

    docker rm -f mshe_open_geosync_1

