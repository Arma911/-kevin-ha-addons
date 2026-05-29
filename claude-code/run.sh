#!/bin/bash
set -euo pipefail

export HOME=/data
export CLAUDE_CONFIG_DIR=/data/.claude
mkdir -p /data/.claude

cd /config || { echo "FEHLER: /config nicht verfuegbar. Warte 5s und versuche es erneut..."; sleep 5; cd /config; }

exec ttyd --port 7681 --writable bash
