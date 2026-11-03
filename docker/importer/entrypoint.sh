#!/bin/bash
set -euo pipefail

export MYSQL_PWD="${DB_PASSWORD}"
SQL="mariadb -h ${DB_HOST} -u${DB_USER} ${DB_NAME}"

echo "[importer] Attente de l'installation de Dolibarr..."
ok=0
for i in $(seq 1 120); do
  fr=$($SQL -N -B -e "SELECT COUNT(*) FROM llx_c_country WHERE code='FR'" 2>/dev/null || echo 0)
  usr=$($SQL -N -B -e "SELECT COUNT(*) FROM llx_user" 2>/dev/null || echo 0)
  if [ "$fr" -ge 1 ] && [ "$usr" -ge 1 ]; then ok=1; break; fi
  sleep 5
done
[ "$ok" -eq 1 ] || { echo "[importer] Dolibarr n'est pas installé après 10 minutes"; exit 1; }

echo "[importer] Import des CSV..."
$SQL --local-infile=1 < /app/import.sql
echo "[importer] Import terminé."
