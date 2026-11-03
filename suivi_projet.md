# Journal de bord

(remplacer les items en majuscule)

* sae-dolibarr
* Alexandre
* Ilyes Kebairi
* 5/10/2026


## Séance n° 1
Date : 05/10/2026
Horaires : 16h00 – 17h30

Objectifs de la séance
Préparer l'environnement de travail pour la réalisation du projet.
Installer Debian sur la machine virtuelle proxmox

Travail réalisé
Lors de cette première séance, nous avons procédé à l'installation de Debian sur une machine virtuelle. 
Nous avons également préparé notre environnement afin de pouvoir commencer les installations lors des prochaines séances.

Difficultés rencontrées
Aucune difficulté particulière rencontrée durant cette séance. Mise à part une légère longue installation de Debian 

Bilan
L'installation de Debian s'est déroulée correctement. L'environnement de travail est prêt pour la suite du projet.

## Séance n° 2

Date : 06/10/2026
Horaires : 08h30 – 10h00

Objectifs de la séance
Installer et configurer Docker.
Mettre en place les services nécessaires au fonctionnement de Dolibarr.
Découvrir le fonctionnement de Dolibarr.
Travail réalisé

On a installé Docker pour pouvoir utiliser des conteneurs pour déployer les différents services du projet, nous avons aussi installé PHP et Apache qui sont nécessaires au fonctionnement de l'application web Dolibarr. 

En parallèle, nous avons également effectué une installation classique de Dolibarr directement sur la machine virtuelle, sans utiliser Docker. Cette installation avait pour objectif de mieux comprendre le fonctionnement de l'application, son interface et ses différentes fonctionnalités avant de passer à une installation entièrement automatisée avec Docker.

Difficultés rencontrées
Nous avons rencontré quelques conflits lors de la configuration du fichier YAML utilisé par Docker Compose, notamment au niveau des mots de passe et des variables de configuration.

Travail à poursuivre
Vérifier le bon fonctionnement des conteneurs Docker.
Continuer la découverte des fonctionnalités de Dolibarr en important les fichier csv 
Commencer à réfléchir à l'automatisation de son installation.

## Séance n° 3

Séance n° 3 – Configuration et résolution des problèmes
Date : 06/10/2026
Horaires : 16h00 – 17h30

Objectifs de la séance
Poursuivre la configuration de l'environnement Docker.
Identifier et résoudre les problèmes rencontrés lors de la séance précédente.

## Séance n° 4

Date : 06/10/2026
Horaires : 13h00 – 16h00

Objectifs de la séance
Automatiser l'installation de Dolibarr.
Commencer l'importation des données clients et fournisseurs.

Travail réalisé

Nous avons créé un fichier .env. Ce fichier permet de stocker les informations sensibles, comme les mots de passe et les paramètres de connexion, séparément du fichier Docker Compose. Cela évite notamment d'inscrire directement les mots de passe en clair dans le fichier YAML.

Nous avons ensuite procédé à l'importation du fichier client.csv dans Dolibarr afin d'intégrer les informations relatives aux clients dans l'application.

Cette étape nous a permis de découvrir le fonctionnement du module d'importation de Dolibarr et de comprendre comment les données présentes dans un fichier CSV doivent être organisées pour être correctement reconnues par l'application.

Difficultés rencontrées
La principale difficulté rencontrée concerne la compréhension du système d'importation de Dolibarr.

## Séance n° 5

* 06/10/2026 de 13h-16h
* objectif automatiser installation de dolibarr avec les docker
* 
* difficulté comprendre le fonctionnement de dolibarr pour l'importation du fichier
* 
* autmatisatio des Importeation des fichiers fournisseur 
* Difficultés rencontrées




