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

Objectifs de la séance

Creation du docker avec doliabrr 
Poursuivre la configuration de l'environnement Docker.

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

Date : 02/11/2026
Horaire : 13h00 – 16h00

Objectif de la séance :
Automatiser l’installation de Dolibarr à l’aide de Docker.

Travaux réalisés :
Lors de cette séance, nous avons travaillé sur la mise en place de l’automatisation de l’installation de Dolibarr à l’aide de conteneurs Docker.

Difficultés rencontrées :
Nous avons rencontré des difficultés pour comprendre le fonctionnement de Dolibarr, notamment concernant le processus d’importation des fichiers et leur intégration dans le logiciel.

Objectifs de la prochaine séance :
Poursuivre le développement de l’automatisation de Dolibarr, en mettant particulièrement l’accent sur l’importation des fichiers CSV et leur intégration dans l’application.

## Séance n° 6 – Automatisation de l'importation des fichiers CSV

Date :03/11/2026  
Horaires : 16h00 – 19h00

1. Travail réalisé

Durant cette  séance, nous avons travaillé sur l'automatisation complète de l'importation des fichiers CSV dans Dolibarr.

L'objectif était de permettre l'importation automatique des fichiers contenant les informations des clients et des fournisseurs, afin qu'ils soient directement intégrés et correctement répartis dans Dolibarr.

2. Difficultés rencontrées

Plusieurs problèmes techniques ont été rencontrés au cours de cette séance :

- Problème d'importation avec Docker Compose :Docker Compose indiquait que les fichiers avaient bien été importés dans Dolibarr, alors qu'ils n'étaient pas visibles sur la plateforme.
- Configuration du module Tier Tools :Nous avons rencontré des difficultés pour automatiser ce module, qui permet notamment de consulter et de gérer les fichiers CSV.
- Problème de permissions : Nous avons réussi, pendant un temps, à importer les fichiers, mais nous ne disposions pas des droits nécessaires pour y accéder et les exploiter.
- Plusieurs tentatives de correction  Nous avons dû effectuer différents essais et ajustements afin d'identifier l'origine des problèmes et de parvenir à une importation fonctionnelle.

3. Résultats obtenus

Après plusieurs tentatives et corrections, nous avons finalement réussi à automatiser l'importation des fichiers CSV contenant les données des clients et des fournisseurs.

Les données ont été correctement intégrées et réparties dans les catégories correspondantes de Dolibarr.

L'importation fonctionne désormais comme prévu.

 4. Travail restant à effectuer

- Mettre en place une sauvegarde (backup) du projet afin de sécuriser les données.
- Vérifier le bon fonctionnement global du processus d'importation.

## Séance n° 7 – Finalisation du projet 

Date : 05/11
Horaires : 13h – 16h

Durant cette séance, nous avons finalisé le projet en mettant une backup permettant de gérer les situations dans lesquelles les données sont vides.

Nous avons également effectué plusieurs vérifications afin de nous assurer du bon fonctionnement de l'ensemble du projet et de corriger les éventuels problèmes rencontrés.

Enfin, nous avons terminé la documentation du projet avec :

La création du fichier README, présentant son fonctionnement et les instructions d'utilisation.
L'ajout des sources utilisées au cours du développement.
Cette séance a permis de finaliser le développement du projet, de vérifier sa fiabilité et de préparer sa livraison.









