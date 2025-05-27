#!/bin/bash

ONPREM_URL="http://localhost:5000/health"
CLOUD_URL="http://54.93.70.163:5000/health" #EC2 Instance IP
LOG_FILE="health.log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

check_url() {
  curl -fsS --max-time 2 "$1" > /dev/null
  return $?
}

while true; do
  if check_url "$ONPREM_URL"; then
    log "On-Prem API is UP"
  else
    log "On-Prem API is DOWN — traffic should failover to the cloud"

    if check_url "$CLOUD_URL"; then
      log "Cloud API is UP and handling requests"
    else
      log "BOTH On-Prem and Cloud APIs are DOWN!"
    fi
  fi

  sleep 30
done
