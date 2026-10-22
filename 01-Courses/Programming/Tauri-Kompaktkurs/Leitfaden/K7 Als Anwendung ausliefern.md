---
title: Als Anwendung ausliefern
modul: K7
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden, flatpak, tauri]
status: active
---

# K7 – Als Anwendung ausliefern

## Inhaltsübersicht

- Was bisher lief
- Die drei Zusatzdateien
- Bauen
- Installieren und starten
- Was jetzt anders ist
- Abschluss
- Typische Stolperstellen
- Stand am Ende des Moduls

Am Ende steht die eigene Anwendung im Anwendungsmenü und startet ohne Editor und ohne Terminal. Das ist der Abschluss, an den sich die Teilnehmenden erinnern werden.

> [!important] Format dieses Moduls
> Geführte Mitmach-Vorführung. Alle Dateien sind vorbereitet, die Teilnehmenden tippen die Befehle mit und schauen zu, was passiert. Es wird nichts selbst geschrieben. Bei drei Personen ist das gut steuerbar.

## Was bisher lief

`cargo tauri dev` startet einen **Entwicklungslauf**. Das Programm existiert nur, solange das Terminal offen ist. Eine echte Anwendung soll ohne das auskommen.

| | Entwicklungslauf | Installierte Anwendung |
|---|---|---|
| Start | `cargo tauri dev` | Anwendungsmenü |
| Terminal | muss offen sein | wird nicht gebraucht |
| Code | wird bei jeder Änderung neu übersetzt | bleibt, wie er gebaut wurde |
| Daten | im Entwicklungsordner | im eigenen Anwendungsbereich |

> „Sie haben die ganze Zeit eine-application-in-development gebaut. Jetzt wird daraus eine application."

## Die drei Zusatzdateien

Gemeinsam ansehen, nicht schreiben:

| Datei | Zweck, in einem Satz |
|---|---|
| `de.metarow.Lernkarten.desktop` | Der Eintrag im Anwendungsmenü: Name, Symbol, was gestartet wird |
| `de.metarow.Lernkarten.metainfo.xml` | Beschreibungstext, wie man ihn in einem App-Store sieht |
| `de.metarow.Lernkarten.yml` | Bauanleitung: was gebraucht wird und wohin es installiert wird |

In der `.desktop`-Datei darf jede Person ihren **eigenen Anzeigenamen** eintragen. Diese eine Änderung ist erlaubt und macht das Ergebnis persönlich.

> [!note] Warum drei Dateien für ein kleines Programm?
> Weil das Format für alle gilt. Jede Anwendung, die als Flatpak ausgeliefert wird, braucht diese drei Dateien – egal wie groß sie ist. Sie sind Eintrittskarten, nicht Eigenheiten dieses Projekts.

## Bauen

Auf dem Host, **außerhalb** des Containers:

```nu
exit
cd ~/Projekte/lernkarten

flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Lernkarten.yml
```

> [!warning] Das `exit` nicht vergessen
> Der Bau läuft nicht im Container, sondern auf dem Host. Wer im Container bleibt, bekommt eine Fehlermeldung, die nichts mit dem eigentlichen Problem zu tun hat.

Während der Bau läuft, wird erklärt, was gerade passiert: Das Programm wird noch einmal gebaut, diesmal in einer abgeschlossenen Umgebung, damit es auf jedem Rechner gleich läuft.

> [!note] Der Bau dauert spürbar länger
> Vorher ansagen. Sonst wirkt es wie ein Absturz – es wird nur viel Text durch das Terminal geschrieben.

## Installieren und starten

```nu
flatpak remote-add --user --no-gpg-verify --if-not-exists lernkarten-lokal $"($env.PWD)/repo"
flatpak install --user lernkarten-lokal de.metarow.Lernkarten
```

Danach: Editor schließen, Terminal schließen, Anwendung über das Anwendungsmenü starten.

> [!important] Dieser Moment gehört ausdrücklich zelebriert
> Es ist der Höhepunkt des Kurses. Die Anwendung startet ohne Terminal, ohne Editor, ohne eine einzige getippte Zeile. Kurz stehen bleiben und das wirken lassen.

