#!/bin/bash

# verify-variants.sh - Verify variants.conf is configured correctly

set -e

VARIANTS_CONF="/opt/local/etc/macports/variants.conf"

# Check if variants.conf exists
if [ ! -f "$VARIANTS_CONF" ]; then
    echo "Expected variants.conf to exist at $VARIANTS_CONF"
    exit 1
fi

# Check if selected variants are present
if ! grep -q "^+aqua" "$VARIANTS_CONF"; then
    echo "Expected +aqua variant in variants.conf"
    echo "Variants conf content:"
    cat "$VARIANTS_CONF"
    exit 1
fi

if ! grep -q "^+metal" "$VARIANTS_CONF"; then
    echo "Expected +metal variant in variants.conf"
    echo "Variants conf content:"
    cat "$VARIANTS_CONF"
    exit 1
fi

# Check if deselected variants are present
if ! grep -q "^-x11" "$VARIANTS_CONF"; then
    echo "Expected -x11 variant in variants.conf"
    echo "Variants conf content:"
    cat "$VARIANTS_CONF"
    exit 1
fi

echo "Variants configuration test passed!"
exit 0
