FROM debian:12-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends mariadb-client \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY docker/importer/entrypoint.sh /app/entrypoint.sh
COPY sql/import.sql /app/import.sql
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
