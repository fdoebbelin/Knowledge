---
title: Tauri-Kompaktkurs didaktisch umbauen
created: 2026-10-22
type: chat-protokoll
source: opencode
model: Big Pickle
tags:
  - chat-protokoll
  - didaktik
  - kursmaterial
  - obsidian
  - tauri
status: active
description: Der Kurs Tauri-Kompaktkurs im Obsidian-Vault wurde von einer Baustein-Struktur mit Trainerskripten auf je Modul drei Notizen (Leitfaden, Merkblatt, Übungsblatt) umgebaut, ohne Zeitangaben.
---

# Tauri-Kompaktkurs didaktisch umbauen

> [!summary] Zusammenfassung
> Der Kurs `01-Courses/Programming/Tauri-Kompaktkurs/` wurde didaktisch umgebaut: Aus je einer Modulnotiz im Ordner `Bausteine/` wurden drei Notizen in eigenen Ordnern – `Leitfaden/` (Lernstoff), `Merkblatt/` (Nachschlagetafel) und `Übungen/` (reine Frage-und-Antwort-Sammlung). Die Module K0–K3 wurden auf dieses Muster überführt, K4–K7 wurden vollständig neu geschrieben. Sämtliche Zeitangaben (`ue`, `kurstag`, `dauer`, „am ersten Tag", „eine halbe Stunde") wurden aus dem Kursmaterial entfernt, Übungsblätter auf Frage und Antwort ohne Bauanleitungen und ohne Abschlusskontrolle reduziert, die drei Anhänge und die Kursübersicht nachgezogen. 20 Altnotizen wurden gelöscht, der Ordner `Bausteine/` entfällt; Sicherung ist die Git-Historie. Stand: fünf lokale Commits auf `main`, nichts gepusht.

> [!warning] Hinweise zur Vollständigkeit
> - Der Anfang des Chats wurde vom Harness zu einer Zusammenfassung verdichtet. Die wörtlichen Ausgangs-Prompts der Modulnotizen liegen deshalb nicht mehr vor; wo Original-Prompts zitiert werden, ist das ausdrücklich als rekonstruiert gekennzeichnet. Die Anforderungsliste aus der Zusammenfassung ist wortgetreu wiedergegeben.
> - Der Chat lief in OpenCode mit dem Modell „Big Pickle", nicht in Claude Code.
> - Keine sensiblen Daten enthalten.

## Ausgangslage

- **Vault:** Obsidian-Wissensbasis `fdoebbelin/Knowledge`, öffentliches Git-Repository, rund 1.390 Notizen. Werkzeug OpenCode, Projektwissen in [[AGENTS]].
- **Kurs:** `01-Courses/Programming/Tauri-Kompaktkurs/` – Kompaktkurs „Vom Web zur Desktop-App" für drei Fachinformatiker-Umschulende ohne Web-Vorkenntnisse, Zielsystem Fedora Sway Atomic, Werkzeugkette `cargo` ohne Node.
- **Struktur vorher:** `00 Kompaktkonzept Tauri Grundlagen.md`, drei Anhänge (`Befehlskarte`, `Vorbereitung durch die Kursleitung`, `Sprachumfang JavaScript`) und der Ordner `Bausteine/` mit 20 Notizen. K0–K3 lagen als Dreiergruppe vor (a = Trainerskript, b = Handout, c = Übungsblatt), K4–K7 als je eine durchgängige Notiz. Jede Modulnotiz enthielt Zeitangaben (`ue`, `kurstag`) im Frontmatter und im Text.
- **Ziel:** Trainerskripte entfernen, Inhalte als Leitfaden gestalten, Handout zu Merkblatt verdichten, Übungsblatt zu einem reinen Frage/Antwort-Dokument machen, alle Zeitangaben entfernen, je Thema eine Einleitung als Stichpunkt-Inhaltsübersicht.
- **Rahmenentscheidung des Nutzers:** im Planungsdialog „Alles durchlaufen" – Phasen A bis K in einem Arbeitsgang.

## Problemlösungen

### 1. Je Modul eine Notiz mit drei Rollen → drei Notizen

**Symptom**

```text
Bausteine/K0 Ankommen und erste eigene Änderung.md   (Leitfaden)
Bausteine/K0a Trainerskript.md                       (nur für die Kursleitung)
Bausteine/K0b Handout.md                             (zum Mitnehmen)
Bausteine/K0c Übungsblatt.md                         (zum Selbermachen)
```

**Ursache:** Die Kursbaustein-Tradition aus dem ausführlichen [[00 Kurskonzept Tauri]]. Eine Notiz je Modul bedient Trainertext, Teilnehmenden-Unterlage und Übung zugleich – die Rollen vermischen sich, der Trainertext wird vorgelesen.

