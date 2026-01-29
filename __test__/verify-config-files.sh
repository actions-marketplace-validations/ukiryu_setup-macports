#!/bin/bash

# verify-config-files.sh - Verify all configuration files are created

set -e

PREFIX="/opt/local"

# Check macports.conf exists
MACPORTS_CONF="$PREFIX/etc/macports/macports.conf"
if [ ! -f "$MACPORTS_CONF" ]; then
    echo "Expected macports.conf to exist at $MACPORTS_CONF"
    exit 1
fi

# Check prefix is set correctly
if ! grep -q "^prefix $PREFIX" "$MACPORTS_CONF"; then
    echo "Expected macports.conf to contain 'prefix $PREFIX'"
    exit 1
fi

# Check variants.conf exists
VARIANTS_CONF="$PREFIX/etc/macports/variants.conf"
if [ ! -f "$VARIANTS_CONF" ]; then
    echo "Expected variants.conf to exist at $VARIANTS_CONF"
    exit 1
fi

# Check sources.conf exists
SOURCES_CONF="$PREFIX/etc/macports/sources.conf"
if [ ! -f "$SOURCES_CONF" ]; then
    echo "Expected sources.conf to exist at $SOURCES_CONF"
    exit 1
fi

# Check directory structure exists
if [ ! -d "$PREFIX/var/macports/portdbpath/registry" ]; then
    echo "Expected portdbpath/registry directory to exist"
    exit 1
fi

if [ ! -d "$PREFIX/var/macports/sources" ]; then
    echo "Expected sources directory to exist"
    exit 1
fi

echo "Configuration files test passed!"
exit 0
