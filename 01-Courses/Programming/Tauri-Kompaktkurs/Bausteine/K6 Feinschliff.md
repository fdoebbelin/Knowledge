---
baustein: K6
title: Feinschliff
ue: 2
kurstag: 4
tags: [tauri/kompaktkurs/baustein, css, ux]
status: draft
---

# K6 – Feinschliff

> [!abstract] Ziel des Bausteins
> Jede Person macht die Anwendung zu ihrer eigenen. Kein neuer Stoff, sondern Anwenden und Festigen des Gelernten. Gleichzeitig Pufferzone im Zeitplan.

> [!note] Reservefunktion
> Wenn [[K3 JavaScript – die Bausteine]] mehr Zeit gebraucht hat, wird dieser Baustein auf 1 UE gekürzt. Er enthält bewusst nichts, was für [[K7 Als Anwendung ausliefern]] nötig ist.

## Lernziele

- Gelerntes ohne Anleitung anwenden
- Eine eigene Gestaltungsentscheidung treffen und begründen
- Eine kleine Verbesserung selbstständig planen und umsetzen

## Ablauf

### 1. Eigene Gestaltung (45 min)

Freie Arbeit an `style.css`. Vorgabe ist nur: Die Anwendung muss bedienbar bleiben und die drei Farben müssen zueinander passen.

Anregungen, aus denen gewählt wird:
- eigenes Farbschema
- andere Schriftgröße für Frage und Antwort
- Karte optisch hervorheben, etwa mit Rahmen und Schatten
- Knöpfe unterscheidbar gestalten, wichtigster Knopf auffälliger

### 2. Eine eigene Verbesserung (30 min)

Jede Person wählt genau eine aus:

| Verbesserung | Was dafür gebraucht wird |
|---|---|
| Anzahl der Karten anzeigen | `karten.length`, `textContent` |
| Löschknopf pro Listeneintrag | `createElement`, `addEventListener` |
| Leere Eingabe abfangen | `if`, `.value`, `.trim()` |
| Antwort erst nach Klick zeigen | `if`, `textContent` |
| Karten zählen, die schon gezeigt wurden | Zähler-Variable, `if` |

### 3. Vorstellen (15 min)

Jede Person zeigt der Gruppe ihre Anwendung und erklärt eine getroffene Entscheidung. Drei Personen, jeweils fünf Minuten.

## Praxisteil

- [ ] Eigenes Farbschema umsetzen
- [ ] Eine Verbesserung auswählen und umsetzen
- [ ] Anwendung der Gruppe vorstellen
- [ ] Stand sichern, bevor K7 beginnt

## Typische Stolpersteine

> [!warning]
> - Zu viel auf einmal vorgenommen. Auf **eine** Verbesserung bestehen.
> - Bestehender Code wird beim Umbauen beschädigt. Vorher eine Kopie der Datei anlegen lassen.
> - Kontrast zwischen Text und Hintergrund wird zu gering. Kurz gegenprüfen, das ist zugleich eine Miniatur-Lektion in Barrierefreiheit.

## Verknüpfung

Weiter mit [[K7 Als Anwendung ausliefern]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]
