---
title: Ankommen und erste eigene Änderung – Merkblatt
modul: K0
typ: merkblatt
aliases:
  - K0b Handout
tags: [tauri/kompaktkurs/merkblatt]
status: active
---

# K0 – Merkblatt

## Die drei Dateien

| Datei | Zuständig für |
|---|---|
| `index.html` | was da ist |
| `style.css` | wie es aussieht |
| `app.js` | was passiert |

## Die Anwendung starten

```nu
toolbox enter tauri-dev
cd ~/Projekte/lernkarten
cargo tauri dev
```

| Zeile | Bedeutung |
|---|---|
| `toolbox enter tauri-dev` | Wechselt in den **Container** – eine abgetrennte Umgebung, in der alle Werkzeuge zum Bauen liegen. Das eigentliche System bleibt unberührt. |
| `cd ~/Projekte/lernkarten` | Wechselt in den Ordner des Projekts. `cd` steht für *change directory*. |
| `cargo tauri dev` | Baut das Programm und öffnet das Fenster. |

Beenden: im Terminal `Strg` + `C`, danach `exit`.

## Woran erkenne ich, wo ich bin?

Im Container steht ein **Sechseck** ⬢ vorne in der Eingabezeile. Sicher prüfbar:

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

## Fenster nebeneinander

Editor links, Anwendung rechts:

```nu
swaymsg splith
```

## Arbeiten am Quelltext

Der Text steht **zwischen** den Marken, nicht innerhalb der spitzen Klammern:

```html
<h1>Lernkarten</h1>
<h1>Lernkarten von Anna</h1>
```

> [!tip] Der Ablauf für den ganzen Kurs
> **Ändern → Speichern → Hinsehen.** Nach jeder einzelnen Änderung.
>
> Erscheint die Änderung nicht: Rechtsklick ins Anwendungsfenster → **Neu laden**.

## Drei Sätze für den ganzen Kurs

1. **Kaputtmachen ist erlaubt.** Es geht nichts verloren.
2. **Der Rechner sagt meistens, wo das Problem liegt.**
3. **Jeder baut Fehler ein.** Der Unterschied ist nur, wie schnell man sie findet.

## Wenn etwas nicht funktioniert

| Was zu sehen ist | Was zu tun ist |
|---|---|
| Das Fenster bleibt weiß | Kursleitung ansprechen |
| Die Änderung erscheint nicht | Gespeichert? Richtige Datei? Rechtsklick → Neu laden |
| Roter Text im Terminal | Die **erste** Zeile laut vorlesen, dann gemeinsam schauen |
| Das Terminal reagiert nicht mehr | `Strg` + `C` |
| Gar nichts geht mehr | Terminal schließen, neu anfangen. Es geht nichts verloren. |

## Wörter

| Wort | Bedeutung in einem Satz |
|---|---|
| **Terminal** | Das Fenster, in das Befehle getippt werden. |
| **Container** | Eine abgetrennte Umgebung im Rechner, in der die Werkzeuge zum Bauen liegen. |
| **Toolbx** | Das Programm, mit dem dieser Container betreten wird. |
| **Quelltext** | Der Text, aus dem das Programm besteht. |
| **Entwicklungslauf** | Das Programm läuft nur, solange das Terminal offen ist. Ab [[K7 Als Anwendung ausliefern]] geht es auch ohne. |

## Verknüpfung

Leitfaden: [[K0 Ankommen und erste eigene Änderung]] · Übungen: [[K0 Übungsblatt]] · [[Anhang Befehlskarte]]
Weiter mit [[K1 HTML – die Struktur]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]
