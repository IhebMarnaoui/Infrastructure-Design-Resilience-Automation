#!/bin/bash

# Simple script to build and run the on-prem Docker container

echo "[INFO] Building Docker image for onprem-api..."
docker build -t onprem-api .

echo "[INFO] Running container on port 5000..."
docker run -d -p 5000:5000 --name onprem-api onprem-api

echo "[DONE] onprem-api is now running at http://localhost:5000/"
