#!/bin/bash
echo "[INFO] Stopping cloud-api container" >> /home/ubuntu/failover/action.log
docker stop cloud-api >> /home/ubuntu/failover/action.log 2>&1