**Lösung**

Drei Ordner unter dem Kurs, drei Notizen je Modul:

```text
01-Courses/Programming/Tauri-Kompaktkurs/
├── 00 Kompaktkurs Tauri Grundlagen.md
├── Anhang/
├── Leitfaden/   K0 … K7   (8)
├── Merkblatt/   K0 … K7   (8)
└── Übungen/     K0 … K7   (8)
```

Frontmatter der neuen Notizen: `title`, `modul: Kx`, `typ` (`leitfaden` | `merkblatt` | `uebungsblatt`), `tags`, `status`, `aliases`. Die Merkblätter und Übungsblätter führen `aliases` auf die gelöschten Quellnotizen (`K0b Handout`, `K1c Übungsblatt` …), damit ältere Verweise weiter aufgelöst werden.

> [!failure]- Verworfene Ansätze
> - **Archivierung nach `05-Notes/Archive/`** statt Löschen – der Nutzer hat das Löschen gewählt, die Git-Historie gilt als ausreichende Sicherung.
> - **Dateiname mit Typzusatz** (`K0 Leitfaden`) – der Leitfaden behält den Modulnamen ohne Zusatz, damit die Wikilinks aus der Kursübersicht und aus den Anhängen unverändert gültig bleiben.

**Verifikation**

```bash
find "01-Courses/Programming/Tauri-Kompaktkurs" -name "*.md" | wc -l
# erwartet: 28
```

### 2. Zeitangaben blieben nach dem Umbau zurück

**Symptom**

```text
./Anhang/Anhang Begleitung und Vorbereitung.md:24:- Puffer ohne Zeitplan
./Anhang/Anhang Begleitung und Vorbereitung.md:310:## Puffer ohne Zeitplan
./Leitfaden/K0 Ankommen und erste eigene Änderung.md:99:Die Wartezeit sinnvoll nutzen: ... Abschnitte „Jeden Morgen" und „Wenn etwas nicht geht".
./Leitfaden/K1 HTML – die Struktur.md:246:> Er ersetzt in [[K4 JavaScript im Fenster]] eine halbe Stunde Fehlersuche und wird deshalb nicht gekürzt.
```

**Ursache:** Der Stoff stammt aus den Altnotizen. Beim Schreiben der neuen Notizen wurden die Zeitbezüge in den Modulen konsequent ersetzt, aber nicht über alle drei Dokumente und nicht in den Anhängen nachgezogen.

**Lösung:** Zeitfreie Ersatzformulierungen statt Streichen, Modulverweise statt Tagesverweise:

| vorher | nachher |
|---|---|
| „Am dritten Tag" | „Im Modul ‚JavaScript im Fenster'" |
| „Erster Start dauert mehrere Minuten" | „Der erste Start dauert spürbar länger" |
| „ab UE 14" | „sobald Listen und Objekte zusammenkommen" |
| „vor dem ersten Kurstag" / „am Vortag" | „vor Kursbeginn" |
| „eine halbe Stunde Fehlersuche" | „eine lange Fehlersuche" |
| „Puffer ohne Zeitplan" | „Puffer im Kursablauf" |

**Verifikation**

```bash
grep -rniE "\b(min|minute|minuten|stunde|ue|kurstag|tag [0-9]|zeitraster|block [a-z0-9]|dauer:|kurstag:|ue:)\b" \
  --include="*.md" 01-Courses/Programming/Tauri-Kompaktkurs
# erwartet: keine Treffer
```

### 3. Toter Wikilink `[[bin]]`

**Symptom**

```text
bin  <- 01-Courses/Programming/Tauri-Kompaktkurs/Anhang/Anhang Begleitung und Vorbereitung.md
```

**Ursache:** Rust-Toml-Syntax im Verzeichnisbaum: `Cargo.toml` mit `[[bin]]`-Block. Obsidian liest die doppelten eckigen Klammern als Wikilink.

**Lösung:** Als Inline-Code schreiben, dann greift der Parser nicht:

```text
│   ├── Cargo.toml          mit `[[bin]]`-Block
```

> [!failure]- Verworfene Ansätze
> - Der erste Linkprüfer meldete den Treffer auch nach der Korrektur weiter, weil er Inline-Code nicht ausgefiltert hat. Der Prüfer wurde um `strip_code()` erweitert; erst danach war das Ergebnis sauber.

**Verifikation**

```bash
# Prüfer: Wikilinks ohne Code-Bereiche und ohne Inline-Code auflösen
# erwartet: (keine) nicht auflösbare Links im Kursordner
```

### 4. K6-Notizen widersprachen dem Sprachumfang

**Symptom**

