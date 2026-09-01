*Grundlage der Feinplanung. Aufbauend auf dem didaktischen Konzept (Drei-Phasen-Modell, Sechs Leitprinzipien, Drei-Ebenen-Lernzieltaxonomie A/B/C).*

---

## Vorbemerkung / Lesehilfe

Diese Modulstruktur ist die zweite Stufe zwischen Konzept und operativer Feinplanung. Sie spezifiziert für jedes Modul, **was** zu lehren ist und **wie** es methodisch eingebettet wird, ohne bereits konkrete Übungen, Tagesabläufe oder Bewertungsraster vorzugeben – diese gehören in die Feinplanung.

**Konsistente Struktur pro Modul:**
1. Kennung, Phase, relativer Zeitanteil
2. Voraussetzungen aus Vormodulen
3. Lernziele auf drei Ebenen (A: Python, B: KI-Nutzung, C: Metakognition)
4. Kerninhalte
5. Didaktische Realisierung (Methoden + KI-Rolle)
6. Verifikation & Querschnittsthemen
7. Differenzierungs- und Feinplanungshinweise

**Zeitanteile** sind als prozentuale Richtwerte angegeben, damit das Konzept für unterschiedliche Trägerformate (Vollzeit-Umschulung, Teilzeit, BFD-Maßnahme, Wochenend-Format, modulare Bildungsgutschein-Kurse) skalierbar bleibt. Bei einem 100-UE-Kurs entspricht 1 % rund 1 UE, bei einem 200-UE-Kurs entsprechend 2 UE. Die hier genannten Anteile beziehen sich auf die **gesamte Lehrgangszeit inklusive Selbstlernanteilen**.

**Verwendete Abkürzungen:** TN = Teilnehmende; UE = Unterrichtseinheit; LLM = Large Language Model; DoLe = Dozent:in/Lehrkraft; M = Modul.

---

## Übersichtsmatrix

| # | Modul | Phase | Anteil | A | B | C | Methodischer Schwerpunkt |
|---|---|---|---|---|---|---|---|
| M1 | Orientierung & KI-Vertrag | 0 | 3 % | – | ○ | ● | Diagnostik, Kontrakt, Datenschutzbelehrung |
| M2 | Python-Fundierung ohne KI | 1 | 12 % | ● | – | ○ | Live-Coding, Tracing, Parsons-Puzzles |
| M3 | KI als Lernpartner | 2 | 8 % | ○ | ● | ● | Erklären-lassen, Code-Tracing mit LLM |
| M4 | Datenstrukturen & Prompt-Disziplin | 2 | 10 % | ● | ● | ○ | Prompt Problems (Promptly-Stil) |
| M5 | Code lesen vor Code schreiben | 2 | 8 % | ● | ○ | ● | Reverse Engineering, Annotationsarbeit |
| M6 | Funktionen, Module, Dekomposition | 2 | 12 % | ● | ● | ○ | Spec-driven Prompting, Pair-Programming |
| M7 | Testen als Verifikationsstrategie | 2 | 10 % | ● | ● | ● | Test-First-Workflow, Debugging-Challenges |
| M8 | Halluzinationen, Lizenzen, Quellen | 2 | 6 % | – | ● | ● | Faktencheck, Lizenzanalyse, AI-Act/DSGVO |
| M9 | Datenarbeit (CSV, JSON, Visualisierung) | 2 | 10 % | ● | ● | ○ | Mini-Projekte, Datenexploration |
| M10 | Projektphase „KI-Dirigent:in" | 3 | 15 % | ● | ● | ● | Spec → Prompt → Review → Test → Doku |
| M11 | Reflexion & Transfer | 3 | 6 % | ○ | ○ | ● | Lernjournal-Auswertung, Kompetenzkarte |

Legende: ● Schwerpunkt · ○ ergänzend · – nicht im Fokus

**Phasenverteilung:** Phase 0 = 3 %, Phase 1 = 12 %, Phase 2 = 64 %, Phase 3 = 21 %.
Dies liegt im Zielkorridor des Konzepts (Phase 1: 10–15 %, Phase 2: 50–60 %, Phase 3: 25–30 %), mit leichter Verschiebung zugunsten der Phase 2, weil die einzelnen Verifikations- und Promptkompetenzen Übungszeit brauchen.

---

## Modul M1 – Orientierung & KI-Vertrag

**Phase:** 0 (Orientierung & Setup) · **Anteil:** ca. 3 % · **Position:** Kursauftakt

### Voraussetzungen
Keine. Erfasst werden vorhandene Vorerfahrungen.

### Lernziele

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN können ihre eigene Vorerfahrung mit Python und mit generativer KI realistisch einordnen.
- Die TN kennen den didaktischen Kontrakt zur KI-Nutzung im Kurs und können dessen Begründung in eigenen Worten wiedergeben.
- Die TN benennen drei für sie persönlich relevante Lernziele und drei Risiken unkontrollierter KI-Nutzung.

*Ebene B (KI-Nutzung – ergänzend)*
- Die TN haben mindestens ein DSGVO-konformes KI-Tool (Enterprise-Zugang oder didaktisches Frontend wie fobizz/schulKI) auf ihrem Arbeitsgerät erreichbar.
- Die TN kennen die im Kurs zulässigen und unzulässigen Eingaben (Pseudonymisierungsregeln, kein Klartext personenbezogener Daten).

### Kerninhalte
- Vorstellung des Drei-Phasen-Modells und der drei Lernzielebenen (A/B/C) – warum es im Kurs phasenweise unterschiedliche KI-Regeln gibt.
- Diagnostische Eingangserhebung (kurze Selbstauskunft + freiwilliges Mini-Tracing-Beispiel ohne Bewertung).
- Tooling-Setup: Python-Arbeitsumgebung (Empfehlung: Cloud-Notebook wie Google Colab oder DataCamp DataLab als niederschwellig, ergänzend lokale Installation als Ausblick).
- KI-Werkzeuge: Auswahl mit Begründung (Datenschutz, Guardrails, Kursbudget); Demonstration der Konto-/Pseudonym-Einrichtung.
- **KI-Vertrag** als zentrales Dokument: Wann darf KI genutzt werden, wann nicht? Welche Daten dürfen eingegeben werden? Wie wird Nutzung dokumentiert? Wie wird in Prüfungssituationen verfahren?

