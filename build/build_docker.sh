#!/usr/bin/env bash
set -e

# Run from inside the docker/ directory
debs="$(find ../docker_dep/*.deb | wc -l)"
if [[  debs -eq "0" ]]; then
  echo "No .deb files found. Copy docker .debs here first."
  exit 1
fi

echo "Installing Docker Engine and dependencies from local .deb files..."
sudo apt-get update || true   # will just refresh local metadata; network will fail but it's ok

# Check if docker is already installed
version="$(docker --version | wc -l)"
if [[ $version -eq "1" ]]; then
    echo "Docker already installed"
    exit 0
fi

# Let apt handle dependency ordering using local files
cd ../docker_dep
sudo apt-get install ./docker*.deb ./containerd*.deb ./docker-*.deb *.deb

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Docker installation complete."
docker --version || echo "Docker installed, but 'docker --version' failed – check PATH/services."
EOF
