#!/usr/bin/env bash
set -e

TARBALL=$(ls /home/vincent/CRAP-Cluster-node/go_dep/go*.linux-*.tar.gz 2>/dev/null | head -n1)

if [[ -z "$TARBALL" ]]; then
  echo "Go tarball (go*.linux-*.tar.gz) not found in this directory."
  exit 1
fi

echo "Installing Go from $TARBALL to /usr/local/go..."

if [[ "$(which go | wc -l)" -eq "1" ]]; then
    echo "go already installed"
    exit 0
fi


sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "$TARBALL"

# Set up PATH in profile if not already present
if ! grep -q 'export PATH=.*/usr/local/go/bin' ~/.profile 2>/dev/null; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
fi

echo "Go installation complete. Log out and back in (or 'source ~/.profile') to get go in PATH."
/usr/local/go/bin/go version || echo "Go installed, but 'go' not yet in PATH for this shell."

