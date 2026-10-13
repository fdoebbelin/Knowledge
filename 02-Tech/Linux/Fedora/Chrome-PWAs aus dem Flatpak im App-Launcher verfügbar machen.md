---
title: Chrome-PWAs aus dem Flatpak im App-Launcher verfügbar machen
aliases:
  - Chrome PWA Flatpak
  - PWA im Launcher
  - Teams als PWA unter Linux
tags:
  - linux
  - flatpak
  - chrome
  - pwa
  - noctalia
  - wayland
description: Leitfaden, wie installierte Web-Apps (PWAs) aus dem Flatpak-Chrome als Desktop-Einträge im Launcher (z. B. Noctalia-Shell) erscheinen – inkl. Fehleranalyse.
system: Fedora, Flatpak Chrome, Noctalia-Shell
created: 2026-10-13
status: active
type: anleitung
---
Installierte Web-Apps (PWAs) wie **Microsoft Teams**, Gmail oder Google Drive tauchen nur dann im Launcher einer Desktop-Shell auf, wenn Chrome für sie eine `.desktop`-Datei anlegen kann. Läuft Chrome als **Flatpak**, ist genau das standardmäßig nicht erlaubt.

> [!info] Gilt für
> - Google Chrome als Flatpak (`com.google.Chrome`, Flathub)
> - sinngemäß auch für Chromium (`org.chromium.Chromium`) und Edge (`com.microsoft.Edge`)
> - jede Shell bzw. jeden Launcher, der XDG-Desktop-Einträge liest – hier getestet mit der **Noctalia-Shell**

## Symptom

Beim Installieren einer PWA oder beim Erstellen einer Verknüpfung unter `chrome://apps` erscheint:

> This Flatpak does not have write access to `~/.local/share/applications` and `~/.local/share/icons`, so it cannot install or uninstall PWAs.

Die App lässt sich zwar über `chrome://apps` starten, erscheint aber nicht im Launcher.

## Hintergrund

| Baustein | Rolle |
|---|---|
| `~/.local/share/applications/` | Hier legt Chrome pro PWA eine `.desktop`-Datei ab. Launcher lesen dieses Verzeichnis. |
| `~/.local/share/icons/` | Hier landen die zugehörigen Icons. |
| Flatpak-Sandbox | Erlaubt Chrome standardmäßig keinen Schreibzugriff auf diese beiden Ordner. |
| `flatpak override` | Erweitert die Rechte einer Flatpak-App dauerhaft (wie Flatseal). |

> [!warning] Zwei typische Stolperfallen
> 1. **Ein Zielordner existiert nicht** (oft `~/.local/share/icons`). Flatpak bindet einen Pfad ohne `:create` nur ein, wenn er bereits vorhanden ist – die Freigabe greift dann stillschweigend nicht.
> 2. **Chrome läuft noch im Hintergrund.** Ein Override wirkt erst beim nächsten Start der App. Chrome bleibt durch die Einstellung „Apps im Hintergrund weiterlaufen lassen“ oft auch nach dem Schließen aktiv.

## Lösung Schritt für Schritt

### 1. App-ID prüfen

```bash
flatpak list --app | grep -i chrom
```

Erwartet: `com.google.Chrome`. Steht dort eine andere ID, diese in allen folgenden Befehlen verwenden.

### 2. Ordner anlegen und Rechte vergeben

```bash
mkdir -p ~/.local/share/applications ~/.local/share/icons

flatpak override --user \
  --filesystem=~/.local/share/applications:create \
  --filesystem=~/.local/share/icons:create \
  com.google.Chrome
```

> [!tip] Alternative mit Flatseal
> *Google Chrome → Filesystem → Other files* → beide Pfade (mit `:create`) eintragen. CLI und Flatseal schreiben in dieselbe Override-Datei.

### 3. Override kontrollieren

```bash
flatpak override --user --show com.google.Chrome
```

