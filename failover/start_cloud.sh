#!/bin/bash
docker start cloud-api 2>/dev/null || \
docker run -d -p 5000:5000 --name cloud-api cloud-api
