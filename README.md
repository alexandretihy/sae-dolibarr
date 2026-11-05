# sae-dolibarr

LE PROJET

Installer Dolibarr avec Docker, et y importer automatiquement des clients et fournisseurs a partir de fichiers CSV. 

COMMENT CA FONCTIONNE

Le projet lance trois conteneurs avec docker-compose.yml :

- mariadb : la base de donnees de Dolibarr.
- dolibarr : l'application web (Apache + PHP), accessible sur le port 8080.
- importer : attend que Dolibarr ait cree ses tables, importe data/clients.csv et data/fournisseurs.csv dans la base, puis s'arrete.


INSTALLATION

1. Initialisation : Il faut initialiser un fichier .env pour les mots de passe
   
    pluma .env

MYSQL_PASSWORD et DOLI_DB_PASSWORD doivent avoir la meme valeur. Ne jamais pousser le fichier .env sur Git.

2. On lance :

    chmod +x install.sh import_csv.sh docker/importer/entrypoint.sh
    ./install.sh

Le script demarre les conteneurs, attend Dolibarr (2 a 5 minutes au premier lancement), attend la fin de l'import puis affiche l'adresse. ON ne doit pas interrompre le lancement des conteneurs : pour suivre l'avancement, on peut utiliser  un second terminal.

3. Se connecter : http://IP_DE_LA_MACHINE:8080, avec DOLI_ADMIN_LOGIN et DOLI_ADMIN_PASSWORD du fichier .env. Le menu Tiers doit afficher 50 tiers (30 clients, 20 fournisseurs) initialement.


IMPORT DES CSV

Il se fait automatiquement à l'installation.

BACKUP DES DONNÉES

COMMANDES UTILES

    docker compose ps -a                 # etat des conteneurs
    docker compose logs -f dolibarr      # logs de Dolibarr (Ctrl+C pour quitter les logs)
    docker compose logs importer         # resultat de l'import
    curl -I http://localhost:8080        # le site repond ? (200 ou 302 = OK)
    docker compose config                # valider le fichier compose
    docker compose down                  # arreter en gardant les donnees
    docker compose down -v               # tout supprimer, repartir de zero
