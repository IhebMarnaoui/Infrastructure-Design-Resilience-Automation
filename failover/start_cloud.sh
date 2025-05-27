#!/bin/bash
echo "[INFO] Attempting to start cloud-api container" >> /home/ubuntu/failover/action.log
docker start cloud-api >> /home/ubuntu/failover/action.log 2>&1 || \
(
  echo "[INFO] Container not found. Running new instance..." >> /home/ubuntu/failover/action.log #First time run case
  docker run -d -p 5000:5000 --name cloud-api cloud-api >> /home/ubuntu/failover/action.log 2>&1
)
