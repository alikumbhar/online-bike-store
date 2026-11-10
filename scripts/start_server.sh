#!/bin/bash
# start_server.sh
# Starts the Apache web server after files have been installed by CodeDeploy

set -e

APP_DIR="/var/www/html"

echo "=== Starting application server ==="

# Set required permissions after files are copied
# CodeIgniter needs write access to cache and logs directories
mkdir -p "$APP_DIR/application/cache" "$APP_DIR/application/logs"
chown -R www-data:www-data "$APP_DIR" 2>/dev/null || true
chmod -R 755 "$APP_DIR"
chmod -R 775 "$APP_DIR/application/cache" "$APP_DIR/application/logs"

# Ensure vendor dependencies exist (composer should have already run during build)
if [ -f "$APP_DIR/composer.json" ] && [ ! -d "$APP_DIR/vendor" ]; then
    echo "Warning: vendor directory missing. Composer dependencies may not be installed."
fi

# Start Apache (or restart if already running)
if command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet apache2 2>/dev/null; then
    echo "Restarting Apache..."
    systemctl restart apache2
elif command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet httpd 2>/dev/null; then
    echo "Restarting httpd..."
    systemctl restart httpd
elif command -v systemctl >/dev/null 2>&1; then
    echo "Starting Apache..."
    systemctl start apache2 2>/dev/null || systemctl start httpd 2>/dev/null || \
        (apachectl start && true)
else
    service apache2 start 2>/dev/null || service httpd start 2>/dev/null || \
        apachectl start
fi

echo "=== Apache server started successfully ==="
