---
title: Als Anwendung ausliefern – Merkblatt
modul: K7
typ: merkblatt
tags: [tauri/kompaktkurs/merkblatt, flatpak, tauri]
status: active
---

# K7 – Merkblatt

## Entwicklungslauf und installierte Anwendung

| | Entwicklungslauf | Installierte Anwendung |
|---|---|---|
| Start | `cargo tauri dev` | Anwendungsmenü |
| Terminal | muss offen sein | wird nicht gebraucht |
| Code | wird bei jeder Änderung neu übersetzt | bleibt, wie er gebaut wurde |
| Daten | im Entwicklungsordner | im eigenen Anwendungsbereich |

## Die drei Zusatzdateien

| Datei | Zweck, in einem Satz |
|---|---|
| `de.metarow.Lernkarten.desktop` | Der Eintrag im Anwendungsmenü: Name, Symbol, was gestartet wird |
| `de.metarow.Lernkarten.metainfo.xml` | Beschreibungstext, wie man ihn in einem App-Store sieht |
| `de.metarow.Lernkarten.yml` | Bauanleitung: was gebraucht wird und wohin es installiert wird |

Die `.desktop`-Datei darf einen **eigenen Anzeigenamen** bekommen.

## Bauen

Zuerst aus dem Container heraus – der Bau läuft auf dem Host:

```nu
exit
cd ~/Projekte/lernkarten

flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Lernkarten.yml
```

| Teil | Bedeutung |
|---|---|
| `flatpak run` | ein Flatpak-Werkzeug starten |
| `org.flatpak.Builder` | das Werkzeug, das aus der Bauanleitung ein Programm baut |
| `--force-clean` | alten Bauvorgang verwerfen und neu anfangen |
| `--repo=repo` | das fertige Paket in das Verzeichnis `repo` legen |
| `build-dir` | der Ordner mit dem Zwischenergebnis |
| `de.metarow.Lernkarten.yml` | die Bauanleitung, die gelesen wird |

> **Der Bau dauert spürbar länger.** Es wird nur viel Text durch das Terminal geschrieben.

## Installieren und starten

```nu
flatpak remote-add --user --no-gpg-verify --if-not-exists lernkarten-lokal $"($env.PWD)/repo"
flatpak install --user lernkarten-lokal de.metarow.Lernkarten
flatpak run de.metarow.Lernkarten
```

| Befehl | Was er tut |
|---|---|
| `flatpak remote-add` | das lokale Verzeichnis `repo` als Paketquelle eintragen |
| `flatpak install` | die Anwendung aus dieser Quelle installieren |
| `flatpak run` | die installierte Anwendung starten |

Danach: Editor schließen, Terminal schließen, über das Anwendungsmenü starten.

## Die beiden Datenordner

```nu
ls ~/.local/share | where name =~ "Lernkarten"     # Entwicklungslauf
ls ~/.var/app/de.metarow.Lernkarten/data          # installierte Anwendung
```

| | Entwicklungslauf | Installierte Anwendung |
|---|---|---|
| Ordner | `~/.local/share/de.metarow.Lernkarten` | `~/.var/app/de.metarow.Lernkarten/data` |
| Datei | `lernkarten.json` | `lernkarten.json` |

> **Die Karten aus dem Entwicklungslauf sind in der installierten Anwendung nicht da.** Das ist kein Fehler, sondern der Preis der Trennung: Eine installierte Anwendung darf nicht einfach in die Dateien des Benutzers schreiben. Deshalb hat sie ihren eigenen Bereich.

## Die Berechtigungen

```nu
flatpak info --show-permissions de.metarow.Lernkarten
```

Die Anwendung darf nur das, was dort steht. Sie kommt nicht an die übrigen Dateien.

## Ein Bundle zum Mitnehmen

```nu
flatpak build-bundle repo lernkarten.flatpak de.metarow.Lernkarten --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo
```

Ergebnis ist die Datei `lernkarten.flatpak` – eine einzelne Datei, die auf einen anderen Rechner mitgebracht werden kann.

## Diagnose

| Beobachtung | Ursache |
|---|---|
| Der Bau startet nicht | noch im Container – erst `exit` |
| Der Bau läuft, es passiert lange nichts | normal. Der Bau dauert spürbar länger. |
| Die Anwendung erscheint im Menü erst spät | das Nachlaufen des Menüs dauert einen Moment |
| Die Karten aus dem Entwicklungslauf fehlen | eigener Datenbereich der installierten Anwendung |
| Beim Zugriff auf Dateien gibt es einen Fehler | `flatpak override --user --filesystem=home org.flatpak.Builder` |

## Wörter

| Wort | Bedeutung in einem Satz |
|---|---|
| **Flatpak** | Ein Format, in dem Anwendungen als Pakete ausgeliefert werden. |
| **Bauen** | Aus dem Quelltext ein installierbares Paket machen. |
| **`.desktop`-Datei** | Der Eintrag im Anwendungsmenü. |
| **`.metainfo.xml`** | Der Beschreibungstext der Anwendung. |
| **`.yml`** | Die Bauanleitung. |
| **Bundle** | Eine einzelne Datei, die das fertige Paket enthält. |
| **Berechtigung** | Was die Anwendung auf dem Rechner darf. |

## Verknüpfung

Leitfaden: [[K7 Als Anwendung ausliefern]] · Übungen: [[K7 Übungsblatt]] · [[Anhang Befehlskarte]]
Zurück zu [[00 Kompaktkurs Tauri Grundlagen]] · Anschluss: [[00 Kurskonzept Tauri]]
