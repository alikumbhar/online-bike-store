#!/bin/bash
set -e

echo "=== Stopping running container ==="
if [ -f "docker-compose.yml" ]; then
    docker compose down 2>/dev/null || docker-compose down 2>/dev/null || true
fi

docker stop online-bike-store 2>/dev/null || true
docker rm online-bike-store 2>/dev/null || true

echo "=== Container stopped successfully ==="
