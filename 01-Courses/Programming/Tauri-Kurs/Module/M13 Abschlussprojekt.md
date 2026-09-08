---
modul: M13
titel: Abschlussprojekt
ue: 8
phase: Transfer
ort: beide
tags: [tauri/kurs/modul, projekt, bewertung]
status: entwurf
---

# M13 – Abschlussprojekt

> [!abstract] Worum es geht
> Eine eigene Anwendung in Zweierteams, von der Idee bis zum installierten Flatpak. Die Abnahme erfolgt ausdrücklich **nicht** über `cargo tauri dev`, sondern über die installierte Anwendung auf einem fremden Gerät.

## Rahmen

- Zweierteams, 8 Unterrichtseinheiten plus Eigenarbeit
- Eigenes Git-Repository von Beginn an
- Eigener Toolbx-Container je Team, angelegt über das Skript aus [[Anhang Container-Setup-Skript]]
- Präsentation von 10 Minuten mit Live-Vorführung des Flatpak

## Pflichtanforderungen

- [ ] Vue-3-Frontend mit mindestens fünf eigenen Komponenten
- [ ] Zentraler Zustand über Pinia
- [ ] Mindestens zwei Ansichten mit Router im Hash-Modus
- [ ] Mindestens zwei Tauri-Plugins im Einsatz
- [ ] Tauri-Capabilities **und** Flatpak-`finish-args` auf das Minimum beschränkt, schriftlich begründet
- [ ] Mindestens ein eigener Rust-Command
- [ ] Persistenz, die einen Neustart der installierten App überlebt
- [ ] Lauffähiges Flatpak, installiert aus einem lokalen Repository
- [ ] `.desktop`- und `.metainfo.xml`-Datei vollständig gepflegt
- [ ] README mit Aufbau, Bauanleitung in Nushell und Bedienung
- [ ] Der Host bleibt unverändert: `rpm-ostree status` zeigt keine gelayerten Pakete

## Ideenvorschläge

| Idee | Fachlicher Schwerpunkt |
|---|---|
| Bildbetrachter mit Stapelumbenennung | Portal-Zugriff, eigener Rust-Command |
| Lokaler Passwortsafe | Verschlüsselung in Rust, strenge Sandkasten-Rechte |
| Aufgabenverwaltung mit Benachrichtigungen | Plugins, Wayland-Realität aus Modul 09 |
| Log-Datei-Analysator | Rust-Parsing großer Dateien, Fortschritts-Events |
| Serienbrief-Werkzeug aus CSV | Datenimport, Vorschau, Export über Dialog |
| Container-Übersicht für Toolbx | eigener Rust-Command gegen `podman`, Zugriff über `/run/host` diskutieren |

## Bewertungsraster

| Kriterium | Gewicht |
|---|---|
| Frontend-Qualität: Komponentenschnitt, Reaktivität, Lesbarkeit | 25 % |
| Funktionale Vollständigkeit gegenüber der eigenen Anforderungsliste | 20 % |
| Bedienbarkeit inklusive Tastaturbedienung und Fehlerrückmeldungen | 20 % |
| Berechtigungen in beiden Schichten, begründet und minimal | 15 % |
| Sauberer Flatpak-Bau und Reproduzierbarkeit auf fremdem Gerät | 10 % |
| Dokumentation und Repository-Hygiene | 5 % |
| Präsentation | 5 % |

> [!tip] Hinweis zur Bewertung
> Der Frontend-Anteil trägt das größte Gewicht, entsprechend dem Kursschwerpunkt. Ein aufwendiger Rust-Teil bei schwachem Komponentenschnitt führt nicht zu einer besseren Note.

## Reproduzierbarkeitsprüfung

Teil der Abnahme, angelehnt an Phase 5 des Leitfadens:

```nu
toolbox rm -f TEAMCONTAINER
nu ~/.local/bin/setup-tauri-toolbox.nu
# Repository frisch klonen, bauen, installieren
```

Gelingt das nicht, fehlt Dokumentation. Das fließt in die Bewertung ein.

## Zeitplan

| UE | Inhalt |
|---|---|
| 1 | Ideenfindung, Anforderungsliste, Abnahme durch die Kursleitung |
| 2 | Komponentenentwurf, Datenmodell, Manifestentwurf, Aufgabenverteilung |
| 3–6 | Umsetzung mit begleitenden Kurzberatungen |
| 7 | Flatpak-Bau, Test auf fremdem Gerät, Dokumentation |
| 8 | Präsentationen und gegenseitige Code-Reviews |

## Verknüpfung

Zurück zu [[00 Kurskonzept Tauri]]
