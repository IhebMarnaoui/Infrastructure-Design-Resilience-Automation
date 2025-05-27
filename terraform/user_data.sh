#!/bin/bash

apt-get update -y
apt-get install -y docker.io git

systemctl start docker
systemctl enable docker

git clone https://github.com/ihebmarnaoui/Infrastructure-Design-Resilience-Automation.git /app
cd /app
docker build -t cloud-api .
docker run -d -p 5000:5000 --name cloud-api cloud-api
