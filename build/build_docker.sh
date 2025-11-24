#!/usr/bin/env bash
set -e

# Run from inside the docker/ directory
debs="$(find /home/vincent/CRAP-Cluster-node/docker_dep/*.deb | wc -l)"
if [[  debs -eq "0" ]]; then
  echo "No .deb files found. Copy docker .debs here first."
  exit 1
fi

echo "Installing Docker Engine and dependencies from local .deb files..."

# Check if docker is already installed

if [[ "$(which docker | wc -l)" -eq "1" ]]; then
    echo "Docker already installed"
    exit 0
fi

# Let apt handle dependency ordering using local files
cd /home/vincent/CRAP-Cluster-node/docker_dep
sudo apt-get install ./containerd*.deb ./pigz*.deb ./docker-buildx*.deb ./docker-compose*.deb ./docker-ce-*.deb ./docker-ce_*.deb

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Docker installation complete."
docker --version || echo "Docker installed, but 'docker --version' failed – check PATH/services."
