---
baustein: K7
titel: Als Anwendung ausliefern
ue: 3
tag: 4
tags: [tauri/kompaktkurs/baustein, flatpak]
status: entwurf
---

# K7 – Als Anwendung ausliefern

> [!abstract] Ziel des Bausteins
> Am Ende steht die eigene Anwendung im Anwendungsmenü und startet ohne Editor und ohne Terminal. Das ist der Abschluss, an den sich die Teilnehmenden erinnern werden.

> [!important] Format des Bausteins
> Geführte Mitmach-Vorführung. Alle Dateien sind vorbereitet, die Teilnehmenden tippen die Befehle mit und schauen zu, was passiert. Es wird nichts selbst geschrieben. Bei drei Personen ist das gut steuerbar.

## Lernziele

- Den Unterschied zwischen Entwicklungslauf und installierter Anwendung benennen
- Die drei Zusatzdateien und ihren Zweck erkennen
- Die Bau- und Installationsbefehle ausführen
- Beschreiben, warum die Anwendung ihre Daten nach der Installation woanders ablegt

## Ablauf

### 1. Was bisher lief (20 min)

`cargo tauri dev` startet einen Entwicklungslauf. Das Programm existiert nur, solange das Terminal offen ist. Eine echte Anwendung soll ohne das auskommen.

### 2. Die drei Zusatzdateien (30 min)

Gemeinsam ansehen, nicht schreiben:

| Datei | Zweck, in einem Satz |
|---|---|
| `de.metarow.Lernkarten.desktop` | Der Eintrag im Anwendungsmenü: Name, Symbol, was gestartet wird |
| `de.metarow.Lernkarten.metainfo.xml` | Beschreibungstext, wie man ihn in einem App-Store sieht |
| `de.metarow.Lernkarten.yml` | Bauanleitung: was gebraucht wird und wohin es installiert wird |

Im `.desktop` darf jede Person ihren eigenen Anzeigenamen eintragen. Diese eine Änderung ist erlaubt und macht das Ergebnis persönlich.

### 3. Bauen (45 min)

Auf dem Host, außerhalb des Containers:

```nu
exit
cd ~/Projekte/lernkarten

flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Lernkarten.yml
```

Während der Bau läuft, wird erklärt, was gerade passiert: Das Programm wird noch einmal gebaut, diesmal in einer abgeschlossenen Umgebung, damit es auf jedem Rechner gleich läuft.

### 4. Installieren und starten (30 min)

```nu
flatpak remote-add --user --no-gpg-verify --if-not-exists lernkarten-lokal $"($env.PWD)/repo"
flatpak install --user lernkarten-lokal de.metarow.Lernkarten
```

Danach: Editor schließen, Terminal schließen, Anwendung über das Anwendungsmenü starten. Dieser Moment gehört ausdrücklich zelebriert.

### 5. Was jetzt anders ist (25 min)

Die Karten aus dem Entwicklungslauf sind nicht da. Warum?

```nu
ls ~/.local/share | where name =~ "Lernkarten"
ls ~/.var/app/de.metarow.Lernkarten/data
```

Die installierte Anwendung hat einen eigenen, abgetrennten Bereich. Was das für Sicherheit bedeutet, in zwei Sätzen:

```nu
flatpak info --show-permissions de.metarow.Lernkarten
```

Die Anwendung darf nur das, was hier steht. Sie kommt nicht an Ihre übrigen Dateien.

### 6. Abschluss (15 min)

Rückblick über die vier Tage anhand der eigenen Anwendung. Jede Person nennt eine Sache, die sie überrascht hat.

Ausblick auf [[00 Kurskonzept Tauri]] und den empfohlenen Zwischenschritt.

## Praxisteil

- [ ] Anzeigenamen in der `.desktop`-Datei anpassen
- [ ] Flatpak bauen und installieren
- [ ] Anwendung ohne Terminal aus dem Menü starten
- [ ] Beide Datenordner aufsuchen und den Unterschied benennen
- [ ] Berechtigungen anzeigen lassen und vorlesen
- [ ] Bundle erzeugen, falls die Anwendung mitgenommen werden soll:

```nu
flatpak build-bundle repo lernkarten.flatpak de.metarow.Lernkarten --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo
```

## Typische Stolpersteine

> [!warning]
> - Der Bau dauert mehrere Minuten. Vorher ansagen.
> - Der Bau läuft nicht im Container, sondern auf dem Host. Das `exit` wird vergessen.
> - Die Anwendung erscheint im Menü erst nach kurzer Verzögerung.
> - Enttäuschung über die fehlenden Karten. Als Lerninhalt einplanen, nicht als Panne behandeln.
> - Bei Zugriffsfehlern: `flatpak override --user --filesystem=home org.flatpak.Builder`

## Verknüpfung

Zurück zu [[00 Kompaktkonzept Tauri Grundlagen]] · Anschluss: [[00 Kurskonzept Tauri]]