### Didaktische Realisierung
- **Methode:** Moderierter Auftakt mit Erwartungsklärung, gefolgt von Setup-Werkstatt (TN richten ihre Arbeitsumgebung ein, sich gegenseitig unterstützend).
- **KI-Rolle:** noch nicht produktiv. KI-Tools werden eingerichtet, aber im Modul nicht genutzt – außer in einer kurzen Demonstration durch DoLe, um das Spektrum „Vibe Coding ↔ Augmented Coding ↔ Agentic Engineering" anschaulich zu machen.
- **DoLe-Rolle:** Moderation, Vertragspartner:in, Datenschutz-Verantwortliche:r.

### Verifikation & Querschnittsthemen
- **Datenschutz:** vollständig in diesem Modul verankert. Belehrung nach DSGVO und – falls relevant – nach Trägervorgaben (BFD, AZAV, BWSA).
- **Metakognition:** Lernjournal wird in M1 angelegt; erste Eintragung ist die individuelle Standortbestimmung.
- **Halluzinationen/Lizenzen:** wird hier nur angekündigt (M8 vertieft).

### Differenzierung & Feinplanungshinweise
- TN mit KI-Vorerfahrung erhalten in der Setup-Werkstatt zusätzliche Aufgaben („mehrere Tools vergleichend einrichten", „eigenes Modell-/Tool-Inventar dokumentieren").
- Heterogene Hardware: Cloud-Notebook als Default, weil keine lokalen Installationsprobleme.
- Vorlagen, die in der Feinplanung zu erstellen sind: KI-Vertrag (Kursdokument), Lernjournal-Vorlage, diagnostischer Selbstcheck, Datenschutzbelehrung.
- **Trigger zur Anpassung:** Wenn > 30 % der TN noch nie eine Programmiersprache gesehen haben, M2 verlängern; wenn > 30 % bereits Python-Vorerfahrung haben, M2 als Auffrischung straffen und in M3 mehr Tiefe geben.

---

## Modul M2 – Python-Fundierung ohne KI

**Phase:** 1 (KI-freie Fundierung) · **Anteil:** ca. 12 % · **Position:** unmittelbar nach M1

### Voraussetzungen
M1 abgeschlossen, Tooling läuft.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN können Variablen, primitive Datentypen, Bedingungen, Schleifen und einfache Funktionen lesen, schreiben und ausführen.
- Die TN können den Programmverlauf eines kurzen Skripts per Hand tracen (Werte-Tabelle).
- Die TN unterscheiden zwischen Syntaxfehler, Laufzeitfehler und logischem Fehler und können einfache Beispiele zuordnen.

*Ebene C (Metakognition – ergänzend)*
- Die TN beschreiben ihr mentales Modell für „Was passiert, wenn Python eine Zeile ausführt?" in eigenen Worten (notional machine).
- Die TN erkennen, an welchen Stellen sie unsicher sind, und formulieren konkrete Lückenfragen.

### Kerninhalte
- Variablen, Zuweisung, Identität vs. Wert (kompakt).
- Datentypen: int, float, str, bool, None.
- Kontrollstrukturen: if/elif/else, while, for.
- Einfache Funktionen (def, return, Parameter, Rückgabewert).
- Fehlertypen und Lesen von Tracebacks (vorerst ohne KI-Unterstützung).
- Ein- und Ausgabe (print, input).

### Didaktische Realisierung
- **Methode:** Live-Coding durch DoLe mit Tracing-Pausen; Worked Examples (vorgelöste Beispiele, die schrittweise nachvollzogen werden); Parsons-Puzzles (Codezeilen in richtige Reihenfolge bringen) als zentrales Übungsformat – sie reduzieren Cognitive Load und sind LLM-resilient.
- **KI-Rolle:** **bewusst keine.** Dies ist die einzige Phase, in der die KI-Werkzeuge geschlossen bleiben. Begründung wird den TN transparent gemacht: Aufbau des mentalen Modells, Schutz vor „illusion of competence", Vermeidung von cognitive debt nach SWK-Empfehlung.
- **DoLe-Rolle:** klassischer Wissensvermittler in dieser Phase; eng führend, mit hoher Diagnose-Aufmerksamkeit.

### Verifikation & Querschnittsthemen
- **Eigenaktivität:** Tracing-Aufgaben, in denen TN per Hand den Programmlauf protokollieren (kein Tool-Einsatz).
- **Metakognition:** Am Ende des Moduls dokumentiert jede:r TN drei sicher beherrschte und drei noch unsichere Konzepte.
- **Halluzinationen/Lizenzen/Datenschutz:** in diesem Modul nicht im Fokus.

### Differenzierung & Feinplanungshinweise
- Für Vorerfahrene: Tracing komplexerer Snippets, Funktionen mit Default-Argumenten, einfache Rekursion.
- Für Anfänger:innen: zusätzliche Parsons-Puzzles, mehr Worked Examples, Peer-Tutoring zugelassen (auch hier ohne KI).
- **Stolperstelle:** TN mit KI-Vorerfahrung empfinden die KI-freie Phase oft als Zumutung. Die Begründung muss in M1 vorbereitet und in M2 mehrfach in Erinnerung gerufen werden.
- Vorlagen für die Feinplanung: Tracing-Tabellenblätter, Parsons-Puzzles in mindestens zwei Schwierigkeitsstufen, Selbstcheck am Modulende.

---

## Modul M3 – KI als Lernpartner

