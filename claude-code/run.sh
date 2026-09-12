#!/bin/bash
set -uo pipefail

export HOME=/data
export CLAUDE_CONFIG_DIR=/data/.claude
mkdir -p /data/.claude

# Der echte HA-Konfigurationsordner wird bei diesem Add-on-Mapping ("config:rw")
# unter /config eingehaengt, nicht unter /homeassistant. Trotzdem kurz
# abwarten falls der Mount nach einem Neustart erst verzoegert erscheint.
WORKDIR=/config
for i in $(seq 1 24); do
  [ -d "$WORKDIR" ] && break
  echo "Warte auf $WORKDIR (Versuch $i/24)..."
  sleep 5
done

if [ -d "$WORKDIR" ]; then
  cd "$WORKDIR"
else
  echo "FEHLER: $WORKDIR nach 2 Minuten weiterhin nicht verfuegbar. Starte trotzdem, im Home-Verzeichnis."
  WORKDIR=/data
  cd "$WORKDIR"
fi

# ttyd startet sonst pro Verbindung eine fri
# Trennen (Tab schliessen). Ueber tmux (-A = attach falls Session "claude"
# schon existiert, sonst neu anlegen) laeuft
# weiter, auch wenn niemand verbunden ist. Beendet wird sie nur durch
# "exit" in der Bash (oder "tmux kill-sessio
exec ttyd --port 7681 --writable tmux new-session -A -s claude -c "$WORKDIR" 