```text
K6 Leitfaden:  "`splice` steht nicht auf der Liste des [[Anhang Sprachumfang JavaScript]]"
Anhang:        JavaScript-Erlaubtliste ohne indexOf, splice, className, classList
               CSS-Liste ohne box-shadow, obwohl K6 box-shadow verwendet
```

**Ursache:** Der Anhang „Sprachumfang JavaScript" ist verbindlich für die Kursleitung, wurde beim Modulumbau aber nicht mitgepflegt.

**Lösung:** Abschnitt „Bedingt erlaubt" im Anhang ergänzen und die K6-Notizen darauf ausrichten:

```markdown
## Bedingt erlaubt

Nur in [[K6 Feinschliff]] und nur, wenn die jeweilige Verbesserung gewählt wurde.

| Form | Wann | Wie |
|---|---|---|
| `liste.indexOf(element)` | Löschknopf pro Listeneintrag | Rezept: die Stelle des Elements in der Liste finden |
| `liste.splice(pos, 1)` | Löschknopf pro Listeneintrag | Rezept: ein Element an der Stelle `pos` entfernen |
| `element.className` / `element.classList` | Karte je nach Zustand einfärben | Rezept: die Klasse eines Elements setzen |
```

Zusätzlich `box-shadow` in die CSS-Eigenschaftsliste.

**Verifikation**

```bash
grep -rn "Bedingt erlaubt\|bedingte erlaubt\|splice\|box-shadow" \
  01-Courses/Programming/Tauri-Kompaktkurs/{Anhang,Leitfaden,Merkblatt,Übungen}
# erwartet: Anhang führt die drei Formen, K6 verweist auf den Abschnitt
```

### 5. Veralteter Verweis auf einen umbenannten Abschnitt

**Symptom**

```text
Leitfaden/K0 …: Abschnitte „Jeden Morgen" und „Wenn etwas nicht geht"
Anhang Befehlskarte: ## Anwendung starten   (früher: ## Jeden Morgen)
```

**Ursache:** Die Befehlskarte wurde in Phase F umbenannt (zeitbezogene Überschrift), der Verweis aus K0 nicht mitgezogen.

**Lösung:** Verweis auf den neuen Abschnittsnamen korrigieren; die Befehlskarte selbst wurde ebenfalls zeitfrei umgestellt: „Jeden Morgen" → „Anwendung starten", „Nur am letzten Tag" → „Anwendung als Flatpak bauen und starten".

**Verifikation:** `grep -rn "Jeden Morgen" 01-Courses/Programming/Tauri-Kompaktkurs` – Treffer nur noch in diesem Protokoll.

### 6. Shell-Aufruf im Code Mode nicht verfügbar

**Symptom**

```text
Unknown tool 'shell'.
Use search to find available tools.
```

**Ursache:** Im Code-Mode-Runtime sind nur die im Katalog gelisteten Werkzeuge (`tools.opencode.*`) sowie `fetch` verfügbar. Shell- und Dateisystemzugriff gehören nicht dazu und lassen sich nicht nachladen.

**Lösung:** Shell-Aufrufe als eigenständigen Tool-Aufruf ausführen, nicht in `execute` verpacken. Für reine Auswertungen den Code Mode nutzen, für Dateioperationen die normalen Werkzeuge.

### 7. `edit` hat in `Struktur-Übersicht.md` zwei Zeilen zusammengezogen

**Symptom**

```text
- **2026-09-22**: Eingang `00-Inbox` eingeführt; ... umgestellt.- **2026-09-23**: Helix-Spickzettel um ...
```

**Ursache:** Der `oldString` enthielt den abschließenden Zeilenumbruch, der `newString` nicht. Die Ersetzung hat den Umbruch mitgeschluckt, dadurch verschmolzen zwei Historie-Einträge zu einer Zeile.

**Lösung:** Korrektur mit eindeutigem Anker, Umbruch in beiden Strings:

```text
oldString: "`status` in 78 Notizen auf `draft`/`active`/`done` umgestellt.- **2026-09-23**:"
newString: "`status` in 78 Notizen auf `draft`/`active`/`done` umgestellt.\n- **2026-09-23**:"
```

**Verifikation:** `read` der betroffenen Zeilen – zwei getrennte Einträge.

### 8. `git add` auf einen gelöschten Ordner

**Symptom**

```text
Warnung: konnte Verzeichnis '01-Courses/Programming/Tauri-Kompaktkurs/Bausteine/' nicht öffnen: Datei oder Verzeichnis nicht gefunden
```

**Ursache:** Der Ordner existiert auf der Platte nicht mehr, Git kennt ihn aber aus dem Index. `git add -A -- <Verzeichnis>` kann ihn nicht auflösen.