## Was jetzt anders ist

Die Karten aus dem Entwicklungslauf sind **nicht** da. Warum?

```nu
ls ~/.local/share | where name =~ "Lernkarten"
ls ~/.var/app/de.metarow.Lernkarten/data
```

Die installierte Anwendung hat einen **eigenen, abgetrennten Bereich**. Die Karten des Entwicklungslaufs liegen in `~/.local/share`, die der installierten Anwendung in `~/.var/app`.

> [!danger] Das ist kein Fehler
> Das ist der Preis der Trennung – und die Trennung ist der Grund, warum die Anwendung sicher ist. Eine installierte Anwendung darf nicht einfach in die Dateien des Benutzers schreiben. Deshalb hat sie ihren eigenen Bereich.
>
> Wer hier enttäuscht ist, hat das falsche Bild: Der eigene Bereich ist nicht ein Verlust, sondern der Grund, warum Flatpak-Apps funktionieren.

Was das für Sicherheit bedeutet, in zwei Sätzen – die Berechtigungen anzeigen:

```nu
flatpak info --show-permissions de.metarow.Lernkarten
```

> „Die Anwendung darf nur das, was hier steht. Sie kommt nicht an Ihre übrigen Dateien."

## Abschluss

Rückblick über den Kurs anhand der eigenen Anwendung. Jede Person nennt **eine** Sache, die sie überrascht hat.

Die wichtigsten Stationen, an denen vorbeigekommen wurde:

| Station | Was dort entstand |
|---|---|
| [[K0 Ankommen und erste eigene Änderung]] | Die drei Dateien: was da ist, wie es aussieht, was passiert |
| [[K1 HTML – die Struktur]] | Die Oberfläche, jedes Element mit einem Namen |
| [[K2 CSS – das Aussehen]] | Der Sprung von einer Sammlung von Feldern zu etwas, das man zeigen möchte |
| [[K3 JavaScript – die Bausteine]] | Die Sprache, mit der die Anwendung denkt |
| [[K4 JavaScript im Fenster]] | Die Verbindung zwischen Daten und Fenster |
| [[K5 Daten behalten]] | Die Brücke zum Programmkern, die Datei auf der Platte |
| [[K6 Feinschliff]] | Die eigene Gestaltung, die eigene Verbesserung |
| [[K7 Als Anwendung ausliefern]] | Der Eintrag im Anwendungsmenü |

Ausblick auf [[00 Kurskonzept Tauri]] und den empfohlenen Zwischenschritt: ein vertiefender Web-Grundlagenkurs mit CSS Grid, Formularverarbeitung, Funktionen höherer Ordnung und asynchroner Programmierung.

## Typische Stolperstellen

> [!warning]
> - Der Bau dauert spürbar länger. Vorher ansagen.
> - Der Bau läuft nicht im Container, sondern auf dem Host. Das `exit` wird vergessen.
> - Die Anwendung erscheint im Menü erst nach kurzer Verzögerung.
> - Enttäuschung über die fehlenden Karten. Als Lerninhalt einplanen, nicht als Panne behandeln.
> - Bei Zugriffsfehlern: `flatpak override --user --filesystem=home org.flatpak.Builder`

## Stand am Ende des Moduls

- [ ] Den Anzeigenamen in der `.desktop`-Datei angepasst
- [ ] Das Flatpak gebaut und installiert
- [ ] Die Anwendung ohne Terminal aus dem Menü gestartet
- [ ] Beide Datenordner aufgesucht und den Unterschied benannt
- [ ] Die Berechtigungen angezeigt und vorgelesen
- [ ] Den Weg von der `index.html` bis zum Menüeintrag beschrieben

## Verknüpfung

Merkblatt: [[K7 Merkblatt]] · Übungen: [[K7 Übungsblatt]] · [[Anhang Befehlskarte]]
Zurück zu [[00 Kompaktkurs Tauri Grundlagen]] · Anschluss: [[00 Kurskonzept Tauri]]
