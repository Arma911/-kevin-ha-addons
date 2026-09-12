#!/bin/bash
set -euo pipefail

export HOME=/data
export CLAUDE_CONFIG_DIR=/data/.claude
mkdir -p /data/.claude

cd /homeassistant || { echo "FEHLER: /homeassistant nicht verfuegbar. Warte 5s und versuche es erneut..."; sleep 5; cd /homeassistant; }

# ttyd startet sonst pro Verbindung eine frische Bash und killt sie beim
# Trennen (Tab schliessen). Ueber tmux (-A = attach falls Session "claude"
# schon existiert, sonst neu anlegen) laeuft
# weiter, auch wenn niemand verbunden ist. Beendet wird sie nur durch
# "exit" in der Bash (oder "tmux kill-sessio
exec ttyd --port 7681 --writable tmux new-session -A -s claude -c /homeassistant
