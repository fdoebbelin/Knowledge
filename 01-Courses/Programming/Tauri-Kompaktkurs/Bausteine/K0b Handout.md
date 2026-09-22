---
baustein: K0
typ: handout
title: Ankommen und erste eigene Änderung – Handout
ue: 2
kurstag: 1
tags: [tauri/kompaktkurs/handout]
status: draft
---

# K0 – Ankommen und erste eigene Änderung

> [!abstract] Worum es in dieser Einheit geht
> Sie starten Ihre Anwendung zum ersten Mal, lernen die drei Dateien kennen, aus denen sie besteht, und machen Ihre erste eigene Änderung. Am Ende steht Ihr Name in einem laufenden Fenster.

---

## 1 Das Ziel des Kurses

Sie bauen eine **Lernkarten-Anwendung**: Karten mit Frage und Antwort anlegen, durchblättern, umdrehen, löschen. Am vierten Tag steht diese Anwendung in Ihrem Anwendungsmenü und startet ohne Terminal.

Heute sehen Sie beides nebeneinander: das fertige Ergebnis und Ihren Ausgangspunkt.

---

## 2 Die drei Dateien

Jede Anwendung dieser Art besteht aus drei Sorten Text. Sie liegen im Ordner `src/`:

| Datei | Vergleich | Zuständig für |
|---|---|---|
| `index.html` | Rohbau eines Hauses | **was** da ist |
| `style.css` | Anstrich und Möbel | **wie** es aussieht |
| `app.js` | die Bewohner | **was passiert** |

Heute ist nur `index.html` gefüllt. Die anderen beiden sind leer und kommen später dazu:

- `style.css` ab **K2** (Tag 1–2)
- `app.js` ab **K3** (Tag 2–3)

> [!question] Zum Selbstprüfen
> - Die Überschrift soll grün werden. Welche Datei? → `style.css`
> - Es soll einen zweiten Knopf geben. Welche Datei? → `index.html`
> - Beim Klick soll eine Karte erscheinen. Welche Datei? → `app.js`

---

## 3 Die Anwendung starten

Diese drei Zeilen brauchen Sie jeden Morgen. Sie stehen auch auf Ihrer Befehlskarte.

```nu
toolbox enter tauri-dev
cd ~/Projekte/lernkarten
cargo tauri dev
```

Was die drei Zeilen bedeuten:

| Zeile | Bedeutung |
|---|---|
| `toolbox enter tauri-dev` | Wechselt in den **Container** – eine abgetrennte Umgebung, in der alle Werkzeuge zum Bauen liegen. Ihr eigentliches System bleibt unberührt. |
| `cd ~/Projekte/lernkarten` | Wechselt in den Ordner Ihres Projekts. `cd` steht für *change directory*. |
| `cargo tauri dev` | Baut das Programm und öffnet das Fenster. |

> [!warning] Der erste Start dauert mehrere Minuten
> Dabei läuft viel Text durch das Terminal. Das ist normal und kein Absturz – das Programm wird gerade übersetzt. Jeder weitere Start geht in Sekunden.

**Beenden:** im Terminal `Strg` + `C` drücken, danach `exit`.

### Woran erkenne ich, wo ich bin?

Im Container steht ein **Sechseck** ⬢ vorne in der Eingabezeile. Wenn Sie sicher sein wollen:

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

Diese Frage wird am letzten Tag wichtig, weil dann bewusst **außerhalb** des Containers gearbeitet wird.

### Fenster nebeneinander

Editor links, Anwendung rechts – dieser Aufbau bleibt den ganzen Kurs über:

```nu
swaymsg splith
```

---

## 4 Ihre erste Änderung

In `src/index.html` steht diese Zeile:

```html
<h1>Lernkarten</h1>
```

Ändern Sie den Text **zwischen** den beiden Marken:

```html
<h1>Lernkarten von Anna</h1>
```

Speichern. Ins Fenster schauen.

> [!tip] Der Ablauf, der die ganze Woche gilt
> **Ändern → Speichern → Hinsehen.** Nach jeder einzelnen Änderung. Wer fünf Dinge auf einmal ändert und dann hinschaut, weiß bei einem Fehler nicht mehr, welche der fünf Änderungen ihn verursacht hat.

Falls die Änderung nicht sofort erscheint: Rechtsklick ins Anwendungsfenster → **Neu laden**.

Was `<h1>` und `</h1>` genau bedeuten, klären wir morgen früh in [[K1 HTML – die Struktur]]. Heute genügt: Dazwischen steht Ihr Text.

---

## 5 Fehler machen ist Teil der Arbeit

Löschen Sie versuchsweise das schließende `</h1>`:

```html
<h1>Lernkarten von Anna
```

Speichern, hinsehen. Der gesamte folgende Inhalt wird groß und fett dargestellt.

Was ist passiert? Sie haben nicht gesagt, wo die Überschrift **aufhört**. Also nimmt das Programm an, sie hört nie auf. Es stürzt nicht ab, es rät.

> [!important] Drei Sätze für den ganzen Kurs
> 1. **Kaputtmachen ist erlaubt.** Es geht nichts verloren.
> 2. **Der Rechner sagt Ihnen meistens, wo das Problem liegt.** Diese Meldungen zu lesen lernen wir diese Woche.
> 3. **Jeder baut Fehler ein**, auch nach zwanzig Jahren. Der Unterschied ist nur, wie schnell man sie findet.

---

## 6 Wenn etwas nicht funktioniert

| Was Sie sehen | Was Sie tun |
|---|---|
| Das Fenster bleibt weiß | Kursleitung ansprechen |
| Die Änderung erscheint nicht | Gespeichert? Richtige Datei? Rechtsklick → Neu laden |
| Roter Text im Terminal | Die **erste** Zeile laut vorlesen, dann gemeinsam schauen |
| Das Terminal reagiert nicht mehr | `Strg` + `C` |
| Gar nichts geht mehr | Terminal schließen, neu anfangen. Es geht nichts verloren. |

---

## 7 Wörter von heute

| Wort | Bedeutung in einem Satz |
|---|---|
| **Terminal** | Das Fenster, in das Sie Befehle tippen. |
| **Container** | Eine abgetrennte Umgebung im Rechner, in der die Werkzeuge zum Bauen liegen. |
| **Toolbx** | Das Programm, mit dem dieser Container betreten wird. |
| **Quelltext** | Der Text, aus dem das Programm besteht – das, was Sie im Editor sehen. |
| **Entwicklungslauf** | Das Programm läuft nur, solange das Terminal offen ist. Ab K7 geht es auch ohne. |
| **Speichern und Hinsehen** | Die Arbeitsweise dieses Kurses. |

Diese Wörter kommen ab jetzt regelmäßig vor. Alles Weitere wird eingeführt, wenn es gebraucht wird.

---

## 8 Was Sie nach dieser Einheit können sollten

- [ ] Den Container betreten und die Anwendung selbstständig starten
- [ ] Die drei Dateien benennen und sagen, wofür jede zuständig ist
- [ ] Eine Änderung im Quelltext machen und sie im Fenster wiederfinden
- [ ] Einen Fehler einbauen, ihn erkennen und wieder beheben

---

## Verknüpfung

Übungen: [[K0c Übungsblatt]] · [[Anhang Befehlskarte]]
Weiter mit [[K1 HTML – die Struktur]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]
