#!/bin/bash

# Update the system packages
sudo pacman -Syu

# Install Docker
sudo pacman -S docker

# Start Docker service
sudo systemctl start docker.service

# Check the status of Docker service
systemctl status docker.service

# If you encounter an error similar to the following:
# × docker.service - Docker Application Container Engine
#     Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
#     Active: failed (Result: exit-code) since Wed 2021-11-24 12:14:58 HKT; 9s ago
# TriggeredBy: × docker.socket
#       Docs: https://docs.docker.com
#    Process: 10573 ExecStart=/usr/bin/dockerd -H fd:// (code=exited, status=1/FAILURE)
#   Main PID: 10573 (code=exited, status=1/FAILURE)
#        CPU: 259ms
#
# Nov 24 12:14:58 TP-Link0815b systemd[1]: docker.service: Scheduled restart job, restart counter is at 3.
# Nov 24 12:14:58 TP-Link0815b systemd[1]: Stopped Docker Application Container Engine.
# Nov 24 12:14:58 TP-Link0815b systemd[1]: docker.service: Start request repeated too quickly.
# Nov 24 12:14:58 TP-Link0815b systemd[1]: docker.service: Failed with result 'exit-code'.
# Nov 24 12:14:58 TP-Link0815b systemd[1]: Failed to start Docker Application Container Engine.

# Enable Docker service to start on boot
sudo systemctl enable docker.service

# Reboot the system to apply changes
reboot

# After reboot, test Docker installation
sudo docker version

# Expected output:
# Client:
#  Version:           20.10.10
#  API version:       1.41
#  Go version:        go1.17.2
#  Git commit:        b485636f4b
#  Built:             Tue Oct 26 03:44:01 2021
#  OS/Arch:           linux/amd64
#  Context:           default
#  Experimental:      true
#
# Server:
#  Engine:
#   Version:          20.10.10
#   API version:      1.41 (minimum version 1.12)
#   Go version:       go1.17.2
#   Git commit:       e2f740de44
#   Built:            Tue Oct 26 03:43:48 2021
#   OS/Arch:          linux/amd64
#   Experimental:     false
#  containerd:
#   Version:          v1.5.7
#   GitCommit:        8686ededfc90076914c5238eb96c883ea093a8ba.m
#  runc:
#   Version:          1.0.2
#   GitCommit:        v1.0.2-0-g52b36a2d
#  docker-init:
#   Version:          0.19.0
#   GitCommit:        de40ad0

# To run Docker without root, add your user to the docker group
sudo usermod -aG docker $USER

# Reboot the system or logout and login again for the changes to take effect
reboot

# Install Docker Compose
# Download the current stable release of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the Docker Compose binary
sudo chmod +x /usr/local/bin/docker-compose

# Test Docker Compose installation
docker-compose --version

# Expected output:
# docker-compose version 1.29.2, build 5becea4c