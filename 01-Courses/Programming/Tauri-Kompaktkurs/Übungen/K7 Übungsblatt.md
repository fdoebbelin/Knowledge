---
title: Als Anwendung ausliefern – Übungen
modul: K7
typ: uebungsblatt
tags: [tauri/kompaktkurs/uebung, flatpak, tauri]
status: active
---

# K7 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Zwei Arten, eine Anwendung zu starten
- F2 Die drei Zusatzdateien
- F3 Die Befehle und ihre Bedeutung
- F4 Warum die Karten aus dem Entwicklungslauf fehlen
- F5 Die Berechtigungen
- F6 Der Weg von der `index.html` bis zum Menüeintrag

---

## F1 Welche Unterschiede bestehen zwischen dem Entwicklungslauf und der installierten Anwendung?

| | Entwicklungslauf | Installierte Anwendung |
|---|---|---|
| Wie wird sie gestartet? | | |
| Wird ein Terminal gebraucht? | | |
| Was passiert mit dem Code bei einer Änderung? | | |
| Wo liegen die Daten? | | |

> [!success]- Antwort F1
> | | Entwicklungslauf | Installierte Anwendung |
> |---|---|---|
> | Start | `cargo tauri dev` | Anwendungsmenü |
> | Terminal | muss offen sein | wird nicht gebraucht |
> | Code | wird bei jeder Änderung neu übersetzt | bleibt, wie er gebaut wurde |
> | Daten | im Entwicklungsordner | im eigenen Anwendungsbereich |
>
> **Merksatz:** Der Entwicklungslauf ist das Werkzeug zum Bauen. Die installierte Anwendung ist das Ergebnis.

---

## F2 Was ist die Aufgabe der drei Zusatzdateien? Ordnen Sie zu.

| Datei | Aufgabe |
|---|---|
| `de.metarow.Lernkarten.desktop` | |
| `de.metarow.Lernkarten.metainfo.xml` | |
| `de.metarow.Lernkarten.yml` | |

> [!success]- Antwort F2
> | Datei | Aufgabe |
> |---|---|
> | `de.metarow.Lernkarten.desktop` | Der Eintrag im Anwendungsmenü: Name, Symbol, was gestartet wird |
> | `de.metarow.Lernkarten.metainfo.xml` | Beschreibungstext, wie man ihn in einem App-Store sieht |
> | `de.metarow.Lernkarten.yml` | Bauanleitung: was gebraucht wird und wohin es installiert wird |
>
> **Warum drei Dateien für ein kleines Programm?** Weil das Format für alle gilt. Jede Anwendung, die als Flatpak ausgeliefert wird, braucht diese drei Dateien – egal wie groß sie ist. Sie sind Eintrittskarten, nicht Eigenheiten dieses Projekts.
>
> **Die eine erlaubte Änderung:** In der `.desktop`-Datei darf jede Person ihren eigenen **Anzeigenamen** eintragen.

---

## F3 Was macht der jeweilige Teil des Build-Befehls?

```nu
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Lernkarten.yml
```

| Teil | Bedeutung |
|---|---|
| `flatpak run` | |
| `org.flatpak.Builder` | |
| `--force-clean` | |
| `--repo=repo` | |
| `build-dir` | |
| `de.metarow.Lernkarten.yml` | |

> [!success]- Antwort F3
> | Teil | Bedeutung |
> |---|---|
> | `flatpak run` | ein Flatpak-Werkzeug starten |
> | `org.flatpak.Builder` | das Werkzeug, das aus der Bauanleitung ein Programm baut |
> | `--force-clean` | alten Bauvorgang verwerfen und neu anfangen |
> | `--repo=repo` | das fertige Paket in das Verzeichnis `repo` legen |
> | `build-dir` | der Ordner mit dem Zwischenergebnis |
> | `de.metarow.Lernkarten.yml` | die Bauanleitung, die gelesen wird |
>
> **Zwei Hinweise, die beim Bauen wichtig sind:**
> 1. Der Bau läuft **auf dem Host**, nicht im Container. Wer im Container bleibt, bekommt eine Fehlermeldung, die nichts mit dem eigentlichen Problem zu tun hat.
> 2. Der Bau **dauert spürbar länger**. Es wird nur viel Text durch das Terminal geschrieben – das ist kein Absturz.

