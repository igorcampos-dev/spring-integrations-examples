#!/bin/sh
# entrypoint.sh

echo "Waiting 30 seconds..."
sleep 30

echo "Starting the application..."
exec java -jar app.jar