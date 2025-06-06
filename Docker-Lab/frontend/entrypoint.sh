#!/bin/sh

# Get the API URL from environment variable or use a default
API_URL=${VITE_API_URL:-http://lic-backend:5000}

# Replace the placeholder in the JavaScript files
find /usr/local/apache2/htdocs -type f -name "*.js" -exec sed -i "s|VITE_API_URL_PLACEHOLDER|$API_URL|g" {} \;

# Execute the original command
exec "$@"