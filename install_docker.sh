#!/usr/bin/env bash

set -e

echo "=== Étape 1 : Nettoyage des anciennes versions de Docker ==="
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

echo "=== Étape 2 : Installation des prérequis et des clés de sécurité ==="
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== Étape 3 : Ajout du dépôt stable de Docker ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /usr/lib/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Étape 4 : Installation de Docker et Docker Compose ==="
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Étape 5 : Démarrage et activation du service Docker ==="
sudo systemctl enable --now docker

echo "=== Étape 6 : (Optionnel) Ajout de l'utilisateur courant au groupe docker ==="
# Permet de lancer des commandes docker sans taper sudo
if ! groups $USER | grep -q '\bdocker\b'; then
  sudo usermod -aG docker $USER
  echo "Utilisateur ajouté au groupe docker. (Note : Un redémarrage de session sera nécessaire pour que ce soit effectif)."
fi

echo "=== Installation terminée avec succès ! ==="
docker --version
docker compose version
