#!/bin/bash

# verify-git-sources.sh - Verify git sources are fetched and configured

set -e

PORT_SOURCES_DIR="/opt/local/var/macports/sources/github.com/macports"
MACPORTS_PORTS_DIR="$PORT_SOURCES_DIR/macports-ports"

# Check if macports-ports directory exists
if [ ! -d "$MACPORTS_PORTS_DIR" ]; then
    echo "Expected macports-ports directory to exist at $MACPORTS_PORTS_DIR"
    exit 1
fi

# Check if .git directory exists (indicates git checkout)
if [ ! -d "$MACPORTS_PORTS_DIR/.git" ]; then
    echo "Expected .git directory to exist in macports-ports"
    exit 1
fi

# Check if PortIndex file exists (or at least some port files)
if [ ! -f "$MACPORTS_PORTS_DIR/PortIndex" ] && [ ! -d "$MACPORTS_PORTS_DIR/lang" ]; then
    echo "Expected PortIndex or port files to exist in macports-ports"
    exit 1
fi

# Check if sources.conf points to local git sources
SOURCES_CONF="/opt/local/etc/macports/sources.conf"
if [ ! -f "$SOURCES_CONF" ]; then
    echo "Expected sources.conf to exist at $SOURCES_CONF"
    exit 1
fi

# Check if sources.conf contains file:// URL to local sources
if ! grep -q "file://$MACPORTS_PORTS_DIR" "$SOURCES_CONF"; then
    echo "Expected sources.conf to contain file:// URL to local git sources"
    echo "Sources conf content:"
    cat "$SOURCES_CONF"
    exit 1
fi

echo "Git sources test passed!"
exit 0
