#!/bin/bash
# validate_service.sh
# Validates that the deployed application is responding correctly
# Runs after Apache has started to confirm the deployment succeeded

set -e

APP_URL=${APP_URL:-http://localhost/}
MAX_RETRIES=10
RETRY_DELAY=3
HTTP_STATUS=""

echo "=== Validating Docker container at $APP_URL ==="

# Give container a moment to fully initialize
sleep 5

# Check if container is running
if ! docker ps | grep -q "online-bike-store"; then
    echo "✗ Docker container is not running."
    exit 1
fi

# Retry loop: poll the application until it responds or we exhaust retries
for i in $(seq 1 $MAX_RETRIES); do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$APP_URL" 2>/dev/null || echo "000")

    if [ "$HTTP_STATUS" = "200" ] || [ "$HTTP_STATUS" = "302" ]; then
        echo "✓ Application responded with HTTP $HTTP_STATUS on attempt $i. Deployment successful!"
        exit 0
    fi

    echo "Attempt $i/$MAX_RETRIES: received HTTP $HTTP_STATUS, retrying in ${RETRY_DELAY}s..."
    sleep $RETRY_DELAY
done

echo "✗ Application validation failed after $MAX_RETRIES attempts (last HTTP status: $HTTP_STATUS)."
exit 1