---

## F4 Nach der Installation sind die Karten aus dem Entwicklungslauf verschwunden. Warum? Ist das ein Fehler?

> [!success]- Antwort F4
> **Nein, das ist kein Fehler.** Die installierte Anwendung hat einen **eigenen, abgetrennten Bereich**.
>
> | | Entwicklungslauf | Installierte Anwendung |
> |---|---|---|
> | Ordner | `~/.local/share/de.metarow.Lernkarten` | `~/.var/app/de.metarow.Lernkarten/data` |
> | Datei | `lernkarten.json` | `lernkarten.json` |
>
> **Der Grund:** Eine installierte Anwendung darf nicht einfach in die Dateien des Benutzers schreiben. Deshalb hat sie ihren eigenen Bereich – die Trennung ist der Grund, warum die Anwendung sicher ist.
>
> Wer hier enttäuscht ist, hat das falsche Bild: Der eigene Bereich ist kein Verlust, sondern die Bedingung dafür, dass Flatpak-Anwendungen funktionieren.

---

## F5 Was bedeutet es, wenn die Anwendung nur auf das zugreifen darf, was in den Berechtigungen steht? Was folgt daraus?

> [!success]- Antwort F5
> Die Berechtigungen sind die Liste dessen, was die Anwendung auf dem Rechner darf. Steht dort nur, was sie wirklich braucht, kommt sie an alles andere nicht heran.
>
> **Die Folge:** Die Anwendung kann nicht auf die Dateien des Benutzers zugreifen. Sie kann auch keine anderen Programme ausspionieren oder Daten verschicken, ohne dass es im System sichtbar wäre.
>
> **Das ist der Preis des Formats** – und deshalb ist es der Weg, den eine ausgelieferte Anwendung geht. Umgekehrt gilt: Wenn eine Anwendung mehr Berechtigungen braucht als sie eigentlich braucht, ist das eine Frage, die man stellen sollte.

---

## F6 Beschreiben Sie den Weg von der `index.html` bis zum Menüeintrag. Welcher Schritt erzeugt was?

| Schritt | Ergebnis |
|---|---|
| Die drei Dateien im Projekt | |
| Der Build-Befehl | |
| `flatpak remote-add` | |
| `flatpak install` | |

> [!success]- Antwort F6
> | Schritt | Ergebnis |
> |---|---|
> | Die drei Dateien im Projekt | die Beschreibung: Menüeintrag, Beschreibungstext, Bauanleitung |
> | Der Build-Befehl | aus der Bauanleitung entsteht ein fertiges Paket im Verzeichnis `repo` |
> | `flatpak remote-add` | das Verzeichnis `repo` wird als Paketquelle eingetragen |
> | `flatpak install` | die Anwendung ist installiert und erscheint im Anwendungsmenü |
>
> **Der Vollständigkeit halber:** Die `index.html` selbst wird beim Bauen mit in das Paket gelegt – sie ist die Datei, die das Fenster zeigt. Was oben beschrieben wird, sind die drei Zusatzdateien, die **um** diese Anwendung herum kommen.
>
> **Und der letzte Schritt:** Nach der Installation wird die Anwendung **ohne Terminal** gestartet. Das ist der Punkt, an dem aus einem Projekt eine Anwendung wird.

---

## Verknüpfung

Leitfaden: [[K7 Als Anwendung ausliefern]] · Merkblatt: [[K7 Merkblatt]] · [[Anhang Befehlskarte]]
Zurück zu [[00 Kompaktkurs Tauri Grundlagen]] · Anschluss: [[00 Kurskonzept Tauri]]
