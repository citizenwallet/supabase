#!/bin/bash

# install_docker.sh - Automated Docker installation script for Ubuntu 22.04
# Based on: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04

# Exit immediately if a command exits with a non-zero status
set -e

# Print commands before executing them
set -x

echo "Updating package index..."
sudo apt update

echo "Installing prerequisites..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Setting up the stable Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package index with Docker repository..."
sudo apt update

echo "Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Verifying Docker installation..."
sudo docker run hello-world

# Optional: Add current user to the docker group to use Docker without sudo
echo "Would you like to add your user to the docker group to use Docker without sudo? (y/n)"
read -r add_user_to_docker_group

if [[ "$add_user_to_docker_group" =~ ^[Yy]$ ]]; then
    echo "Adding your user to the docker group..."
    sudo usermod -aG docker "${USER}"
    echo "You need to log out and log back in for this to take effect."
    echo "After logging back in, you can verify with: docker run hello-world"
else
    echo "Skipping adding user to docker group."
    echo "You'll need to use sudo for Docker commands."
fi

echo "Docker installation completed successfully!"
echo "You can now use Docker with the 'docker' command."