Unter `[Context]` müssen bei `filesystems=` beide Pfade stehen.

### 4. Chrome vollständig beenden

```bash
flatpak kill com.google.Chrome
flatpak ps
```

`flatpak ps` muss **leer** sein. Falls noch Instanzen laufen, über die angezeigte Prozesskennung beenden:

```bash
kill <PID>
```

### 5. Schreibzugriff aus der Sandbox testen

```bash
flatpak run --command=sh com.google.Chrome -c \
  'ls -d ~/.local/share/applications ~/.local/share/icons && touch ~/.local/share/icons/.t && echo OK'
rm -f ~/.local/share/icons/.t
```

Erscheint `OK`, ist der Zugriff vorhanden.

### 6. Verknüpfungen neu erzeugen

1. Chrome starten, `chrome://apps` öffnen.
2. Rechtsklick auf die App (z. B. **Microsoft Teams**) → **„Verknüpfungen erstellen…“**.
3. **„Anwendungsmenü“** anhaken und bestätigen.
4. Für weitere PWAs (Gmail, Chat, Drive …) wiederholen.

### 7. Ergebnis prüfen

```bash
ls ~/.local/share/applications | grep -i flextop
```

Die Flatpak-Variante benennt die Dateien nach dem Schema:

```text
com.google.Chrome.flextop.chrome-<APP-ID>-Default.desktop
```

Danach erscheint die App im Launcher – ggf. erst nach einem Neustart der Shell bzw. erneutem Login.

## Nützliches für den Alltag

### PWA direkt aus dem Terminal starten

```bash
flatpak run --command=/app/bin/chrome com.google.Chrome \
  --profile-directory=Default --app-id=<APP-ID>
```

Die App-ID steht in der `Exec=`-Zeile der `.desktop`-Datei.

### Fenster-Zuordnung (Dock, Fensterregeln)

Unter Wayland trägt das PWA-Fenster die app_id `chrome-<APP-ID>-Default`. Das muss zu `StartupWMClass=` in der `.desktop`-Datei passen, damit Dock bzw. Taskleiste das Fenster dem Starter zuordnen. Dieselbe ID verwenden Fensterregeln in niri oder Hyprland.

### Hintergrundbetrieb abschalten (optional)

`chrome://settings/system` → **„Apps im Hintergrund weiterlaufen lassen, wenn Google Chrome geschlossen ist“** deaktivieren. Dann greifen künftige Overrides schon nach normalem Schließen.

### Override zurücksetzen

```bash
flatpak override --user --reset com.google.Chrome
```

## Fehlersuche – Kurzcheckliste

- [ ] Richtige App-ID? → `flatpak list --app`
- [ ] Override vorhanden? → `flatpak override --user --show <ID>`
- [ ] Beide Ordner existieren? → `ls -d ~/.local/share/{applications,icons}`
- [ ] `:create` an beiden Pfaden gesetzt?
- [ ] Keine laufende Instanz? → `flatpak ps` ist leer
- [ ] Schreibtest aus der Sandbox ergibt `OK`?
- [ ] Verknüpfung *nach* dem Neustart unter `chrome://apps` neu erstellt?

## Quellen

- [Installing PWAs – Flatpak has no write access (Flathub Discourse)](https://discourse.flathub.org/t/installing-pwas-flatpak-has-no-write-access/6859)
- [PWAs: This Flatpak does not have write access to (Flathub Discourse)](https://discourse.flathub.org/t/pwas-this-flatpak-does-not-have-write-access-to/3830)
- [Chrome PWA Issue (Zorin Forum)](https://forum.zorin.com/t/chrome-pwa-issue/45068)

## Verwandt

- [[00 Flathub einrichten]] – Flatpak system- vs. benutzerweit einrichten
- [[GUI-Toolkit-Strategie]] – Theming und Toolkit-Fragen unter Hyprland/Noctalia
- [[Fedora Sway Atomic]] – wohin welche Software auf Atomic-Systemen gehört
