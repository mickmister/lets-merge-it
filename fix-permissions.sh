#!/bin/bash
# Fix permissions for bidirectional shared access
# code-server runs as UID 1000, app runs as UID 1000
# Strategy: Use group-writable permissions so both can write
echo "[custom-init] Setting up shared workspace permissions"

# Ensure directory exists and set ownership
chown -R abc:abc /config/workspace

# Set permissions: owner=rwx, group=rwx, other=rx
# This allows both UID 1000 containers to write
chmod -R 775 /config/workspace

# Set default ACLs for new files (if supported)
if command -v setfacl > /dev/null 2>&1; then
    setfacl -R -d -m u::rwx,g::rwx,o::rx /config/workspace 2>/dev/null || true
fi
