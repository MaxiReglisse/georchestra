Construire l'image

    docker build -t "mshe/rsct_geosync" .

Lancer le conteneur, en lui donnant un nom

    docker run -d --name mshe_rsct_geosync_1 -v $(pwd)/crontab/rsct_geosync:/crontab -e TZ=Europe/Paris mshe/rsct_geosync

Lancer le conteneur en lui permettant de charger le module fuse de l'hôte

    docker run -d --name mshe_rsct_geosync_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse -v $(pwd)/crontab/rsct_geosync:/crontab -e TZ=Europe/Paris mshe/rsct_geosync

La meme chose, mais avec un partage de données
    docker run -d --name mshe_rsct_geosync_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse -v $(pwd)/crontab/rsct_geosync:/crontab -v /home/rsct_geosync:/home/geo_user -e TZ=Europe/Paris mshe/rsct_geosync

    docker run -d --name mshe_rsct_geosync_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse -v $(pwd)/crontab/rsct_geosync:/crontab -v /home/rsct_geosync:/home/geo_user -v /home/geosync/bin:/geosync -e TZ=Europe/Paris mshe/rsct_geosync

Lancer le conteneur en lui positionnant un serveru SMTP

    docker run --rm -t -i -v $(pwd)/crontab/rsct_geosync:/crontab -e TZ=Europe/Paris -e SMTP_HOST=smtp.univ-fcomte.fr mshe/rsct_geosync

Se connecter sur le conteneur

    docker exec -it mshe_rsct_geosync_1 bash

Arrêter le conteneur

    docker rm -f mshe_rsct_geosync_1

