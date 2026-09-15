# Obsidian Vault Migration - README

## 📋 Überblick

Dieses Skript reorganisiert Ihren Obsidian Vault "Research" in eine neue, besser strukturierte Version namens "Knowledge".

## ✅ Was das Skript tut

1. **Erstellt eine KOPIE** - Ihr Original bleibt als Backup erhalten
2. **Umbenennung**: "Research" → "Knowledge"
3. **Reorganisation**: Trennt Kurse von technischer Dokumentation
4. **Flache Hierarchie**: Maximal 2-3 Ebenen Tiefe
5. **Englische Namen**: Kurze, prägnante Ordnernamen
6. **Präfixe**: Numerische Sortierung (01-, 02-, etc.)

## 🎯 Neue Struktur

```
Knowledge/
├── 01-Courses/         # Alle strukturierten Lernmaterialien
│   ├── Programming/    # Python, JavaScript, Grundlagen
│   ├── Databases/      # SQL, Datenbanken
│   ├── STEM/          # MINT-Kurse, Mathematik, Physik
│   ├── Business/      # Office, Projektmanagement, UML
│   └── Training/      # BFD, IT-Karriere, Bundeswehr
│
├── 02-Tech/           # Technische Dokumentation
│   ├── Linux/         # CatchyOS, Ubuntu, openSUSE
│   ├── Containers/    # Docker, Podman, WSL
│   └── DevTools/      # Git, Nushell, Scoop, etc.
│
├── 03-Projects/       # Ihre aktiven Projekte
│   ├── MetaRow-Player/
│   ├── Python-Projects/
│   └── Py2Rust/
│
├── 04-Software/       # Software-Dokumentation
│   ├── Cloud/         # NextCloud
│   ├── Dev/          # AutoDesk, Drupal, Flask
│   └── AI/           # IOPaint, OpenClaw, LM Studio
│
├── 05-Languages/      # Programmiersprachen (nicht Kurse!)
│   ├── Rust/
│   ├── Python/
│   └── OCaml/
│
└── 06-Notes/          # Notizen und Referenzen
    ├── Clippings/     # Artikel-Sammlung
    ├── Important/     # Wichtige Notizen
    └── Personal/      # Gesundheit, Rezepte, Yoga
```

## 🚀 Ausführung

### Voraussetzungen
- Windows PowerShell
- Obsidian geschlossen (empfohlen)
- Mindestens 500 MB freier Speicherplatz

### Schritt-für-Schritt

1. **PowerShell öffnen**
   - Rechtsklick auf `migrate-vault.ps1`
   - "Mit PowerShell ausführen"
   
   **ODER** per Terminal:
   ```powershell
   cd "C:\Users\fritz\Desktop"
   .\migrate-vault.ps1
   ```

2. **Bestätigung**
   - Das Skript fragt nach Bestätigung
   - Eingabe: `j` (für "ja") + Enter

3. **Warten**
   - Die Migration dauert ca. 2-5 Minuten
   - 1600+ Dateien werden kopiert

4. **Fertig!**
   - Statistik wird angezeigt
   - Original bleibt als Backup erhalten

## 📊 Was wird migriert

### ✅ Kurse (→ 01-Courses/)
- Python Grundlagen (Teil 1 & 2)
- SQL & Datenbanken
- MINT-Einführung
- Projektmanagement (M01-M21)
- Office Basics (Word & Excel)
- UML, JavaScript, BFD-Lerngänge

### ✅ Technik (→ 02-Tech/)
- Linux-Distributionen
- Container-Technologien
- Entwicklungstools

### ✅ Projekte (→ 03-Projects/)
- MetaRow-Player
- Python-Projekte
- Py2Rust

### ✅ Software (→ 04-Software/)
- Cloud-Dienste
- Development-Tools
- AI-Anwendungen

### ✅ Sprachen (→ 05-Languages/)
- Rust-Notizen
- Python-Referenzen
- OCaml-Dokumentation

### ✅ Notizen (→ 06-Notes/)
- Clippings
- Wichtige Notizen
- Persönliches

## ⚠️ Wichtige Hinweise

### Sicherheit
- ✅ **Backup**: Original bleibt erhalten
- ✅ **Kein Risiko**: Nur Kopieren, kein Löschen
- ✅ **Rollback**: Einfach "Knowledge" löschen

### Nach der Migration

1. **Obsidian öffnen**
   - "Vault öffnen"
   - Wählen Sie: `Knowledge`

2. **Überprüfen**
   - Stichproben in verschiedenen Ordnern
   - Sind alle Dateien da?

3. **Links aktualisieren**
   - Obsidian hat eine Funktion: "Update internal links"
   - Bei Bedarf nutzen

4. **Aufräumen** (optional)
   - Wenn alles gut ist: "Research" löschen
   - Vorher nochmal prüfen!

## 🔧 Problemlösung

### "Execution Policy" Fehler
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```
Dann Skript erneut ausführen.

### Zielordner existiert bereits
Löschen Sie `Knowledge` oder benennen Sie ihn um.

### Ordner fehlt nach Migration
Prüfen Sie:
1. Existierte der Ordner in "Research"?
2. Schauen Sie in das Skript-Log
3. Manuell kopieren aus Backup

## 📞 Support

### Logs
Das Skript zeigt während der Ausführung an:
- ✓ Erfolgreich kopiert (grün)
- ⚠ Nicht gefunden (gelb)

### Statistik am Ende
- Anzahl migrierter Ordner
- Anzahl übersprungener Ordner

## 🎯 Empfohlene Tags nach Migration

Sie könnten folgende Tags in Ihren Notizen verwenden:

**Kurse:**
- `#course/programming`
- `#course/database`
- `#course/business`

**Projekte:**
- `#project/active`
- `#project/archived`

**Technik:**
- `#tech/linux`
- `#tech/docker`
- `#tech/tutorial`

**Status:**
- `#status/todo`
- `#status/done`
- `#status/wip`

## 📝 Changelog

### Version 1.0 (2025-02-11)
- Initiale Version
- Trennung Kurse vs. Technik
- Flache Hierarchie
- Englische Ordnernamen
- Auflösung "99 MODULE"
