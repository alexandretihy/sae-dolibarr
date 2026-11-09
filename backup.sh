#!/usr/bin/env bash
set -e

if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

mkdir -p sql
BACKUP_FILE="sql/backup.sql"

echo "Sauvegarde de la base de données '${DOLI_DB_NAME}' en cours..."
docker compose exec -T mariadb mariadb-dump \
  -u root -p"${MYSQL_ROOT_PASSWORD:-root_rt}" \
  --single-transaction \
  "${DOLI_DB_NAME}" > "${BACKUP_FILE}"

echo "Sauvegarde terminée avec succès : ${BACKUP_FILE} ($(du -h "${BACKUP_FILE}" | cut -f1))"