**Lösung:** Die einzelnen Dateipfade namentlich übergeben. Die Warnung betrifft nur das Verzeichnisargument; die Löschungen werden korrekt vorgemerkt.

```bash
git add -A -- "01-Courses/Programming/Tauri-Kompaktkurs/Bausteine/K0 Ankommen und erste eigene Änderung.md" ...
git status --short | grep -v "^??"
# erwartet: Spalte 1 zeigt D für die gelöschten Altnotizen
```

> [!failure]- Verworfene Ansätze
> - `git rm -r Bausteine/` – der Ordner ist bereits gelöscht, Git braucht nur die Pfade zum Vormerken.

## Artefakte & Prompts

> [!warning] Original-Prompts
> Der Chatanfang wurde zu einer Zusammenfassung verdichtet. Die Anforderungsliste unten ist diese Zusammenfassung wortgetreu; die Zusammenfassung selbst sagt ausdrücklich „Nutzer wählte im Planungsdialog ‚Alles durchlaufen' (Phasen A bis K)". Die Formulierungen der Modulnotizen sind daher rekonstruiert, die Anforderungen nicht.

### Anforderungen aus dem Planungsdialog

> Den Kurs `01-Courses/Programming/Tauri-Kompaktkurs` didaktisch umbauen: Trainerskripte entfernen, Inhalte als Leitfaden gestalten, Handout → Merkblatt, Übungsblatt → reines Frage/Antwort-Dokument, alle Zeitangaben entfernen, Einleitung je Thema als Stichpunkt-Inhaltsübersicht.
>
> - K0–K3 bestehende Struktur umbauen; K4–K7 vollständig neu anlegen (Leitfaden + Merkblatt + Übungsblatt).
> - Merkblatt = kompakte Nachschlagetafel (keine Einleitung, keine Selbsteinschätzung).
> - Übungsblatt = nur Frage/Antwort zu behandelten Themen, keine Abschlusskontrolle, keine Zusatzaufgaben, keine Schritt-für-Schritt-Bauanleitungen.
> - Keine Zeitangaben (`min`, `Minuten`, `UE`, `Tag 1`, `Kurstag`, `Zeitraster`, `Block A`, `dauer`, kein `ue:`/`kurstag:` im Frontmatter).
> - Pro Modul alle drei Dokumente im selben Arbeitsgang; Modul für Modul mit `git status`/`git diff` dazwischen.
> - Wikilinks nur auf existierende Notizen; `aliases` für umbenannte Notizen.
> - Ein Commit pro logischer Änderung, deutsche Nachrichten; `git push` erst nach ausdrücklicher Freigabe.

### `00 Kompaktkurs Tauri Grundlagen.md`

- **Typ:** Markdown-Kurskonzept
- **Beschreibung:** Kursübersicht mit Kurzbeschreibung, Zielsetzung, Technologieentscheidung, Modultabelle K0–K7, Didaktik, Sprachumfang und offenen Punkten. Umbenannt von `00 Kompaktkonzept Tauri Grundlagen`, Alias gesetzt, Tagesplan entfernt.

**Original-Prompts** (rekonstruiert aus der Zusammenfassung)

