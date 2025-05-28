#!/bin/bash

# Update system and install necessary packages
apt update -y
apt install -y docker.io python3-pip git

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add 'ubuntu' user to Docker group to allow non-root Docker access
usermod -aG docker ubuntu

# Clone the project repository
cd /home/ubuntu
git clone https://github.com/ihebmarnaoui/Infrastructure-Design-Resilience-Automation.git

# Navigate to the project directory
cd Infrastructure-Design-Resilience-Automation

# Install Python dependencies and build the Docker image (as 'ubuntu' user)
sudo -u ubuntu bash <<'EOF'
cd /home/ubuntu/Infrastructure-Design-Resilience-Automation
pip3 install --user -r failover/requirements.txt
docker build -t cloud-api .
EOF

# Make failover scripts executable
chmod +x /home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/start_cloud.sh
chmod +x /home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/stop_cloud.sh

# Set up and start the systemd service for the failover webhook
cp /home/ubuntu/Infrastructure-Design-Resilience-Automation/failover/failover.service /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable failover
systemctl start failover
