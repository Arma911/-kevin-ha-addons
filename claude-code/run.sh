#!/bin/bash
set -euo pipefail

export HOME=/data
export CLAUDE_CONFIG_DIR=/data/.claude
mkdir -p /data/.claude

cd /homeassistant || { echo "FEHLER: /homeassistant nicht verfuegbar. Warte 5s und versuche es erneut..."; sleep 5; cd /homeassistant; }

exec ttyd --port 7681 --writable bash
