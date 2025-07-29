#!/bin/bash
set -e

echo "Checking the health of the containers..."

SERVICES="$1"

for service in $SERVICES; do
  running=$(docker inspect -f '{{.State.Running}}' "$service" 2>/dev/null || echo "false")

  if [ "$running" = "true" ]; then
    echo "$service is running ✔️"
  else
    exit_code=$(docker inspect -f '{{.State.ExitCode}}' "$service" 2>/dev/null || echo "1")
    if [ "$exit_code" = "0" ]; then
      echo "$service is stopped but exited with code 0 ✔️"
    else
      echo "::error ::$service is stopped and exited with code $exit_code ❌"
      exit 1
    fi
  fi
done
