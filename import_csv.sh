#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

docker compose build importer
docker compose run --rm importer
