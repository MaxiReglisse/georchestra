geosync-docker permet de déployer ge@sync avec docker.
plus d'info sur ge@sync ici : https://github.com/MSHE-Ledoux/geosync

on s'intéresse pour l'instant au conteneur georchestra/ldap, pour lui ajouter l'authentification saslauth.

Construire l'image

    docker build -t "mshe/ldap" .

Lancer le conteneur, en lui donnant un nom

    docker run -d --name mshe_ldap_1 mshe/ldap

Se connecter sur le conteneur

    docker exec -it mshe_ldap_1 bash

Arrêter le conteneur

    docker rm -f mshe_ldap_1

