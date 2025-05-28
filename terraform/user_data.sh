#!/bin/bash
# Update & install required tools
apt update -y
apt install -y docker.io python3-pip git

# Start Docker
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group (so it can run docker without sudo)
usermod -aG docker ubuntu

# Clone your repo
cd /home/ubuntu
git clone https://github.com/ihebmarnaoui/Infrastructure-Design-Resilience-Automation.git

# Switch to new group (docker) and continue setup
su - ubuntu -c "
cd Infrastructure-Design-Resilience-Automation
pip3 install -r failover/requirements.txt 
chmod +x failover/start_cloud.sh
chmod +x failover/stop_cloud.sh
docker build -t cloud-api .
"

# Setup systemd for auto-start
cp failover/failover.service /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable failover
systemctl start failover
