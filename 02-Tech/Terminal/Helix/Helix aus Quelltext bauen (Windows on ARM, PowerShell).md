---
title: "Helix aus Quelltext bauen (Windows on ARM, PowerShell)"
aliases:
  - Helix aus Quelltext bauen
tags:
  - helix
  - windows
  - powershell
created: 2026-10-13
status: active
type: anleitung
system: Windows on ARM
---

Für Windows on ARM oder wenn Scoop kein aktuelles Paket hat: Helix selbst aus dem Quelltext bauen, installiert ins Home-Verzeichnis unter `%USERPROFILE%\src\helix`.

## 1. Ordnerstruktur vorbereiten

```powershell
mkdir $env:USERPROFILE\src -Force
cd $env:USERPROFILE\src
```

## 2. Quelltext klonen

```powershell
git clone https://github.com/helix-editor/helix
cd helix
```

## 3. Bauen und installieren

```powershell
cargo install --path helix-term --locked
```

Ergebnis: Das fertige Binary liegt unter `%USERPROFILE%\.cargo\bin\hx.exe`.

## 4. `HELIX_RUNTIME` setzen

Helix braucht zusätzlich den `runtime/`-Ordner aus dem Repository. Dauerhaft für alle neuen Shells:

```powershell
setx HELIX_RUNTIME "$env:USERPROFILE\src\helix\runtime"
```

## 5. Installation prüfen

Neue PowerShell öffnen, dann:

```powershell
hx --health
```

Liefert bei Erfolg einen Statusbericht zu Runtime, Syntaxgrammatiken und LSP.

## Nützliche Zusatzbefehle

```powershell
hx --grammar fetch
hx --grammar build
```

Automatisches Bauen der Grammatiken deaktivieren:

```powershell
setx HELIX_DISABLE_AUTO_GRAMMAR_BUILD 1
```

## Ergebnis

- Quellcode liegt unter `src\helix`
- Binary unter `.cargo\bin\hx.exe`
- Runtime ist per `HELIX_RUNTIME` registriert

## Verwandt

- [[03-Installation]] – Windows (Scoop), Linux, Startkonfiguration
- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Bedienung
