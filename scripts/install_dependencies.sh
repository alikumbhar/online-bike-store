#!/bin/bash
# install_dependencies.sh
# Installs required system dependencies for the PHP CodeIgniter application
# This script is idempotent - can be run multiple times safely

set -e

echo "=== Installing system dependencies ==="

# Update package lists
apt-get update -qq

# Install required PHP extensions and modules if not already present
# These match the requirements from the Dockerfile and composer.json
if ! php -m | grep -q "mbstring"; then
    apt-get install -y --no-install-recommends libapache2-mod-php8.2 php8.2-mbstring php8.2-xml php8.2-zip php8.2-mysql php8.2-curl php8.2-gd php8.2-intl
fi

# Enable Apache rewrite module (critical for CodeIgniter pretty URLs)
if ! apache2ctl -M | grep -q "rewrite_module"; then
    a2enmod rewrite
fi

# Ensure required directories exist
mkdir -p /var/www/html/application/cache /var/www/html/application/logs

# Set proper ownership and permissions for CodeIgniter
chown -R www-data:www-data /var/www/html/application/cache /var/www/html/application/logs
chmod -R 775 /var/www/html/application/cache /var/www/html/application/logs

echo "=== System dependencies installed successfully ==="