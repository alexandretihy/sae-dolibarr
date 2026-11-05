#!/usr/bin/env bash
set -e

if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

echo "Nettoyage des fins de ligne CSV (anti-CRLF)..."
sed -i 's/\r$//' data/*.csv

echo "Lancement des conteneurs..."
docker compose up -d --build

echo "Attente du démarrage de Dolibarr..."
ready=0
for i in $(seq 1 60); do
  code=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:${WEB_PORT}/" || true)
  if [[ "$code" =~ ^(200|302)$ ]]; then ready=1; break; fi
  sleep 5
done
[ "$ready" -eq 1 ] || { echo "Dolibarr n'a pas répondu, voir : docker compose logs dolibarr"; exit 1; }

echo "Attente de la fin du conteneur importer..."
IMPORTER_ID=$(docker compose ps -aq importer | head -n 1)
if [ -n "$IMPORTER_ID" ]; then
  docker wait "$IMPORTER_ID" >/dev/null 2>&1 || true
fi

if [ -f "sql/backup.sql" ] && [ -s "sql/backup.sql" ]; then
  echo "Sauvegarde détectée (sql/backup.sql). Restauration de la base de données..."
  docker compose exec -T mariadb mariadb \
    -u root -p"${MYSQL_ROOT_PASSWORD:-root_rt}" \
    "${DOLI_DB_NAME}" < sql/backup.sql
  echo "Base de données restaurée depuis sql/backup.sql !"
else
  echo "Aucune sauvegarde trouvée. Vérification de l'import CSV initial..."
  docker compose logs importer | tail -n 10

  echo "Activation automatique des modules Tiers, Fournisseurs et Import..."
  docker compose exec -T dolibarr php -r '
  require_once "/var/www/html/master.inc.php";
  require_once DOL_DOCUMENT_ROOT . "/core/lib/admin.lib.php";
  $langs->load("admin");
  $user->fetch(1);
  $user->getrights();
  activateModule("modSociete");
  activateModule("modFournisseur");
  activateModule("modImport");
  '
fi

echo "Installation terminée : http://localhost:${WEB_PORT} (login : ${DOLI_ADMIN_LOGIN})"
