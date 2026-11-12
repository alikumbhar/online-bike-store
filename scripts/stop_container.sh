
#!/bin/bash
set -e

echo "=== Stopping running containers ==="

if [ -f "docker-compose.yml" ]; then
    docker compose down 2>/dev/null || docker-compose down 2>/dev/null || true
fi

# Stop and remove application container
echo "=== Stopping Online Bike Store ==="
docker stop online-bike-store 2>/dev/null || true
docker rm online-bike-store 2>/dev/null || true

# Stop and remove MySQL database container
echo "=== Stopping MySQL Database ==="
docker stop mysql-bikedb 2>/dev/null || true
docker rm mysql-bikedb 2>/dev/null || true

echo "=== Both containers stopped and removed successfully ==="
