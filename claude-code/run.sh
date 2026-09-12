#!/bin/bash
set -uo pipefail

export HOME=/data
export CLAUDE_CONFIG_DIR=/data/.claude
mkdir -p /data/.claude

# Nach einem kompletten HA/Supervisor-Neustart kann /homeassistant erst mit
# Verzoegerung gemountet werden. Bis zu 2 Minuten in 5s-Schritten abwarten,
# statt (wie vorher) nach einem einzigen Fehlversuch abzustuerzen.
WORKDIR=/homeassistant
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

# ttyd startet sonst pro Verbindung eine frische Bash und killt sie beim
# Trennen (Tab schliessen). Ueber tmux (-A = attach falls Session "claude"
# schon existiert, sonst neu anlegen) laeuft die Session im Hintergrund
# weiter, auch wenn niemand verbunden ist. Beendet wird sie nur durch
# "exit" in der Bash (oder "tmux kill-session -t claude").
exec ttyd --port 7681 --writable tmux new-session -A -s claude -c "$WORKDIR"
