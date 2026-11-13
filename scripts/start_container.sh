
#!/bin/bash
set -Eeuo pipefail

# ==========================================
# Configuration
# ==========================================

APP_NAME="online-bike-store"
DB_CONTAINER="mysql-bikedb"
NETWORK_NAME="bike-network"

AWS_REGION="${AWS_REGION:-us-east-2}"

DB_IMAGE="mysql:8.0"
APP_IMAGE="alikumbhar/online-bike-store:latest"

# AWS SSM Parameter Store paths
DB_PASSWORD_PARAM="/bike-shop/DB_PASSWORD"
MYSQL_ROOT_PASSWORD_PARAM="/bike-shop/MYSQL_ROOT_PASSWORD"

echo "=========================================="
echo " Starting Online Bike Store Deployment"
echo "=========================================="

# ==========================================
# Check Dependencies
# ==========================================

command -v docker >/dev/null 2>&1 || {
echo "ERROR: Docker is not installed."
exit 1
}

command -v aws >/dev/null 2>&1 || {
echo "ERROR: AWS CLI is not installed."
exit 1
}

# ==========================================
# Retrieve Passwords from AWS SSM
# ==========================================

echo "=== Retrieving database passwords from SSM ==="

DB_PASSWORD=$(aws ssm get-parameter \
--name "$DB_PASSWORD_PARAM" \
--with-decryption \
--region "$AWS_REGION" \
--query "Parameter.Value" \
--output text)

MYSQL_ROOT_PASSWORD=$(aws ssm get-parameter \
--name "$MYSQL_ROOT_PASSWORD_PARAM" \
--with-decryption \
--region "$AWS_REGION" \
--query "Parameter.Value" \
--output text)

if [[ -z "$DB_PASSWORD" || "$DB_PASSWORD" == "None" ]]; then
echo "ERROR: Database password is empty."
exit 1
fi

if [[ -z "$MYSQL_ROOT_PASSWORD" || "$MYSQL_ROOT_PASSWORD" == "None" ]]; then
echo "ERROR: MySQL root password is empty."
exit 1
fi

echo "SSM parameters retrieved successfully."

# ==========================================
# Create Docker Network
# ==========================================

echo "=== Creating Docker network ==="

if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
docker network create "$NETWORK_NAME"
else
echo "Docker network already exists."
fi

# ==========================================
# Pull Docker Images
# ==========================================

echo "=== Pulling Docker images ==="

docker pull "$DB_IMAGE"
docker pull "$APP_IMAGE"

# ==========================================
# Stop and Remove Existing Containers
# ==========================================

echo "=== Removing existing containers ==="

docker rm -f "$APP_NAME" 2>/dev/null || true
docker rm -f "$DB_CONTAINER" 2>/dev/null || true

# ==========================================
# Start MySQL Database Container
# ==========================================

echo "=== Starting MySQL database ==="

docker run -d \
--name "$DB_CONTAINER" \
--restart unless-stopped \
--network "$NETWORK_NAME" \
--network-alias database \
-e MYSQL_DATABASE=bike_shop \
-e MYSQL_USER=bike_user \
-e MYSQL_PASSWORD="$DB_PASSWORD" \
-e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
--health-cmd="mysqladmin ping -h 127.0.0.1 -u root -p\$MYSQL_ROOT_PASSWORD --silent" \
--health-interval=10s \
--health-timeout=5s \
--health-retries=10 \
--health-start-period=30s \
-v bike-db-data:/var/lib/mysql \
-p 3306:3306 \
"$DB_IMAGE"

# ==========================================
# Wait for MySQL to Become Healthy
# ==========================================

echo "=== Waiting for MySQL to become healthy ==="

DB_READY=false

for i in {1..30}; do
DB_STATUS=$(docker inspect \
--format='{{.State.Health.Status}}' "$DB_CONTAINER")

if [[ "$DB_STATUS" == "healthy" ]]; then
DB_READY=true
break
fi

echo "Waiting for database... ($i/30)"
sleep 5
done

if [[ "$DB_READY" != true ]]; then
echo "ERROR: MySQL did not become healthy."
docker logs "$DB_CONTAINER" --tail 50
exit 1
fi

echo "MySQL database is healthy."

# ==========================================
# Start Application Container
# ==========================================

echo "=== Starting Online Bike Store ==="

docker run -d \
--name "$APP_NAME" \
--restart unless-stopped \
--network "$NETWORK_NAME" \
-p 8080:80 \
-e DB_HOST=database \
-e DB_NAME=bike_shop \
-e DB_USER=bike_user \
-e DB_PASSWORD="$DB_PASSWORD" \
"$APP_IMAGE"

# ==========================================
# Deployment Summary
# ==========================================

unset DB_PASSWORD MYSQL_ROOT_PASSWORD

echo "=========================================="
echo " Deployment Completed Successfully!"
echo "=========================================="

echo "Application Container: $APP_NAME"
echo "Database Container: $DB_CONTAINER"
echo "Docker Network: $NETWORK_NAME"
echo "Application Port: 8080"
echo "Database: MySQL 8.0"
echo "Application Image: $APP_IMAGE"

echo ""
echo "Application URL: http://YOUR_EC2_PUBLIC_IP:8080"

echo "=========================================="