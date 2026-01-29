#!/bin/bash

# verify-basic-install.sh - Verify basic MacPorts installation

set -e

PORT_BINARY="/opt/local/bin/port"

# Check if port command exists
if [ ! -f "$PORT_BINARY" ]; then
    echo "Expected port binary to exist at $PORT_BINARY"
    exit 1
fi

# Check if port command is executable
if [ ! -x "$PORT_BINARY" ]; then
    echo "Expected port binary to be executable"
    exit 1
fi

# Verify port version output
VERSION_OUTPUT=$("$PORT_BINARY" version)
if [ -z "$VERSION_OUTPUT" ]; then
    echo "Expected port version to return output"
    exit 1
fi

echo "Basic installation test passed!"
exit 0
