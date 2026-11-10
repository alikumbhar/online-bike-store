#!/bin/bash
set -e

echo "=== Pulling Docker image ==="
# Pull the latest Docker image from Docker Hub / ECR
# Note: Parameter Store or environment variables provide registry credentials
# docker pull "$DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/online-bike-store:latest"

# Run container with docker-compose or docker run on port 80
echo "=== Starting container ==="
if [ -f "docker-compose.yml" ]; then
    docker compose down 2>/dev/null || docker-compose down 2>/dev/null || true
    docker compose up -d || docker-compose up -d
else
    docker stop online-bike-store 2>/dev/null || true
    docker rm online-bike-store 2>/dev/null || true
    docker run -d --name online-bike-store -p 80:80 "$DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/online-bike-store:latest"
fi

echo "=== Container started successfully ==="
