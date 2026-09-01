# Block 09 – Rechnen und Auswerten

| Merkmal | Details |
|---|---|
| **Blocknummer** | 9 |
| **Titel** | Rechnen und Auswerten |
| **Programm** | Microsoft Excel 2019 |
| **Dauer** | 75 Minuten (11:15 – 12:30 Uhr) |
| **Folgt auf** | Block 8 – Excel-Grundlagen (Pause 15 Min.) |

## Lernziele

Am Ende dieses Blocks können die Teilnehmer:

- Eine Formel durch Kopieren auf weitere Zellen übertragen und erklären, warum Excel die Zellbezüge automatisch anpasst.
- Die Funktionen SUMME, MITTELWERT, MIN, MAX und ANZAHL korrekt eingeben und auf realistische Daten anwenden.
- Zahlen als Währung (€) und Datum formatieren.
- Eine Tabelle nach einer Spalte sortieren und einen AutoFilter setzen, um nur bestimmte Datensätze anzuzeigen.

---

## Vorbereitung

**Dateien auf Teilnehmer-PCs bereitstellen** (Ordner `C:\Kurs\Uebungen`):

- `Uebung-11-Energieverbrauch.xlsx` – Tabelle mit Stromzählerwerten Jan–Dez, Spalte „Verbrauch" noch leer
- `Uebung-12-Filtern.xlsx` – Inventarliste aus Übung 9 (bereits vollständig ausgefüllt)

**Eigene Demo-Datei** vorbereiten: Eine Kopie von `Uebung-11-Energieverbrauch.xlsx` auf dem Dozenten-PC öffnen.

**Prüfen:**
- Excel ist auf allen PCs gestartet und zeigt die Datei `Uebung-11-Energieverbrauch.xlsx`.
- Beamer zeigt den Dozenten-Bildschirm.
- Folienpräsentation `Block-09-Praesentation.pptx` ist bereit.

---

## Ablaufplan

| Min. | Zeit | Aktivität | Inhalt | Hinweise |
|---|---|---|---|---|
| 0–3 | 11:15 | Dozent zeigt (Folie 1–2) | Einstieg: Was machen wir heute? Lernziele vorstellen. | Kurzer Rückblick: „Wir haben in Block 8 erste Formeln geschrieben. Heute bauen wir darauf auf." |
| 3–10 | 11:18 | Dozent zeigt (Folie 3–4) | **Konzept: Formeln kopieren & relative Bezüge** – Demo an Beamer: Formel =C3-C2 in D3 eingeben, Füllkästchen nach unten ziehen, zeigen wie D4=C4-C3 usw. | Langsam vorgehen! Füllkästchen zeigen (kleines grünes Quadrat unten rechts). Typische Frage: „Muss ich für jede Zeile neu tippen?" → Nein, genau das ist der Vorteil. |
| 10–15 | 11:25 | Teilnehmer machen nach | Teilnehmer öffnen `Uebung-11-Energieverbrauch.xlsx`. Formel =C3-C2 in D3 eingeben, dann nach unten kopieren bis D14. | Herumgehen, prüfen ob alle das Füllkästchen finden. |
| 15–22 | 11:30 | Dozent zeigt (Folie 5–6) | **Konzept: SUMME, MITTELWERT, MIN, MAX** – Demo: =SUMME(D3:D14) in D16, =MITTELWERT(D3:D14) in D17, =MAX(D3:D14) in D18. Ergebnis erklären. | Analogie: „SUMME ist wie der Kassenzettel – alles zusammengezählt. MITTELWERT ist der typische Monatsverbrauch." |
| 22–32 | 11:37 | Teilnehmer üben (Übung 11 Teil 1) | Teilnehmer geben SUMME, MITTELWERT und MAX selbst ein. Ergebnisse prüfen. | Folie mit Aufgabenstellung einblenden. Bei Fehlern: Formel in Bearbeitungsleiste anzeigen lassen. |
| 32–38 | 11:47 | Dozent zeigt (Folie 7) | **Konzept: Zahlenformat Währung & Datum** – Zellen markieren → Start → Zahl → Währung (€). Datumsformat zeigen. | Kurz halten: Nur das Nötigste für den Kontext. |
| 38–43 | 11:53 | Teilnehmer machen nach | Spalte D als „Zahl mit 0 Dezimalstellen" formatieren. | |
| 43–50 | 11:58 | Dozent zeigt (Folie 8–9) | **Konzept: Sortieren und Filtern** – Demo an `Uebung-12-Filtern.xlsx`: Tabelle nach Spalte „Bestand" aufsteigend sortieren. Dann AutoFilter setzen: Nur Zeilen anzeigen, wo „Nachbestellen" = „Ja". | Betonen: Die anderen Zeilen sind nicht gelöscht, nur ausgeblendet! |
| 50–65 | 12:05 | Teilnehmer üben (Übung 12) | Teilnehmer öffnen `Uebung-12-Filtern.xlsx`. Filter setzen, nur Artikel mit „Nachbestellen = Ja" anzeigen. Dann Filter aufheben (alle Artikel wieder sichtbar machen). | Folie mit Aufgabenstellung einblenden. Häufige Frage: „Wie mache ich den Filter wieder weg?" → Trichter-Symbol mit X klicken oder Daten → Filter deaktivieren. |
| 65–70 | 12:20 | Selbst anwenden | Bonusaufgabe: Tabelle in Übung 11 nach Verbrauch sortieren (höchster zuerst). | Für schnelle Teilnehmer. |
| 70–75 | 12:25 | Zusammenfassung & Überleitung | Folie 10: Zusammenfassung. Überleitung zu Mittagspause und Block 10 (Diagramme). | |

