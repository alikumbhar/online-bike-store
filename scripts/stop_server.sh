#!/bin/bash
# stop_server.sh
# Gracefully stops Apache web server during deployment

set -e

echo "=== Stopping Apache web server ==="

# Check if Apache service is active before stopping
if systemctl is-active --quiet apache2 2>/dev/null || systemctl is-active --quiet httpd 2>/dev/null; then
    if command -v systemctl >/dev/null 2>&1; then
        systemctl stop apache2 2>/dev/null || systemctl stop httpd 2>/dev/null || true
    else
        service apache2 stop 2>/dev/null || service httpd stop 2>/dev/null || true
    fi
    echo "Apache web server stopped."
else
    echo "Apache web server is not running."
fi