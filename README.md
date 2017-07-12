# ge@sync / geOrchestra

ge@sync permet la publication automatique sur geOrchestra de données déposées et partagées sur OwnCloud.

georchestra-geosync est une branche du projet geOrchestra, dans laquelle 3 conteneurs Docker sont modifiés :

- ldap.mshe

Intégration des données d'un annuaire Active Directory pour gérer les utilisateurs, utilisation du démon saslauth.

- postgresql.mshe

Création des bases de données nécessaires à ge@sync ; création de l'utilisateur
modification de pg_hba.conf pour permettre les accès uax bases de données depuis les réseaux locaux

- geoserver/webapp/src/docker.mshe

Création des espaces de travail des utilisateurs georchestra-ouvert et georchestra-restreint

## Création d'un nouveau conteneur : geosync

- docker/geosync

Création des home des utilisateurs virtuels georchestra-ouvert et georchestra-restreints, dans lesquels seront synchronisées les données en provenance de OwnCloud.

Le code de geosync est installé dans /usr/local/geosync

Les logs sont accessibles depuis les répertoires des utilisateurs virtuels.