---

## Inhaltliche Hinweise

### Formeln kopieren – relative Bezüge

**Erklärung für Teilnehmer:**  
> „Wenn Sie eine Formel kopieren, denkt Excel nicht in festen Zelladressen, sondern in Richtungen. Die Formel =C3-C2 bedeutet für Excel: ‚Nimm die Zelle direkt über mir und ziehe davon die Zelle zwei drüber ab.' Wenn Sie diese Formel eine Zeile tiefer kopieren, gilt dasselbe Prinzip – Excel rechnet =C4-C3."

**Füllkästchen finden:** Das kleine grüne Quadrat erscheint, wenn Sie eine Zelle anklicken, unten rechts in der Zellenmarkierung. Maus darauf → Cursor wird zum dünnen Kreuz → dann ziehen.

### Funktionen SUMME, MITTELWERT, MIN, MAX, ANZAHL

| Funktion | Eingabe | Bedeutung |
|---|---|---|
| SUMME | =SUMME(D3:D14) | Alle Werte addieren |
| MITTELWERT | =MITTELWERT(D3:D14) | Durchschnitt berechnen |
| MIN | =MIN(D3:D14) | Kleinsten Wert finden |
| MAX | =MAX(D3:D14) | Größten Wert finden |
| ANZAHL | =ANZAHL(D3:D14) | Anzahl der Zellen mit Zahlen zählen |

**Analogien:**  
- SUMME = Kassenzettel, alles summiert
- MITTELWERT = „Was verbrauchen wir normalerweise pro Monat?"
- MAX = „Welcher Monat war der teuerste?"

### Sortieren und Filtern

**Sortieren:** Daten → Sortieren → Spalte wählen → aufsteigend/absteigend.  
**AutoFilter:** Eine Zelle in der Tabelle anklicken → Daten → Filtern → Dropdown-Pfeile erscheinen in der Kopfzeile → Dropdown öffnen → nur gewünschten Wert auswählen.  
**Wichtig zu betonen:** Filtern löscht keine Daten. Die Zeilen sind nur vorübergehend ausgeblendet. Filter aufheben: Daten → Filtern (nochmals klicken) oder alle Häkchen setzen.

---

## Didaktische Hinweise

- **Füllkästchen ist kritisch:** Viele Teilnehmer finden es nicht. Zeigen Sie es am Beamer groß und lassen Sie alle bestätigen, dass sie es sehen, bevor sie loslegen.
- **Formelwildwuchs vermeiden:** Darauf achten, dass Teilnehmer wirklich Formeln eingeben (beginnt mit =), nicht Zahlen abtippen. Kontrollieren: Zelle anklicken → Bearbeitungsleiste zeigt die Formel.
- **Filtern langsam demonstrieren:** Erst zeigen, dass alle Zeilen da sind. Dann Filter setzen. Dann erklären, dass nichts gelöscht wurde. Dann Filter wieder aufheben.
- **Zeitpuffer:** Wenn Teilnehmer schnell sind, Bonusaufgabe (Sortieren nach Verbrauch) vergeben. Wenn sie langsam sind, Übung 12 vereinfachen: Nur Filter setzen, Aufheben kann entfallen.

---

## Übergänge

**Einleitung (von Block 8):**  
> „Nach der Pause haben wir gelernt, wie Excel aufgebaut ist und wie man einfache Formeln schreibt. Jetzt machen wir einen wichtigen Schritt weiter: Wir nutzen Excel so, wie man es im Büro wirklich braucht – mit Funktionen, die automatisch rechnen, und mit Filter-Möglichkeiten, die uns genau die Information zeigen, die wir suchen."

**Ausleitung (zur Mittagspause / Block 10):**  
> „Sie können jetzt Tabellen nicht nur befüllen, sondern auch auswerten. Nach der Mittagspause machen wir etwas Greifbares daraus: Wir verwandeln diese Zahlen in ein Diagramm, das die Hausverwaltung auf einen Blick versteht."

---

## Notfall-Tipps

| Problem | Lösung |
|---|---|
| Formel zeigt #WERT! | Prüfen ob alle Zellen im Bereich Zahlen enthalten (kein Text). |
| Formel zeigt #DIV/0! | Division durch Null – tritt bei MITTELWERT auf, wenn Bereich leer ist. Bereich prüfen. |
| Füllkästchen nicht sichtbar | Excel-Optionen → Erweitert → „Ausfüllkästchen und Drag & Drop von Zellen aktivieren" prüfen. Alternativ: Kopieren (Strg+C) → Zielbereich markieren → Einfügen (Strg+V). |
| Filter zeigt keine Ergebnisse | Prüfen ob Tippfehler im Filter-Wert. Filter über „Alle" wieder aufheben und neu setzen. |
| Teilnehmer hat falsche Datei geöffnet | Datei schließen, über Datei → Öffnen → `C:\Kurs\Uebungen` navigieren. |
| AutoFilter-Pfeile nicht sichtbar | Zelle innerhalb der Tabelle anklicken, dann Daten → Filtern. |