> Einleitung je Thema als Stichpunkt-Inhaltsübersicht. Keine Zeitangaben.

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Bearbeite die Kursübersicht `01-Courses/Programming/Tauri-Kompaktkurs/00 Kompaktkonzept Tauri Grundlagen.md` didaktisch um: benenne sie in `00 Kompaktkurs Tauri Grundlagen.md` um, lege den alten Namen als `aliases`-Eintrag fest, entferne jede Zeitangabe (auch Formulierungen wie „am ersten Tag"), ersetze sie durch Formulierungen ohne Tagesbezug, und führe jeden Abschnitt als Stichpunkt-Inhaltsübersicht unter einer `##`-Überschrift. Die Modultabelle K0–K7 bleibt bestehen, verweist aber auf die Notizen in `Leitfaden/`, `Merkblatt/` und `Übungen/`. Keine Links ins Leere, alle Wikilinks müssen existieren. Arbeite im Vault nach den Regeln aus `AGENTS.md`, eine logische Änderung = ein Commit auf Deutsch.
> ```

### `Leitfaden/` – 8 Leitfäden (K0–K7)

- **Typ:** Markdown-Leitfäden
- **Beschreibung:** Der Lernstoff je Modul: Inhaltsübersicht, Lernziele, Stoff mit Codebeispielen, Merksätze, Quellen und Verknüpfungen. Dateinamen behalten den Modulnamen (`K0 Ankommen und erste eigene Änderung` … `K7 Als Anwendung ausliefern`), damit bestehende Wikilinks gültig bleiben.

**Original-Prompts** (rekonstruiert)

> K0–K3 bestehende Struktur umbauen; K4–K7 vollständig neu anlegen (Leitfaden + Merkblatt + Übungsblatt).

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Baue den Kurs `01-Courses/Programming/Tauri-Kompaktkurs/` auf je Modul (K0–K7) drei Notizen um: einen Leitfaden, ein Merkblatt und ein Übungsblatt, in den Ordnern `Leitfaden/`, `Merkblatt/`, `Übungen/`.
>
> Leitfaden: trägt den Modulnamen ohne Typzusatz, `typ: leitfaden`, `modul: Kx`, Inhaltsübersicht als Stichpunkte, Lernziele, Stoff mit kopierfertigen Codebeispielen, Merksätze, Hinweise für die Kursleitung, Verknüpfung zu Merkblatt, Übungsblatt, Anhang und Kursübersicht. Für K0–K3 den vorhandenen Stoff einarbeiten, für K4–K7 den Stoff neu schreiben.
>
> Merkblatt: `typ: merkblatt`, Dateiname `Kx Merkblatt`, eine kompakte Nachschlagetafel aus Tabellen – KEINE Einleitung, KEINE Selbsteinschätzung, keine Übungsaufgaben, keine Zeitangaben.
>
> Übungsblatt: `typ: uebungsblatt`, Dateiname `Kx Übungsblatt`, nur Frage und Antwort zu bereits behandelten Themen, Nummerierung F1, F2, … je Modul, jede Antwort in einem Klappkasten `> [!success]- Antwort FN`. KEINE Abschlusskontrolle, KEINE Zusatzaufgaben, KEINE Schritt-für-Schritt-Bauanleitungen, keine Zeitangaben.
>
> In allen drei Dokumenten: alle Zeitangaben entfernen (`min`, `Minuten`, `UE`, `Tag 1`, `Kurstag`, `Zeitraster`, `Block A`, `dauer`; auch `ue:`/`kurstag:` im Frontmatter) und durch zeitfreie Formulierungen ersetzen; Verweise auf Module statt auf Kurstage. Frontmatter-Schlüssel `title`, `modul`, `typ`, `tags`, `status`, `aliases`; Aliase auf die alten Notiznamen, damit alte Verweise weiter aufgehen. Wikilinks nur auf existierende Notizen.
>
> Ordnerweise vorgehen: K0 vollständig (Leitfaden, Merkblatt, Übungsblatt), dann `git status` und `git diff`, dann K1 usw. Nach jedem Modul prüfen, dass die Links auflösen. Eine logische Änderung = ein Commit, Commit-Nachrichten auf Deutsch, `git push` erst nach ausdrücklicher Freigabe.
> ```

### `Merkblatt/` – 8 Merkblätter (K0–K7)

- **Typ:** Markdown-Merkblätter
- **Beschreibung:** Die kompakten Nachschlagetafeln je Modul, ohne Einleitung: Tabellen zu Befehlen, Syntax, Dateinamen, Fehlermeldungen, Diagnose und Vokabular. K6 trägt zusätzlich die Werkzeug-Brückentabelle (Wunsch → Baustein → Modul), weil dieses Modul keinen neuen Stoff bringt, sondern das Zusammenführen.

**Original-Prompts** (rekonstruiert)

> Merkblatt = kompakte Nachschlagetafel (keine Einleitung, keine Selbsteinschätzung).
>
> K6 bekommt ein Merkblatt mit Werkzeug-Brückentabelle (Wunsch → Baustein → Modul).

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe zu jedem Modul K0–K7 des Kurses `01-Courses/Programming/Tauri-Kompaktkurs/` ein Merkblatt unter `Merkblatt/Kx Merkblatt.md` mit `typ: merkblatt`, `modul: Kx`.
>
> Inhalt: ausschließlich Tabellen und Stichpunkte zum Nachschlagen – Befehle, Syntax, Dateinamen, Fehlermeldungen und ihre Ursachen, Diagnose, Vokabular. KEINE Einleitung, keine Lernziele, keine Selbsteinschätzung, keine Übungsaufgaben, keine Zeitangaben, kein Tagesbezug. Aliase auf die alte Handout-Notiz (`Kx b Handout`) setzen. Für K6 zusätzlich eine Werkzeug-Brückentabelle: gewünschtes Ergebnis → konkreter Baustein → Modul, aus dem er stammt. Am Ende eine Verknüpfungszeile zu Leitfaden, Übungsblatt, Anhang Befehlskarte und Kursübersicht.
> ```

### `Übungen/` – 8 Übungsblätter (K0–K7)

- **Typ:** Markdown-Übungsblätter
- **Beschreibung:** Reine Frage-und-Antwort-Sammlungen mit den Nummern F1–FN (K0: F1–F8, K1: F1–F6, K2: F1–F10, K3: F1–F10, K4: F1–F8, K5: F1–F7, K6: F1–F6, K7: F1–F6). Antworten jeweils in `> [!success]- Antwort FN`-Klappkästen, mit Merksatz und Begründung.

**Original-Prompts** (rekonstruiert)

> Übungsblatt = nur Frage/Antwort zu behandelten Themen, keine Abschlusskontrolle, keine Zusatzaufgaben, keine Schritt-für-Schritt-Bauanleitungen.
>
> Übungsblatt-Nummerierung `F1`, `F2`, … je Modul; Antworten in `> [!success]- Antwort FN`-Klappkästen.

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe zu jedem Modul K0–K7 des Kurses `01-Courses/Programming/Tauri-Kompaktkurs/` ein Übungsblatt unter `Übungen/Kx Übungsblatt.md` mit `typ: uebungsblatt`, `modul: Kx`.
>
> Aufbau: kurzer Hinweiskasten, Inhaltsübersicht der Fragen, dann F1, F2, … – die Nummerierung beginnt in jedem Modul neu. Zu jeder Frage gehört genau eine Antwort, eingeklappt in `> [!success]- Antwort FN`; die Antwort nennt den Sachverhalt und, wo es hilft, den Merksatz dazu.
>
> Die Fragen beziehen sich ausschließlich auf bereits behandelte Themen des Moduls. KEINE Abschlusskontrolle am Ende, KEINE Zusatzaufgaben, KEINE Anleitung zum Nachbauen einer Anwendung (keine Schritt-für-Schritt-Bauanleitungen), keine Zeitangaben, kein Tagesbezug. Aliase auf die alte Übungsblatt-Notiz (`Kx c Übungsblatt`) setzen. Am Ende eine Verknüpfungszeile zu Leitfaden, Merkblatt und Kursübersicht.
> ```

### `Anhang Befehlskarte.md`

- **Typ:** Markdown-Anhang
- **Beschreibung:** Die Befehlsübersicht für die Teilnehmenden, zum Ausdrucken. Zeitbezogene Überschriften ersetzt, Links auf die neue Kursübersicht umgestellt.

**Original-Prompts** (rekonstruiert)

> Keine Zeitangaben (`min`, `Minuten`, `UE`, `Tag 1`, `Kurstag`, `Zeitraster`, `Block A`, `dauer`).

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Bearbeite `01-Courses/Programming/Tauri-Kompaktkurs/Anhang/Anhang Befehlskarte.md`: entferne alle Zeitbezüge aus den Abschnittsüberschriften (aus „Jeden Morgen" wird „Anwendung starten", aus „Nur am letzten Tag" wird „Anwendung als Flatpak bauen und starten"), stelle die Verweise auf die umbenannte Kursübersicht `00 Kompaktkurs Tauri Grundlagen` um, und halte den Charakter der Karte: eine Seite, die während des ganzen Kurses ausgelegt wird, nur Befehle und eine Spalte Erklärung, keine Zeitangaben.
> ```

### `Anhang Sprachumfang JavaScript.md`

- **Typ:** Markdown-Anhang, verbindlich für die Kursleitung
- **Beschreibung:** Was im Kurs vorkommt und was nicht: erlaubte HTML-Elemente, CSS-Eigenschaften, JavaScript-Bausteine. Neu: `box-shadow` in der CSS-Liste und der Abschnitt „Bedingt erlaubt" für `indexOf`, `splice`, `className`/`classList` (nur K6).

**Original-Prompts** (rekonstruiert)

> `indexOf`, `splice`, `className`/`classList` stehen im Anhang unter neuem Abschnitt „Bedingt erlaubt" (nur K6); `box-shadow` in die CSS-Liste ergänzt.

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Bearbeite `01-Courses/Programming/Tauri-Kompaktkurs/Anhang/Anhang Sprachumfang JavaScript.md`: füge `box-shadow` in die Liste der erlaubten CSS-Eigenschaften ein und ergänze einen neuen Abschnitt „Bedingt erlaubt" zwischen „Erlaubt" und „Nicht erlaubt". Darin stehen `liste.indexOf(element)`, `liste.splice(pos, 1)` und `element.className`/`element.classList` mit je einer Spalte „Wann" (nur im Modul K6 und nur bei gewähltem Einsatz) und „Wie" (vollständige Zeile als Rezept, kein Selbstbauen). Der Abschnitt ist für die Kursleitung verbindlich, keine Zeitangaben.
> ```

### `Anhang Begleitung und Vorbereitung.md`

- **Typ:** Markdown-Anhang, Kursleitungsbegleitung
- **Beschreibung:** Die Trainerbegleitung: Umgebung je Gerät, Projekt im Ausgangszustand, vorbereitete Rust-Commands, Zwischenstände, Material auf dem Tisch, Ablaufbegleitung je Modul, Vorgehen bei Klemmern, Puffer im Kursablauf. Umbenannt von `Anhang Vorbereitung durch die Kursleitung`, Alias gesetzt, Trainerabschnitte aus der entfallenen Anhang-Datei erhalten.

**Original-Prompts** (rekonstruiert)

> `Anhang Vorbereitung durch die Kursleitung.md` → `Anhang Begleitung und Vorbereitung.md`, mit `aliases` für den alten Namen.

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Fasse im Kurs `01-Courses/Programming/Tauri-Kompaktkurs/` die Anhang-Notiz `Anhang/Anhang Vorbereitung durch die Kursleitung.md` zu `Anhang/Anhang Begleitung und Vorbereitung.md` zusammen: benenne die Datei um, lege den alten Namen als `aliases`-Eintrag fest, behalte den Inhalt für die Kursleitung (Umgebung je Gerät, vorbereitete Rust-Commands, Zwischenstände, Material, Ablaufbegleitung je Modul, Vorgehen bei Klemmern), aber ersetze alle Zeitangaben und Tagesbezüge durch zeitfreie Formulierungen wie „vor Kursbeginn". Benutze keine Wikilinks auf gelöschte Notizen; die Rust-Toml-Syntax `[[bin]]` gehört als Inline-Code in den Verzeichnisbaum, sonst liest Obsidian sie als Link.
> ```

### `Struktur-Übersicht.md`

- **Typ:** Markdown-Vault-Übersicht
- **Beschreibung:** Nachgeführt um den Abschnitt „Kursstruktur Tauri-Kompaktkurs" (Ordner, `typ`-Werte, Hinweis auf die entfallenen Zeitangaben), den Ordnerbaum, die Zähler (01-Courses 702 → 706, Gesamtzahl rund 1.390) und einen Historie-Eintrag zum 22.10.2026.

**Original-Prompts** (rekonstruiert)

> Phase K: `Struktur-Übersicht.md` (neuer Abschnitt „Kursstruktur Tauri-Kompaktkurs", Ordnerbaum, Zähler 01-Courses 702 → 706, Gesamtzahl rund 1.390, Historie-Eintrag 2026-10-22 (2)), `HANDOFF.md` neu geschrieben; `00-Inbox/Eingang.md` geprüft (keine Änderung nötig – kein Inbox-Material).

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Aktualisiere `Struktur-Übersicht.md` im Obsidian-Vault nach dem Umbau von `01-Courses/Programming/Tauri-Kompaktkurs/`: ergänze einen Abschnitt „Kursstruktur Tauri-Kompaktkurs" mit den drei Ordnern `Leitfaden/`, `Merkblatt/`, `Übungen/`, den Werten `leitfaden`, `merkblatt`, `uebungsblatt` für `typ` und dem Hinweis, dass im Kurs Zeitangaben entfallen sind. Passe den Ordnerbaum an, zähle die Notizen neu (01-Courses 702 → 706, Gesamtzahl rund 1.390), und ergänze einen Historie-Eintrag mit Datum 2026-10-22 (2), der den Umbau, die Umbenennungen mit Alias und das Entfallen des Ordners `Bausteine/` nennt. Frontmatter-Schlüssel englisch und kleingeschrieben, `updated` setzen, bestehende Historie-Einträge nicht umsortieren.
> ```

### `HANDOFF.md`

- **Typ:** Markdown-Übergabedokument
- **Beschreibung:** Die Übergabe an die nächste Sitzung: Ziel, erledigte Schritte, nächste Schritte, Entscheidungen mit Begründung, Sackgassen und Erkenntnisse, relevante Dateien.

**Original-Prompts** (rekonstruiert)

> `HANDOFF.md` neu geschrieben.

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe `HANDOFF.md` im Obsidian-Vault neu: Kopfzeile mit Stand, Rechner, Branch, Zustand (uncommittet ja/nein), Werkzeug und Fortsetzungsbefehl; dann Ziel, „Erledigt in dieser Session" als Liste der ausgeführten Schritte, „Nächster Schritt" als Aufgabenliste, „Entscheidungen" mit Begründung, „Sackgassen und Erkenntnisse", „Relevante Dateien" und „Nicht in Git". Nenne beim Push ausdrücklich, dass er erst nach Freigabe erfolgt, und nenne den Rettungsweg für die gelöschten Altnotizen (`git checkout 23d74f3 -- "01-Courses/Programming/Tauri-Kompaktkurs/Bausteine/"`).
> ```

## Entscheidungen

- **Drei Notizen je Modul in eigenen Ordnern** statt einer Datei mit Anhängen – Leitfaden, Merkblatt und Übungsblatt haben verschiedene Leser und verschiedene Nutzungszeiten.
- **Der Leitfaden behält den Modulnamen ohne Typzusatz** – bestehende Wikilinks aus Kursübersicht und Anhängen bleiben dadurch gültig.
- **Merkblatt ohne Einleitung und Selbsteinschätzung, Übungsblatt ohne Abschlusskontrolle, Zusatzaufgaben und Bauanleitungen** – die Dokumente sollen beim Nachschlagen und beim Üben helfen, nicht den Kurs abbilden.
- **Zeitangaben durch zeitfreie Formulierungen ersetzt, nicht gestrichen** – die Aussage bleibt, der Bezug zum Tagesplan entfällt.
- **Modulverweise statt Tagesverweise** („Im Modul ‚JavaScript im Fenster'"), damit keine Zeitangaben zurückkommen.
- **Altdateien gelöscht statt archiviert** (Nutzerentscheidung) – die Git-Historie gilt als Sicherung.
- **K6 bekommt ein Merkblatt**, obwohl das Modul keinen neuen Stoff bringt – die Werkzeug-Brückentabelle ist dort der eigentliche Nutzen.
- **`indexOf`, `splice`, `className`/`classList` bewusst außerhalb der allgemeinen Sprachliste**, unter „Bedingt erlaubt" im Anhang – die Ausnahme soll sichtbar und angekündigt sein, nicht versteckt.
- **Rust-Toml-Syntax wie `[[bin]]` als Inline-Code** – sonst liest Obsidian sie als Wikilink.

## Nützliche Befehle & Snippets

```bash
# Alle Notizen des Kursordners zählen
find "01-Courses/Programming/Tauri-Kompaktkurs" -name "*.md" | wc -l

# Zeitangaben im Kursmaterial aufspüren
grep -rniE "\b(min|minute|minuten|stunde|ue|unterrichtseinheit|kurstag|tag [0-9]|zeitraster|block [a-z0-9]|zeitplan|dauer:|kurstag:|ue:)\b" \
  --include="*.md" 01-Courses/Programming/Tauri-Kompaktkurs

# Verweise auf gelöschte Altnotizen (nur die Alias-Einträge dürfen übrig bleiben)
grep -rn "Kompaktkonzept\|Trainerskript\|K[0-7][abc] Handout\|K[0-7][abc] Übungsblatt\|Vorbereitung durch die Kursleitung" \
  --include="*.md" .

# Wikilinks prüfen: Namen und Aliase im Vault sammeln, Code-Bereiche ausfiltern
python3 - <<'PY'
import re, os
files = []
for dp, dn, fn in os.walk("."):
    if ".git" in dp.split(os.sep): continue
    files += [os.path.join(dp, f) for f in fn if f.endswith(".md")]
base = {os.path.splitext(os.path.basename(f))[0] for f in files}
alias = set()
for f in files:
    m = re.search(r"^---\n(.*?)\n---\n", open(f, encoding="utf-8").read(), re.S)
    if m:
        am = re.search(r"^aliases:\s*\n((?:\s*-\s*.+\n)+)", m.group(1), re.M)
        if am:
            alias |= {l.strip().lstrip("-").strip().strip('"') for l in am.group(1).splitlines()}
def strip_code(t):
    t = re.sub(r"```.*?```", "", t, flags=re.S)
    return re.sub(r"`[^`\n]*`", "", t)
missing = set()
for f in files:
    if "Tauri-Kompaktkurs" not in f: continue
    for m in re.finditer(r"\[\[([^\]\|#]+)(?:#[^\]\|]*)?(?:\|[^\]]*)?\]\]", strip_code(open(f, encoding="utf-8").read())):
        t = m.group(1).strip()
        if t not in base and t not in alias: missing.add(t)
print(sorted(missing) or "(keine)")
PY

# Status und Änderungen zwischen zwei Modulen
git status --short && git diff
```

## Offene Punkte

- [ ] Die 24 neuen Notizen in `Leitfaden/`, `Merkblatt/` und `Übungen/` gegenlesen – vor allem die Übungsblätter, weil dort der Frage-Umfang festgelegt wurde.
- [ ] `git push` nach Freigabe. Die fünf Commits liegen lokal auf `main`, `origin/main` ist nicht eingebunden.
- [ ] Zwischenstände `stand-k1` … `stand-k6` erzeugen und ablegen – steht als offener Punkt in der Kursübersicht und in der Begleitung.
- [ ] Aus dem Chat nicht mehr rekonstruierbar: die wörtlichen Original-Prompts der Modulnotizen. Wer sie nachhalten will, muss die Anforderungsliste oben als Ausgangspunkt verwenden.
