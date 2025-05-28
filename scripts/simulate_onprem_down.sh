#!/bin/bash

# This stops the on-prem container to simulate failure and trigger the failover

echo "[INFO] Stopping on-prem container"
docker stop onprem-api
