#!/bin/bash
# Update & install required tools
apt update -y
apt install -y docker.io python3-pip git

# Start Docker
systemctl enable docker
systemctl start docker

# Clone your repo
cd /home/ubuntu
git clone https://github.com/ihebmarnaoui/Infrastructure-Design-Resilience-Automation.git
cd Infrastructure-Design-Resilience-Automation

# Install Python dependencies
pip3 install -r failover/requirements.txt

# Make scripts executable
chmod +x failover/start_cloud.sh
chmod +x failover/stop_cloud.sh

# Build Docker image for cloud-api
docker build -t cloud-api .

# Setup systemd for auto-start
cp failover/failover.service /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable failover
systemctl start failover