**Phase:** 2 (KI-augmentiert) · **Anteil:** ca. 8 % · **Position:** Übergang vom KI-freien zum KI-augmentierten Lernen

### Voraussetzungen
M2: stabiles Grundverständnis von Variablen, Kontrollfluss, einfachen Funktionen.

### Lernziele

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN können ein LLM gezielt zum **Erklären** eines Codeschnipsels nutzen („Erkläre mir Zeile für Zeile, was hier passiert").
- Die TN unterscheiden zwischen einem Erklär-Prompt und einem Lösungs-Prompt und wählen bewusst.
- Die TN formulieren mindestens drei verschiedene Prompt-Varianten für dasselbe Verständnisanliegen und vergleichen die Antworten.

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN erkennen, wann eine LLM-Erklärung ihr Verständnis vertieft und wann sie es nur oberflächlich abdeckt („das klingt plausibel, aber kann ich es selbst sagen?").
- Die TN üben das Prompt-and-Verify-Pattern in seiner einfachsten Form: lesen → in eigenen Worten reformulieren → bei Bedarf nachfragen.

*Ebene A (Python – ergänzend)*
- Die TN festigen ihr Verständnis aus M2 durch KI-gestützte Erklärung; keine neuen Sprachelemente.

### Kerninhalte
- Was ist ein LLM? Grobes Funktionsprinzip („stochastische Wahrscheinlichkeitsmaschine", „kein Weltwissen, kein Bewusstsein").
- Erklär-Prompts: „explain like I'm five", „Zeile für Zeile", „Was passiert, wenn ich x ändere?".
- Pädagogische Guardrails: Im Kurs werden – wo verfügbar – Tools mit didaktischen Schutzschichten (CS50-Duck-artig, CodeHelp, fobizz, schulKI) verwendet, die nicht direkt die Lösung ausspucken.
- Erste Reflexionsroutine: nach jeder LLM-Antwort die Frage „Was habe ich davon verstanden? Was kann ich jetzt selbst?".

### Didaktische Realisierung
- **Methode:** Geführter Erst-Einsatz der KI im Plenum; gemeinsamer Blick auf einen LLM-Output, gemeinsame Annotation, gemeinsame Bewertung. Anschließend Kleingruppen-Phase.
- **KI-Rolle:** Lernpartner, ausdrücklich **nicht** Lösungsgenerator. DoLe demonstriert exemplarisch, was eine „gute" und was eine „faule" Nutzung ist.
- **DoLe-Rolle:** Coach für Prompt-Hygiene und Reflexion (Prinzip 5: Sparringspartner:in).

### Verifikation & Querschnittsthemen
- **Prompt-and-Verify** wird als Standard-Workflow eingeführt: jede:r TN muss die KI-Erklärung in eigenen Worten formulieren, bevor sie übernommen wird.
- **Metakognition:** Lernjournal-Eintrag: „Worin hat mir die KI heute geholfen, worin nicht?"
- **Halluzinationen:** kurzer Hinweis auf das Phänomen, vertiefte Behandlung in M8.
- **Datenschutz:** Erinnerung, dass kein Klartext personenbezogener Daten in Prompts.

### Differenzierung & Feinplanungshinweise
- TN mit KI-Vorerfahrung erhalten Aufgaben, in denen sie LLM-Antworten **kritisieren** (gezielt schwache oder fehlerhafte Antworten finden lassen).
- Anfänger:innen erhalten Prompt-Vorlagen.
- Vorlagen für die Feinplanung: Prompt-Bibliothek („gute Erklär-Prompts"), Beobachtungsbogen für die Plenumsphase, Annotationsschema für KI-Output.
- **Stolperstelle:** TN neigen anfangs dazu, „Schreib mir die Lösung" zu prompten. Im Kurs gilt eine ausdrückliche Regel: Lösungs-Prompts sind in M3 nicht zulässig; sie werden ab M6 schrittweise eingeführt.

---

## Modul M4 – Datenstrukturen & Prompt-Disziplin

**Phase:** 2 · **Anteil:** ca. 10 % · **Position:** früher Hauptteil von Phase 2

### Voraussetzungen
M2 und M3 abgeschlossen.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN beherrschen Listen, Tupel, Dictionaries und Sets in den typischen Verwendungsmustern (Iteration, Lookup, Filterung).
- Die TN können geeignete Datenstrukturen für gegebene Probleme begründet auswählen.
- Die TN nutzen List Comprehensions in einfachen Fällen.

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN formulieren strukturierte Prompts mit klarer Spezifikation (Eingabe, Ausgabe, Randbedingungen, Beispiele).
- Die TN führen mehrstufige Prompt-Iterationen durch (erst grob, dann verfeinern, dann verifizieren).
- Die TN dokumentieren erfolgreiche Prompts in einer persönlichen Prompt-Bibliothek.

### Kerninhalte
- Listen: Indexierung, Slicing, gängige Methoden, Iteration.
- Dictionaries: Schlüssel-Wert-Paare, Iteration über keys/values/items.
- Tupel und Sets als ergänzende Strukturen.
- List Comprehensions als idiomatische Python-Form.
- **Prompt-Engineering-Grundmuster** parallel zur Python-Vermittlung: Aufgabenbeschreibung + Eingabeformat + Ausgabeformat + Beispiele + Anti-Beispiele.

### Didaktische Realisierung
- **Methode:** Doppelspur – jede neue Datenstruktur wird zuerst per Hand verstanden (nach M2-Logik kompakt), dann mit KI-Unterstützung in einer realistischen Mini-Aufgabe vertieft. Prompt Problems im Stil von Denny et al. (2023, „Promptly"): TN erhalten eine textuelle Spezifikation und müssen einen Prompt formulieren, der einen LLM dazu bringt, korrekten Code zu erzeugen – dann den Code prüfen.
- **KI-Rolle:** zunehmend produktiv, aber strikt im Prompt-and-Verify-Modus. KI generiert; TN prüft mit kurzen Tests; TN dokumentiert.
- **DoLe-Rolle:** Coach für Prompt-Qualität, Diskussionsleiter:in für Prompt-Vergleiche im Plenum.

### Verifikation & Querschnittsthemen
- **Prompt-and-Verify:** mindestens dreigliedriges Vorgehen (Spec lesen → Prompt formulieren → Output prüfen). Verifikation hier noch ohne formale Tests (Prüfung an Beispieldaten).
- **Halluzinationen:** Erste systematische Beobachtung – TN sammeln Beispiele, in denen das LLM Funktionen halluziniert, die es in Python so nicht gibt.
- **Metakognition:** Reflexion „Welcher meiner Prompts war am effizientesten? Warum?"

### Differenzierung & Feinplanungshinweise
- Differenzierung über Aufgabenkomplexität: einfache Listenverarbeitung bis hin zu verschachtelten Dictionaries.
- Vorlagen für die Feinplanung: Prompt-Vorlagen (Spec-Template), Beobachtungsbogen Prompt-Iterationen, Mini-Aufgaben in drei Schwierigkeitsstufen.
- **Stolperstelle:** TN tendieren dazu, beim ersten KI-Output stehenzubleiben („das funktioniert ja"). Die Iterations-Disziplin (mindestens zwei Verbesserungsrunden, auch wenn Output schon „läuft") ist explizit zu üben.

---

## Modul M5 – Code lesen vor Code schreiben

**Phase:** 2 · **Anteil:** ca. 8 % · **Position:** Mitte von Phase 2

### Voraussetzungen
M2–M4 abgeschlossen, insbesondere Datenstrukturen.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN können einen ihnen unbekannten Codeschnipsel von 20–60 Zeilen verstehen, gliedern und in eigenen Worten erklären.
- Die TN identifizieren in einem Codeschnipsel die Datenfluss-Struktur (was kommt rein, was geht raus, welche Zwischenwerte entstehen).

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN unterscheiden zwischen „den Code überflogen" und „den Code verstanden" und benennen Indikatoren für letzteres.
- Die TN erkennen Stellen, an denen ein KI-generierter Code plausibel aussieht, aber nicht das Geforderte tut.

*Ebene B (KI-Nutzung – ergänzend)*
- Die TN nutzen das LLM zum Reformulieren und Annotieren eines Codes, nicht zur Generierung neuen Codes.

### Kerninhalte
- Lesestrategien für Python-Code: Top-down (Was ist die Aufgabe?), Bottom-up (Was tut diese Zeile?), Datenfluss-orientiert.
- Annotationstechniken: Inline-Kommentare, Zusammenfassungen am Funktionsanfang.
- Reverse Engineering von KI-Code: TN erhalten von DoLe oder vom LLM einen Code und müssen Zweck, Struktur und mögliche Schwächen herausarbeiten – **bevor** sie ihn ausführen.
- Parsons-Puzzles auf höherem Niveau (mit Distraktoren, also „falschen" Codezeilen, die nicht hineingehören).

### Didaktische Realisierung
- **Methode:** Methodisches Leitprinzip „Code-Reading vor Code-Writing" wird hier zentral umgesetzt. Reverse-Engineering-Sessions; Pair-Reading (zwei TN annotieren denselben Code unabhängig und vergleichen); Plenums-Lesungen.
- **KI-Rolle:** Erzeugt Lesematerial (mit kontrollierten Schwächen, gezielt durch DoLe-Prompting vorbereitet) und unterstützt das Verstehen, generiert aber keinen neuen Code für die TN.
- **DoLe-Rolle:** kuratiert Codeschnipsel mit didaktischer Absicht (z. B. ein Snippet, das funktioniert, aber stilistisch schwach ist; eines, das nicht funktioniert; eines, das halluzinierte Funktionen verwendet).

### Verifikation & Querschnittsthemen
- **Halluzinationen:** in diesem Modul intensiviert – TN üben gezielt, halluzinierte Bibliotheksaufrufe oder erfundene Methodensignaturen zu erkennen.
- **Metakognition:** Lernjournal-Eintrag: „An welcher Stelle hat mich der Code anfangs getäuscht? Was war der Aha-Moment?"
- **Datenschutz:** keine zusätzlichen Aspekte.

### Differenzierung & Feinplanungshinweise
- Schwierigkeitsstufung über Länge und Komplexität der Codeschnipsel; für stärkere TN auch Code in unbekannten Idiomen (z. B. Decorators als Vorausschau).
- Vorlagen für die Feinplanung: kuratierte Codeschnipsel-Sammlung („Lese-Kanon"), Annotationsschema, Distraktor-Parsons-Puzzles.
- **Stolperstelle:** TN überlesen Halluzinationen, weil die Plausibilität des LLM-Outputs hoch ist. Es lohnt, in der Feinplanung mindestens drei Code-Beispiele mit erfundenen Methoden vorzubereiten.

---

## Modul M6 – Funktionen, Module, Dekomposition

**Phase:** 2 · **Anteil:** ca. 12 % · **Position:** Hauptteil von Phase 2

### Voraussetzungen
M2–M5 abgeschlossen.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN schreiben Funktionen mit klar definierten Schnittstellen (Parameter, Rückgabewerte, Docstrings).
- Die TN zerlegen ein gegebenes Problem in mehrere kleine Funktionen.
- Die TN nutzen Module aus der Standardbibliothek (z. B. `math`, `random`, `datetime`, `pathlib`) und importieren sie korrekt.

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN formulieren **Spezifikationen pro Funktion**, die so präzise sind, dass ein LLM sie korrekt implementieren kann (Spec-driven Prompting).
- Die TN führen Pair Programming mit KI durch, in dem sie Architekturentscheidungen treffen und das LLM einzelne Funktionen ausarbeitet.

*Ebene C (Metakognition – ergänzend)*
- Die TN reflektieren, an welchen Stellen sie eine Aufgabe „im Kopf" lösen können und an welchen sie KI-Unterstützung sinnvoll einsetzen.

### Kerninhalte
- Funktionen: Signatur, Docstring, Single-Responsibility-Prinzip in Anfänger-Kontext.
- Modulimport, Standardbibliothek (Auswahl), strukturierte Skripte mit `if __name__ == "__main__"`.
- Dekomposition als Kompetenz: ein größeres Problem in 3–5 kleine Funktionen zerlegen.
- **Spec-driven Prompting:** Pro Funktion eine präzise Spezifikation, dann LLM beauftragen, dann Output gegen Spec prüfen.

### Didaktische Realisierung
- **Methode:** Pair Programming mit KI als zentrale Methode. Anfangs in Form von „Driver/Navigator", wobei TN Driver ist und LLM Navigator – mit ausdrücklicher Verantwortung des Drivers für jede Zeile. Plenumsdiskussionen über Architekturentscheidungen.
- **KI-Rolle:** ausführende Implementierungs-Hilfe für klar spezifizierte Funktionen. Erstmals in produktiver Rolle, allerdings stets mit Verifikation.
- **DoLe-Rolle:** Coach für Dekompositionsstrategien; reviewt Spezifikationen, bevor TN sie an das LLM geben.

### Verifikation & Querschnittsthemen
- **Prompt-and-Verify** ab hier in voller Form: Spec → Prompt → Code → Lesen → manueller Test → Übernahme oder Iteration.
- **Metakognition:** Reflexion „Was habe ich selbst entschieden, was hat das LLM entschieden?"
- **Datenschutz:** Erinnerung; keine personenbezogenen Daten in Specs einbauen.

### Differenzierung & Feinplanungshinweise
- Differenzierung über Aufgabengröße (eine Funktion vs. fünf zusammenwirkende Funktionen) und über Spezifikationsstrenge (vorgegebene Spec vs. selbst entwickelte Spec).
- Vorlagen für die Feinplanung: Spec-Template (mit Feldern für Zweck, Eingabe, Ausgabe, Randbedingungen, Beispiele), Pair-Programming-Rollenkarten, Dekompositions-Übungen ohne KI als Vorschalt.
- **Stolperstelle:** TN überspringen die Spec-Phase und prompten direkt drauflos. Eine harte Regel im Modul: erst Spec im Lernjournal, dann Prompt – ohne Spec keine Prompt-Erlaubnis.

---

## Modul M7 – Testen als Verifikationsstrategie

**Phase:** 2 · **Anteil:** ca. 10 % · **Position:** zweite Hälfte von Phase 2

### Voraussetzungen
M6 (Funktionen) abgeschlossen.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN schreiben einfache Tests mit `assert`, dem `unittest`-Modul und/oder `pytest`.
- Die TN unterscheiden zwischen Happy Path, Edge Case und Fehlerfall und decken alle drei in ihren Tests ab.

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN setzen Tests **vor** und **nach** KI-Output ein: zuerst Tests aus der Spec ableiten (ggf. KI-gestützt), dann Code generieren lassen, dann Tests laufen lassen.
- Die TN nutzen die KI zur Generierung **kritischer** Testfälle, nicht nur trivialer.

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN beschreiben den Unterschied zwischen „Code läuft" und „Code ist korrekt".
- Die TN erkennen, dass Tests die Hauptbrücke zwischen KI-Output und Vertrauen sind.

### Kerninhalte
- Testen mit `assert` als Einstieg.
- `unittest` und/oder `pytest` (Empfehlung: `pytest` wegen geringerer Boilerplate).
- Test-Pyramide auf Anfänger-Niveau (Unit-Tests im Vordergrund).
- Test-First-Workflow als Verifikationsmuster für KI-Output.
- Debugging-Challenges mit injizierten KI-Fehlern: DoLe stellt KI-generierten Code mit subtilen Bugs zur Verfügung; TN müssen diese mittels Tests aufdecken.

### Didaktische Realisierung
- **Methode:** Test-First-Sessions; Debugging-Challenges; Plenumsanalysen, in denen DoLe einen KI-Code zeigt, der „aussieht wie korrekt", aber bei richtigen Tests fällt. Verifikation als professionelle Routine etablieren.
- **KI-Rolle:** zweifach – einerseits als Code-Erzeuger (zu prüfen), andererseits als Test-Erzeuger (auch zu prüfen, weil LLMs gelegentlich Tests schreiben, die nichts testen).
- **DoLe-Rolle:** demonstriert die Verifikations-Routine als Profi-Habitus; bringt Beispiele aus der eigenen Erfahrung ein.

### Verifikation & Querschnittsthemen
- **Prompt-and-Verify:** wird hier in seine reife Form überführt. Verifikation = automatisierter Test plus manuelle Prüfung.
- **Halluzinationen:** Tests sind das wichtigste Werkzeug zur Halluzinationskontrolle.
- **Metakognition:** Reflexion „Wie habe ich Vertrauen in den Code aufgebaut – über Lesen, Testen oder beides?"

### Differenzierung & Feinplanungshinweise
- Differenzierung über Testabdeckung (Pflicht: Happy Path; ergänzend: Edge Cases, Fehlerfälle).
- Vorlagen für die Feinplanung: Test-Templates, Debugging-Challenges (vorbereitet mit kontrolliert fehlerhaftem KI-Code), Test-Checkliste.
- **Stolperstelle:** TN schreiben Tests, die nur den Happy Path bestätigen. Eine explizite Regel im Modul: jeder Test-Set enthält mindestens einen Edge Case. Außerdem ist die Versuchung groß, das LLM die Tests **und** den Code schreiben zu lassen – das untergräbt die Verifikationsidee. Im Modul wird festgelegt: wenn das LLM den Code schreibt, schreibt der Mensch (wenigstens einen Teil der) Tests, und umgekehrt.

---

## Modul M8 – Halluzinationen, Lizenzen, Quellen

**Phase:** 2 · **Anteil:** ca. 6 % · **Position:** spät in Phase 2

### Voraussetzungen
M3–M7 abgeschlossen; eigene Erfahrungen mit KI-Output vorhanden.

### Lernziele

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN erkennen typische Halluzinationsmuster (erfundene Funktionen, falsche API-Signaturen, fingierte Quellenangaben).
- Die TN nutzen offizielle Dokumentation (PyPI, Python-Docs, Bibliotheks-Repos) als Primärquelle zur Verifikation.
- Die TN kennen die Grundzüge des EU AI Act (in Kraft seit 02.02.2025), die DSGVO-Implikationen für KI-Tool-Auswahl im Berufsumfeld und die Lizenzfragen bei KI-generiertem Code.

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN reflektieren über die Grenzen ihres eigenen Vertrauens in KI-Output.
- Die TN entwickeln eine persönliche Heuristik („Wann verifiziere ich wie tief?").

### Kerninhalte
- Halluzinationen: Definition, Beispiele, typische Auslöser (selten verwendete Bibliotheken, sehr aktuelle APIs, sehr spezifische Domänen).
- Quellen-Verifikation: offizielle Doku, vertrauenswürdige Tutorials, Versionsangaben, Datierung.
- Lizenzfragen: KI-generierter Code kann Trainingsdaten reproduzieren; konservative Empfehlung zur Nutzung in proprietären Kontexten; Hinweis auf Open-Source-Lizenzkompatibilität.
- DSGVO und EU AI Act im beruflichen Kontext: was darf in einen Prompt, was nicht; was bedeutet AVV; warum kostenfreie LLM-Versionen für Behördendaten ungeeignet sind.
- Bewusstsein: LLMs sind nach Losch et al. (2025) im Kern „stochastische Papageien" ohne Weltwissen, Intentionalität oder Bewusstsein.

### Didaktische Realisierung
- **Methode:** Faktencheck-Werkstatt (TN prüfen vorgegebene KI-Outputs gegen offizielle Doku); Plenumsdiskussion zu Lizenz- und Datenschutz-Szenarien aus dem Berufsalltag; Mini-Fallstudien.
- **KI-Rolle:** Untersuchungsgegenstand. Die KI selbst wird zum Untersuchungsobjekt – TN prompten gezielt schwierige Anfragen und beobachten, was passiert.
- **DoLe-Rolle:** moderiert die Reflexion; bringt aktuelle Beispiele aus der Praxis ein (auch eigene KI-Pannen, mit Vorbildwirkung).

### Verifikation & Querschnittsthemen
- Dieses Modul **ist** das Querschnittsthema in seiner konzentrierten Form.
- **Datenschutz:** wird hier vom Verfahrensthema (M1) zum Kompetenzthema – TN entwickeln Beurteilungsfähigkeit.
- **Metakognition:** Lernjournal-Eintrag: „Welcher KI-Output hat mich in diesem Kurs am meisten getäuscht?"

### Differenzierung & Feinplanungshinweise
- Differenzierung über Komplexität der Fallstudien (z. B. einfacher Halluzinationscheck vs. mehrschichtige Compliance-Bewertung).
- Vorlagen für die Feinplanung: Halluzinationen-Sammlung (kuratierte Beispiele aus dem Kursverlauf), Lizenz-Entscheidungsbaum, DSGVO/AI-Act-Kurzleitfaden für die Branche/Zielrolle.
- **Stolperstelle:** Modul kann trocken wirken. Es lebt von guten konkreten Beispielen – idealerweise solchen, die TN selbst im Kursverlauf erlebt haben (deshalb spät platziert).

---

## Modul M9 – Datenarbeit (CSV, JSON, Visualisierung)

**Phase:** 2 · **Anteil:** ca. 10 % · **Position:** Abschluss der Phase 2

### Voraussetzungen
M2–M7 abgeschlossen, M8 idealerweise auch.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN lesen und schreiben CSV- und JSON-Dateien mit Standardbibliothek-Mitteln (`csv`, `json`) und/oder `pandas` (je nach Kursfokus).
- Die TN führen einfache Datenaufbereitung durch (Filterung, Aggregation, einfache Transformation).
- Die TN erstellen einfache Visualisierungen (z. B. mit `matplotlib` oder `plotly`).

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN nutzen die KI als Beschleuniger für Datenexploration (Schema verstehen, erste Hypothesen, Code-Skelette).
- Die TN halten Spec-driven Prompting auch in datenintensiven Aufgaben ein und prüfen Outputs gegen Beispieldaten.

### Kerninhalte
- Dateiformate: CSV, JSON, einfache strukturierte Daten.
- Standardbibliothek vs. `pandas` (kursabhängig; für „Data Analyst"-Kontexte ist `pandas` Pflicht, für reine Python-Grundlagenkurse genügt die Standardbibliothek).
- Einfache Visualisierungen, Lese-Schreibe-Pipelines, Datenqualitätschecks.
- Mini-Projekt-Format als Vorbereitung auf M10.

### Didaktische Realisierung
- **Methode:** kleinformatige projektartige Arbeit – TN bekommen einen Datensatz und eine Frage, sollen mit KI-Unterstützung eine kurze Analyse durchführen, Ergebnis dokumentieren.
- **KI-Rolle:** Beschleuniger und Sparringspartner für Daten-Exploration. Erstmals annähernd realnah eingesetzt, aber noch in begrenztem Umfang.
- **DoLe-Rolle:** Projekt-Coach; reviewt Zwischenstände.

### Verifikation & Querschnittsthemen
- **Prompt-and-Verify:** ergänzt durch Datenkontext-Prüfung – passt das Ergebnis zur Datenstruktur?
- **Datenschutz:** Datensätze müssen frei von personenbezogenen Klardaten sein oder vorab pseudonymisiert; explizite Auswahlbegründung durch DoLe.
- **Metakognition:** Reflexion „Was war an dieser Datenarbeit ohne KI undenkbar gewesen, was hätte ich auch ohne KI gut hingekriegt?"

### Differenzierung & Feinplanungshinweise
- Differenzierung über Datensatz-Größe und Komplexität, über Aufgabenoffenheit (vorgegebene Frage vs. eigene Frage).
- Vorlagen für die Feinplanung: Datensatzauswahl (mit Lizenz- und DSGVO-Check), Mini-Projekt-Briefings, Dokumentationsschema.
- **Stolperstelle:** Versuchung, die KI das ganze Mini-Projekt machen zu lassen. Im Modul gilt: mindestens die Frage, die Erst-Exploration der Daten, die Bewertung des Ergebnisses sind menschliche Tätigkeiten.

---

## Modul M10 – Projektphase „KI-Dirigent:in"

**Phase:** 3 (Programmierer:in als KI-Dirigent:in) · **Anteil:** ca. 15 % · **Position:** Hauptteil von Phase 3

### Voraussetzungen
Alle vorherigen Module abgeschlossen.

### Lernziele

*Ebene A (Python – Schwerpunkt)*
- Die TN setzen ein zusammenhängendes kleines Projekt mit mehreren Funktionen, einfacher Modulstruktur und Tests um.

*Ebene B (KI-Nutzung – Schwerpunkt)*
- Die TN durchlaufen den vollständigen Workflow: Spec → Prompt → Iteration → Code-Review → Test → Dokumentation.
- Die TN orchestrieren KI-Unterstützung über mehrere Iterationen, ohne sich darin zu verlieren („agentic engineering"-Grundhaltung im Anfänger-Maßstab).
- Die TN dokumentieren ihren KI-Einsatz transparent.

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN reflektieren ihre eigene Rolle im Projekt: Welche Entscheidungen waren menschlich, welche maschinell unterstützt?
- Die TN erkennen, an welchen Stellen sie noch Übung brauchen.

### Kerninhalte
- Projekt-Workflow von Anforderung bis Auslieferung, im Anfänger-Maßstab.
- Versionsmanagement der **Prompts** (nicht des Codes – Git ist nicht Pflicht, kann aber in der Feinplanung integriert werden).
- Code-Review-Routinen: lesen, hinterfragen, verbessern.
- Dokumentation des KI-Einsatzes als Berufsstandard (Was wurde generiert, wo wurde verifiziert, welche Entscheidungen sind menschlich?).
- Optional: einfacher Einsatz eines „agentischen" Tools (Copilot, Cursor, Claude Projects) im überwachten Rahmen, um die Karpathy-2026-Zielfigur erlebbar zu machen.

### Didaktische Realisierung
- **Methode:** offenere Projektarbeit; TN wählen aus einer Liste von Projektthemen oder schlagen eigene vor (mit DoLe-Freigabe). Pair- oder Einzelarbeit. Regelmäßige Stand-up-artige Reviews im Plenum.
- **KI-Rolle:** voll integriert, aber unter expliziter menschlicher Verantwortung. Die TN führen Projekt-Tagebücher mit Prompt-Logs.
- **DoLe-Rolle:** Sparringspartner:in im Karpathy-2026-Sinn („oversight"), nicht Lösungsgeber:in. Coaching auf Architektur und Verifikationsroutine.

### Verifikation & Querschnittsthemen
- **Prompt-and-Verify:** Projekt-Realisierung ist die Reifeprüfung dieses Workflows.
- **Open-AI-Assessment:** dieses Modul ist der natürliche Ort für eine prozessorientierte Bewertung gemäß SWK-2024-Empfehlung. Konkrete Bewertungsraster sind Sache der Feinplanung; konzeptionell wird hier sowohl Ergebnis (Code, Tests, Doku) als auch Prozess (Prompt-Log, Reflexion) bewertet.
- **Metakognition:** Lernjournal-Eintrag: „Wo war ich Dirigent:in, wo war ich nur Mitläufer:in?"

### Differenzierung & Feinplanungshinweise
- Differenzierung über Projektgröße, Vorstrukturierung, Pair vs. Solo.
- Projektthemen sollen realnah, aber überschaubar sein und die Datenkompetenz aus M9 nutzen.
- Vorlagen für die Feinplanung: Projektthemen-Pool (mit Schwierigkeitsstufen), Projekt-Tagebuch-Vorlage, Stand-up-Format, Bewertungsleitfaden (in der Feinplanung auszuarbeiten), Doku-Schablone.
- **Stolperstelle:** Projektscope. Anfänger:innen unterschätzen den Aufwand systematisch. Die Feinplanung sollte enge Scope-Vorgaben formulieren und ein klares „minimum viable product" pro Projekt definieren.

---

## Modul M11 – Reflexion & Transfer

**Phase:** 3 · **Anteil:** ca. 6 % · **Position:** Kursabschluss

### Voraussetzungen
M1–M10 abgeschlossen.

### Lernziele

*Ebene C (Metakognition – Schwerpunkt)*
- Die TN bilanzieren ihre Lernreise anhand des in M1 angelegten Lernjournals.
- Die TN erstellen eine persönliche Kompetenzkarte (Was kann ich? Was kann ich noch nicht? Was will ich als nächstes lernen?).
- Die TN positionieren sich auf dem Spektrum „Vibe Coding ↔ Augmented Coding ↔ Agentic Engineering" und begründen ihre Position.

*Ebene B (KI-Nutzung – ergänzend)*
- Die TN formulieren eine persönliche „KI-Nutzungsdoktrin" für den künftigen Berufsalltag.

*Ebene A (Python – ergänzend)*
- Keine neuen Inhalte; Konsolidierung.

### Kerninhalte
- Auswertung des Lernjournals.
- Kompetenzkarte als visuelle Selbstverortung.
- Anschluss-Lernpfade (Datenanalyse-Vertiefung, Web-Backend, Test-Automatisierung, Machine Learning – jeweils mit Realismus-Hinweis).
- Berufliche Perspektiven: Wie kommuniziere ich meine KI-Kompetenz im Bewerbungsgespräch?
- Ausblick auf Werkzeug-Veränderungen (Volatilitäts-Bewusstsein: das, was hier gelernt wurde, gilt – die Tools werden sich weiterentwickeln, das Konzept ist 12–18 Monate gültig).

### Didaktische Realisierung
- **Methode:** strukturierte Reflexion (Einzelarbeit + Plenum), Kompetenzkarten-Werkstatt, Peer-Feedback, Abschlussgespräch.
- **KI-Rolle:** marginal; ggf. zur Strukturierung von Reflexionstexten.
- **DoLe-Rolle:** Bilanzgesprächspartner:in; gibt individualisiertes Feedback und Ausblick.

### Verifikation & Querschnittsthemen
- **Metakognition:** dieses Modul ist die metakognitive Konsolidierungsphase.
- **Lernjournal:** wird ausgewertet und dem TN zur weiteren Nutzung übergeben.

### Differenzierung & Feinplanungshinweise
- Geringe Differenzierungsnotwendigkeit; Selbstreflexion ist individuell.
- Vorlagen für die Feinplanung: Kompetenzkarten-Schablone, Reflexionsleitfaden, Anschluss-Lernpfad-Übersicht (träger- bzw. zielgruppenspezifisch), Bewerbungs-/Beratungs-Hilfsmittel.
- **Stolperstelle:** Reflexion droht ins Generische zu kippen. In der Feinplanung sollten konkrete Anker geschaffen werden (z. B. „Wähle drei Lernjournal-Einträge, die für dich heute besonders aussagekräftig sind, und erkläre warum").

---

## Querschnittsthemen-Mapping

Die drei Querschnittsthemen aus dem Konzept ziehen sich durch alle Module, mit unterschiedlichen Schwerpunkten:

| Querschnittsthema | M1 | M2 | M3 | M4 | M5 | M6 | M7 | M8 | M9 | M10 | M11 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Datenethik / Datenschutz / Lizenzen | ● | – | ○ | ○ | – | ○ | – | ● | ○ | ○ | – |
| Halluzinationserkennung / Verifikation | ○ | – | ○ | ● | ● | ● | ● | ● | ● | ● | ○ |
| Metakognition | ● | ○ | ● | ○ | ● | ○ | ● | ● | ○ | ● | ● |

Legende: ● Schwerpunkt · ○ präsent · – nicht im Fokus

---

## Hinweise zur Feinplanung

Die folgenden Punkte sind in der Feinplanung pro Modul zu konkretisieren:

1. **Konkrete Übungsaufgaben** pro Modul, in mindestens drei Schwierigkeitsstufen.
2. **Tagesabläufe / Stundenrhythmen**, abhängig vom konkreten Trägerformat (Vollzeit, Teilzeit, online/präsenz, geblockt/verteilt).
3. **Bewertungsraster** für die Open-AI-Assessment-Komponenten und die hilfsmittelfreien Kurzformate.
4. **Materialien:** Codebeispiele, Parsons-Puzzles, Tracing-Tabellenblätter, Spec-Templates, Prompt-Bibliothek, Test-Templates, Datensätze (mit Lizenz/DSGVO-Check), Projektthemen-Pool.
5. **Werkzeug-Konkretisierung:** finale Auswahl der KI-Werkzeuge, der Python-Umgebung und ggf. der Versionsverwaltung – mit dokumentierter DSGVO-Bewertung.
6. **Lehrkraft-Routinen:** Beobachtungsbögen, Stand-up-Formate, Lernjournal-Auswertungs-Schablonen.
7. **Evaluation der Wirksamkeit:** wie wird gemessen, ob die didaktischen Ziele erreicht wurden? (Kursabschluss-Befragung, Outcome-Vergleich über Kohorten, Feedback-Schleifen.)

**Skalierung auf konkrete Kursdauern (grobe Richtwerte):**

| Kursdauer | Phase 0 | Phase 1 | Phase 2 | Phase 3 |
|---|---|---|---|---|
| 40 UE | 1–2 UE | 5 UE | 25 UE | 8 UE |
| 80 UE | 2–3 UE | 10 UE | 51 UE | 17 UE |
| 120 UE | 4 UE | 14 UE | 77 UE | 25 UE |
| 200 UE | 6 UE | 24 UE | 128 UE | 42 UE |

Diese Werte sind Orientierungen, keine Vorschriften. Bei kürzeren Kursen empfiehlt es sich, Module zusammenzufassen (z. B. M3+M4, M8 als Querschnittsbestandteil verteilen). Bei längeren Kursen lassen sich M9 und M10 ausbauen sowie ein zusätzliches Vertiefungsmodul (z. B. „APIs und Web-Daten") einschieben.

**Trigger zur Modulanpassung im laufenden Kurs:**

- Wenn in M2 die Diagnostik zeigt, dass Tracing noch nicht sicher beherrscht wird, M3 verzögern und M2 verlängern.
- Wenn in M5 die Halluzinationserkennung zu oft scheitert, M8 vorziehen und mit M5 verschränken.
- Wenn in M7 Tests systematisch nur den Happy Path abdecken, eine zusätzliche Debugging-Challenge-Sitzung einschieben.
- Wenn in M10 der Projektscope durchgehend gesprengt wird, in der nächsten Kohorte engere Vorlagen vorgeben.

---

*Diese Modulstruktur ist die Grundlage der Feinplanung. Sie ist konzeptintern konsistent (Drei-Phasen-Modell, Sechs Leitprinzipien, Drei-Ebenen-Lernziele) und hinreichend flexibel, um sich an unterschiedliche deutsche Bildungsträger-Formate anzupassen. Sie sollte alle 12–18 Monate auf Aktualität überprüft werden, da sich die Werkzeug- und Begriffslandschaft schnell weiterentwickelt.*
