Construire l'image

    docker build -t "mshe/geosync" .

Lancer le conteneur, en lui donnant le nom mshe_geosync_1

    docker run -d --name mshe_geosync_1 mshe/geosync

Se connecter sur / Arrêter le conteneur

    docker exec -it mshe_geosync_1 bash
    docker rm -f mshe_geosync_1


