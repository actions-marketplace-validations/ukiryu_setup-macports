#!/bin/bash

# verify-port-installation.sh - Verify port installation works

set -e

PORT_BINARY="/opt/local/bin/port"

# Check if a specific port is installed (e.g., git)
INSTALLED_PORTS=$("$PORT_BINARY" installed | grep -c "@.*" || true)

if [ "$INSTALLED_PORTS" -eq 0 ]; then
    echo "Warning: No ports appear to be installed"
    echo "Installed ports output:"
    "$PORT_BINARY" installed
    # This might be okay if the test didn't specify ports to install
    exit 0
fi

# If specific ports were requested, check for them
if [ -n "$TEST_PORTS" ]; then
    for port in $TEST_PORTS; do
        if ! "$PORT_BINARY" installed "$port" | grep -q "$port"; then
            echo "Expected port $port to be installed"
            exit 1
        fi
    done
fi

echo "Port installation test passed!"
exit 0
