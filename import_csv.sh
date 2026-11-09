#!/usr/bin/env bash
set -euo pipefail
#-u = stop si une variable non définie est utilisée  
#-o pipefail = si une commande dans un pipeline échoue, le script échoue aussi

cd "$(dirname "$0")"

docker compose build importer
docker compose run --rm importer
