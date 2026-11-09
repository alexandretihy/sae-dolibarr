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

# -p (parents) : Crée le dossier 'sql' s'il n'existe pas
mkdir -p sql

BACKUP_FILE="sql/backup.sql"

echo "Sauvegarde de la base de données '${DOLI_DB_NAME}' en cours..."

# -T : Désactive l'allocation TTY (indispensable pour rediriger proprement le texte généré vers un fichier local avec '>')
# --single-transaction : Crée une sauvegarde cohérente d'un seul bloc sans verrouiller/bloquer la base de données pendant l'export (parfait pour l'utilisation en production)
docker compose exec -T mariadb mariadb-dump \
  -u root -p"${MYSQL_ROOT_PASSWORD:-root_rt}" \
  --single-transaction \
  "${DOLI_DB_NAME}" > "${BACKUP_FILE}"



# 'cut -f1' coupe le résultat pour ne garder que la première colonne (la taille chiffrée, en enlevant le nom du fichier)
echo "Sauvegarde terminée avec succès : ${BACKUP_FILE} ($(du -h "${BACKUP_FILE}" | cut -f1))"
