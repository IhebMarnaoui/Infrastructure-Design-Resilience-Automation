#!/bin/bash

# This starts the on-prem container to simulate recovery and restore traffic from cloud

echo "[INFO] Starting on-prem container"
docker start onprem-api
