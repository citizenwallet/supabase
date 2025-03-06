#!/bin/bash

# install_docker_compose.sh - Automated Docker Compose installation script for Ubuntu 22.04
# Based on: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04

# Exit immediately if a command exits with a non-zero status
set -e

# Print commands before executing them
set -x

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    echo "You can use the install_docker.sh script to install Docker."
    exit 1
fi

echo "Docker is installed. Proceeding with Docker Compose installation..."

# Define the latest Docker Compose version
# You can change this to a specific version if needed
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
echo "Latest Docker Compose version: $COMPOSE_VERSION"

# Create the directory for the Docker Compose binary
sudo mkdir -p /usr/local/lib/docker/cli-plugins

# Download Docker Compose
echo "Downloading Docker Compose..."
sudo curl -SL "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose

# Apply executable permissions
echo "Setting executable permissions..."
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Create a symbolic link to make it accessible from the command line
echo "Creating symbolic link..."
sudo ln -sf /usr/local/lib/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose

# Verify the installation
echo "Verifying Docker Compose installation..."
docker compose version

echo "Docker Compose installation completed successfully!"
echo "You can now use Docker Compose with the 'docker compose' command or the legacy 'docker-compose' command."