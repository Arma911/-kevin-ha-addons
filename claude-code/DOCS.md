# Claude Code Add-on

## Erster Start – Login mit claude.ai Abo (Pro/Max)

1. Add-on starten und über die Sidebar öffnen
2. Im Terminal eingeben:
   ```
   claude login
   ```
3. Die angezeigte URL im Browser öffnen
4. Mit dem bestehenden claude.ai-Konto anmelden
5. Der Token wird dauerhaft in `/data/.claude` gespeichert und überlebt Add-on-Updates

## Alternative: Login mit API-Key

Falls du einen API-Key aus der Anthropic Console nutzen möchtest:
```bash
export ANTHROPIC_API_KEY=sk-ant-...
claude
```

## Verwendung

Das Terminal startet direkt im Verzeichnis `/homeassistant`.
Alle HA-Konfigurationsdateien sind les- und schreibbar.

Beispiel: `claude "Zeige mir alle Automationen in packages/energie.yaml"`

## Hinweis zur Sicherheit

Das Terminal ist nur über das Home Assistant Dashboard erreichbar (HA-Login erforderlich).
Öffne Port 7681 auf dem Raspberry Pi **niemals** direkt im Router nach außen.
