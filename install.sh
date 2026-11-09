#!/usr/bin/env bash
# -e (errexit) : Arrête immédiatement le script si une commande échoue
set -e

# -f (file) : Vérifie si le fichier .env existe avant d'essayer de le lire
if [ -f .env ]; then
  # -a (allexport) : Force l'exportation de toutes les variables définies ensuite
  set -a
  source .env
  set +a # Désactive l'exportation automatique
fi

echo "Nettoyage des fins de ligne CSV (anti-CRLF)..."
# -i (in-place) : Modifie le fichier directement pour supprimer les retours chariot Windows (\r)
sed -i 's/\r$//' data/*.csv

# -q (quiet) : N'affiche que l'ID du conteneur mariadb s'il existe. 
# Si la variable ALREADY_RUNNING est vide, c'est une première installation.
ALREADY_RUNNING=$(docker compose ps -q mariadb)

echo "Lancement des conteneurs..."
# -d (detach) : Lance en arrière-plan
# --build : Force la reconstruction des images si les Dockerfile ont changé
docker compose up -d --build

echo "Attente du démarrage de Dolibarr..."
ready=0
for i in $(seq 1 60); do
  # -s (silent) : Mode silencieux, pas de barre de progression
  # -o (output) /dev/null : Ignore le contenu de la page web téléchargée
  # -w (write-out) '%{http_code}' : N'affiche que le code statut HTTP (ex: 200, 302, 500)
  code=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:${WEB_PORT}/" || true)
  
  # Si le code HTTP est 200 (OK) ou 302 (Redirection), l'interface est prête
  if [[ "$code" =~ ^(200|302)$ ]]; then ready=1; break; fi
  sleep 5
done

# Vérifie que ready vaut 1, sinon affiche l'erreur et quitte le script (exit 1)
[ "$ready" -eq 1 ] || { echo "Dolibarr n'a pas répondu, voir : docker compose logs dolibarr"; exit 1; }

# -a (all) : Inclut les conteneurs arrêtés dans la recherche
# -q (quiet) : Ne récupère que l'ID du conteneur "importer"
IMPORTER_ID=$(docker compose ps -aq importer | head -n 1)
if [ -n "$IMPORTER_ID" ]; then
  # docker wait bloque l'exécution du script bash jusqu'à ce que le conteneur importer soit totalement arrêté
  docker wait "$IMPORTER_ID" >/dev/null 2>&1 || true
fi

# Logique de gestion de la base de données
if [ -n "$ALREADY_RUNNING" ]; then
  echo "Base de données active détectée. Conservation des données actuelles..."
else
  echo "Nouvelle installation détectée."
  
  # -f (file) : Vérifie que le fichier sql/backup.sql existe
  # -s (size) : Vérifie que le fichier a une taille supérieure à 0 octet
  if [ -f "sql/backup.sql" ] && [ -s "sql/backup.sql" ]; then
    echo "Restauration depuis la sauvegarde (sql/backup.sql)..."
    
    # -T : Désactive l'allocation TTY (nécessaire pour injecter un fichier SQL via '<')
    # -u : Spécifie l'utilisateur MySQL (root)
    # -p : Spécifie le mot de passe MySQL
    docker compose exec -T mariadb mariadb \
      -u root -p"${MYSQL_ROOT_PASSWORD:-root_rt}" \
      "${DOLI_DB_NAME}" < sql/backup.sql
    echo "Base restaurée avec succès depuis sql/backup.sql !"
  else
    echo "Aucune sauvegarde trouvée, conservation de l'import CSV initial :"
    docker compose logs importer | tail -n 10
  fi
fi

echo "Vérification et activation automatique des modules Tiers, Fournisseurs et Import..."
# -T : Désactive le TTY (évite des messages d'erreur liés à l'environnement Docker)
# -r (run) : Demande à PHP d'exécuter directement le code fourni entre les guillemets simples sans créer de fichier .php
docker compose exec -T dolibarr php -r '
require_once "/var/www/html/master.inc.php";                 // Charge le cœur de l"application
require_once DOL_DOCUMENT_ROOT . "/core/lib/admin.lib.php"; // Charge les fonctions d"administration
$langs->load("admin");                                       // Charge la langue
$user->fetch(1);                                             // Simule la connexion de l"admin (ID 1)
$user->getrights();                                          // Charge les droits de l"admin
activateModule("modSociete");                                // Active le module Tiers
activateModule("modFournisseur");                            // Active le module Fournisseurs
activateModule("modImport");                                 // Active le module Import
'

echo "Installation terminée : http://localhost:${WEB_PORT} (login : ${DOLI_ADMIN_LOGIN})"
