Construire l'image

    docker build -t "mshe/rsct_user" .

Lancer le conteneur, en lui donnant le nom mshe_rsct_user_1

    docker run -d --name mshe_rsct_user_1 mshe/rsct_user

Se connecter sur / Arrêter le conteneur

    docker exec -it mshe_ssh_data_1 bash
    docker rm -f mshe_ssh_data_1





Utiliser un conteneur de données :

    docker create --volume /home/georchestra-ouvert --name geosync_home mshe/ssh_data /bin/true
    docker run -d --volumes-from geosync_home --name mshe_ssh_data_home_1 mshe/ssh_data

Partager le code source avec vim. c'est insatisfaisant car python-vim organise les données dans /src

    docker run -it --rm --volumes-from geosync_home --workdir /home/georchestra-ouvert fedeg/python-vim:latest

Utiliser un conteneur nommé, qui nous permettra d'utiliser un répertoire /src pour naviguer avec python-vim
voir https://www.metal3d.org/ticket/docker-arretez-d-utiliser-des-conteneurs-data-only

    docker volume create --name geosync_home
    docker build -t "mshe/ssh_data" .
    docker run -d -v geosync_home:/home --name mshe_ssh_data_home_1 mshe/ssh_data
    docker run --rm -it -v geosync_home:/src fedeg/python-vim:latest

Pour activer le webdav, ne pas oublier les options permettant d'activer fuse dans le noyau 

    docker run -d -v geosync_home:/home --name mshe_ssh_data_home_1 --privileged --cap-add=ALL -v /dev:/dev -v /lib/modules:/lib/modules mshe/ssh_data
    docker run -d -v geosync_home:/home --name mshe_ssh_data_home_1 --privileged --cap-add=SYS_ADMIN -v /dev/fuse:/dev/fuse mshe/ssh_data

