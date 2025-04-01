# What This Guide Is About

This guide will help you integrate the [Supabase](https://supabase.com/) stack into an already running Citizen Wallet [`ENGINE`](https://github.com/citizenwallet/engine) application.

We will self-host Supabase on a Virtual Private Server (VPS).

## VPS Specifications

Here are the specifications of the VPS we are using in this guide:


| VCPU | RAM (GB) | DISK STORAGE (GB) | OS            |
|------|---------|------------------|--------------|
| 8    | 16      | 160              | Ubuntu 22.04 |

# Before We Start
## Register VPS in DNS

Set up your VPS domain name in your DNS provider.

## SSL Certification


## Connect to VPS via SSH
To connect to your VPS, configure SSH as follows:

```bash
# Open the SSH configuration file
nano  ~/.ssh/config

# Enter the following configuration
Host  <my-vps>
	HostName  <IPv4>
	User  <username>
	IdentityFile  <path/to/private/key>
	ForwardAgent  yes
	PubkeyAuthentication  yes

# Save and exit the file

# Test connection to the remote server
ssh  <my-vps>
```

# Installations
## 1. Install Git
Ensure Git is installed on your VPS.

## 2. Install Docker
Use the script `scripts/install_docker.sh`.
This script is compatible with **Ubuntu 22.04**.

```bash
# Execute the Docker installer
~/install_docker.sh

# Verify Docker installation
docker  --version

# Start the Docker daemon
sudo  systemctl  start  docker

# Verify that Docker is running
sudo  systemctl  status  docker
```

## 3. Install Docker Compose
Use the script `scripts/install_docker_compose.sh`.
This script is compatible with **Ubuntu 22.04**.

```bash
# Execute the Docker Compose installer
~/install_docker_compose.sh

# Verify Docker Compose installation
docker  compose  version
```

## 4. psql

## 5. Deno
For edge functions
```shell
curl -fsSL https://deno.land/install.sh | sh
```

