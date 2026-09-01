## TL;DR
- **Empfohlen wird ein dreistufiges Curriculum mit einer kurzen, bewusst KI‑freien Fundierungsphase, einer KI‑augmentierten Übungsphase und einer Phase „Programmierer:in als KI‑Dirigent:in"**, weil aktuelle Studien aus der CS‑Education‑Forschung (Prather et al. 2024, Vadaparty/Porter et al. 2024, Denny et al. 2023) zeigen, dass frühe, ungebremste KI‑Nutzung bei Anfänger:innen metakognitive Defizite verstärkt, während ein strukturierter Übergang die berufsrelevanten Kompetenzen (Prompting, Code‑Review, Verifikation) systematisch aufbaut.
- **Die Lernziele werden gegenüber klassischen Python‑Kursen umgewichtet:** weniger reines „Code‑Writing aus dem Kopf", deutlich mehr Code‑Reading, Testen, Dekomposition, Prompt‑Engineering, kritische Verifikation und ethisch‑rechtliche Reflexion – im Einklang mit den GI‑Bildungsstandards Sek I (verabschiedet am 31.01.2025), dem SWK‑Impulspapier vom Januar 2024 und der KMK‑Handlungsempfehlung vom 10.10.2024.
- **Methodisch tragend sind sechs Prinzipien:** „KI‑freie Fundierung vor KI‑Nutzung", „Prompt‑and‑Verify als Standard‑Workflow", „Code‑Reading vor Code‑Writing", „Open‑AI‑Assessment statt Plagiatskontrolle", „Dozent:in als Sparringspartner:in" und „Datenschutz‑by‑Default" (insbesondere für Behördenkontexte wie BFD, Agentur für Arbeit, BWSA).

---

## Key Findings

1. **Die Rolle der Programmiererin verändert sich messbar, aber nicht in Richtung Auflösung.** Andrej Karpathy prägte am 2. Februar 2025 auf X den Begriff „Vibe Coding"; in einem Folgepost vom 4. Februar 2026 revidierte er sich selbst und sprach stattdessen von „**agentic engineering** … because the new default is that you are not writing the code directly 99% of the time, you are orchestrating agents who do and acting as oversight – 'engineering' to emphasize that there is an art & science and expertise to it" (zit. n. The New Stack, 10.2.2026). Kent Beck und Simon Willison nennen dieses verantwortungsvolle Pendant „augmented coding" bzw. „vibe engineering". Für die Didaktik folgt: Ziel ist nicht Vibe Coding, sondern souveräne KI‑augmentierte Software‑Entwicklung.

2. **Empirie ist gemischt – Skill‑Atrophy ist real, aber bewältigbar.** Die MIT‑Media‑Lab‑Studie „Your Brain on ChatGPT" (Kosmyna et al., 2025) zeigt EEG‑basiert „cognitive debt" bei dauerhafter LLM‑Nutzung; Prather et al. (ICER 2024, „The Widening Gap") zeigen, dass schwächere Anfänger:innen mit GenAI mehr metakognitive Schwierigkeiten entwickeln, während stärkere profitieren. Die METR‑Studie vom Juli 2025 (arXiv 2507.09089) untersuchte 16 Entwickler mit moderater KI‑Erfahrung, die 246 Tasks in eigenen Mature‑Projekten (durchschnittlich 5 Jahre Vorerfahrung) mit Cursor Pro und Claude 3.5/3.7 Sonnet bearbeiteten; sie fand eine kontraintuitive 19 %‑Verlangsamung bei zugleich subjektiv prognostizierter 24 %‑Beschleunigung **vor** und subjektiv empfundener 20 %‑Beschleunigung **nach** dem Versuch. Demgegenüber stehen das GitHub‑Copilot‑RCT von Peng et al. 2023 (n=95 professionelle Entwickler:innen, JavaScript‑HTTP‑Server‑Aufgabe) mit einer 55,8 %‑Beschleunigung und das Microsoft‑Economics‑Working‑Paper Cui et al. 2023, das eine Steigerung der wöchentlichen Pull‑Requests um „26.08% (SE: 10.3%)" misst.

3. **Die deutsche Bildungspolitik fordert konstruktiv‑kritischen Umgang, nicht Verbot.** Die KMK‑Handlungsempfehlung vom 10.10.2024, das SWK‑Impulspapier vom Januar 2024 und das GI‑Positionspapier vom 17.07.2023 („Keine Verbote") konvergieren: KI‑Werkzeuge sollen nicht verbannt, sondern reflektiert eingesetzt werden; basale Kompetenzen müssen jedoch zuerst aufgebaut werden. Die GI‑Bildungsstandards Sek I (verabschiedet am 31.01.2025) verankern KI‑Konzepte querschnittlich (insbesondere AL‑9, ID‑8, ID‑11, IMG‑8), halten aber bewusst an „fundamentalen informatischen Konzepten" fest, ohne tagesaktuelle Begriffe wie „LLM" oder „generative KI" einzuführen.

4. **In der CS‑Education‑Forschung hat sich ein Methoden‑Korpus etabliert:** Prompt Problems / Promptly (Denny et al. 2023, arXiv 2307.16364), Parsons‑Puzzles als Scaffolding (Hou et al., CodeTailor, L@S 2024), CS50‑Duck mit pädagogischen Guardrails (Harvard, seit 2023), CS1‑LLM (Vadaparty/Porter et al., ITiCSE 2024). Diese Methoden lassen sich für deutsche Bildungsträgerkontexte adaptieren.

5. **Datenschutz ist im deutschen Behördenkontext (BFD, Agentur für Arbeit, BWSA) kein Nebenaspekt, sondern Konzept‑konstitutiv.** Die kostenfreie ChatGPT‑Version ist nach Tätigkeitsbericht 2023 des Landesbeauftragten für den Datenschutz Niedersachsen sowie nach Einschätzung der KMK (2024) nicht DSGVO‑konform für die Eingabe personenbezogener Daten; tragfähig sind ausschließlich Enterprise‑/API‑Zugänge mit Auftragsverarbeitungsvertrag, EU‑Data‑Residency und deaktiviertem Modelltraining – oder europäische Alternativen (Mistral, Aleph Alpha) bzw. didaktische Frontends mit Pseudonym‑Zugang (fobizz‑Klassenraum, schulKI).

---

## Details

### 1. Theoretische Grundlegung und Begründung

#### 1.1 Wandel der Programmierer-Rolle (2024–2026)

Der Diskurs verlief in drei Phasen. Bis 2022 dominierte die Frage, ob LLMs überhaupt CS1‑Aufgaben lösen können – Finnie‑Ansley et al. („The Robots Are Coming", ACE 2022) zeigten erstmals, dass OpenAI Codex die Mehrheit typischer Einsteiger:innen‑Aufgaben löst. 2023 verschob sich die Debatte zur Frage, wie sich Curricula anpassen müssen (Prather et al., „The Robots Are Here", ITiCSE‑WGR 2023). Seit 2024/25 stehen drei konkurrierende Praktiker‑Begriffe im Raum:

- **Vibe Coding** (Karpathy, X‑Post vom 2.2.2025): „forget that the code even exists" – LLM erzeugt, Mensch akzeptiert weitgehend ungeprüft. Karpathy selbst markierte dies als experimentell für „throwaway weekend projects".
- **Agentic Engineering** (Karpathy, X‑Post vom 4.2.2026): Orchestrierung statt direkten Codeschreibens, Mensch als Aufseher mit Expertise.
- **Augmented Coding / Vibe Engineering** (Kent Beck; Simon Willison): disziplinierte AI‑Nutzung mit Tests, Reviews und Architekturverantwortung; Willison: „If an LLM wrote every line of your code, but you've reviewed, tested, and understood it all, that's not vibe coding – that's using an LLM as a typing assistant."

Daraus folgt didaktisch: Anfänger:innen sollen **nicht** Vibe Coding lernen, sondern in Richtung Augmented Coding / Agentic Engineering sozialisiert werden. Ein Kurs auf Einsteiger‑/Grundlagenniveau muss diese Zielfigur explizit benennen.

#### 1.2 Kompetenzverschiebung

| Klassische Gewichtung (vor 2023) | Neue Gewichtung |
|---|---|
| Code aus dem Kopf schreiben (Syntax‑Drill) | Code lesen, verstehen, erklären |
| Syntax‑Memorisierung | Problem‑Dekomposition |
| Eigenständiges Debugging | Prompt‑Formulierung & Iteration |
| Fehlermeldungen interpretieren | Verifikation von KI‑Output (Tests, Type‑Checks) |
| Algorithmen‑Bibliothek im Kopf | Architektur‑ und Datenflussverständnis |
|  | Kritische Beurteilung (Halluzinationen, Sicherheit, Lizenz) |
|  | Metakognition (Planung, Monitoring, Reflexion) |

Vadaparty/Porter et al. (CS1‑LLM, ITiCSE 2024) haben dies in einem realen UC‑San‑Diego‑Kurs umgesetzt: weniger Syntax‑Drill, stärkerer Fokus auf „explaining code, testing code, and decomposing large problems into small functions that are solvable by an LLM."

#### 1.3 Skill Atrophy, Cognitive Offloading, metakognitives Risiko

Die Risiken sind empirisch belegt:

- **MIT Media Lab (Kosmyna et al., 2025), „Your Brain on ChatGPT":** Über vier Monate zeigten LLM‑Nutzer:innen schwächste neuronale Konnektivität (EEG), geringste Eigentümerschaft am Output, geringste Erinnerungsleistung an die eigenen Texte. Dies ist eine Schreib‑, nicht Programmier‑Studie, ihr Konzept der „cognitive debt" wird in der Programmierdidaktik aber breit rezipiert.
- **Prather et al., „The Widening Gap" (ICER 2024):** GenAI **vergrößert** die Kluft zwischen starken und schwachen Novizen. Schwache Lernende entwickeln „illusion of competence" und neue metakognitive Schwierigkeiten.
- **Ma et al., „Scaffolding Metacognition" (arXiv 2511.04144, 2025):** Analyse von >10.000 Dialog‑Logs zeigt, dass Anfänger:innen oft vage Prompts stellen und Antworten unkritisch übernehmen.
- **„Mitigating Epistemic Debt" (arXiv 2602.20206, 2026):** „collapse of competence" – uneingeschränkte Vibe‑Coder erreichen vergleichbare funktionale Qualität wie strukturiert angeleitete, scheitern aber zu 77 % an einem 30‑minütigen Wartungsauftrag ohne KI (vs. 39 % im scaffolded group).

Zugleich existiert empirische Evidenz für **Produktivitätsgewinne** in professionellen Kontexten (Peng et al. 2023: 55,8 %‑Beschleunigung im RCT; Cui et al. 2023: +26,08 % Pull Requests pro Woche, SE 10,3 %). Die METR‑Studie (Juli 2025) zeigt jedoch für 16 erfahrene Open‑Source‑Entwickler in eigenen Codebasen mit Cursor Pro und Claude 3.5/3.7 Sonnet eine 19 %‑Verlangsamung trotz subjektiv prognostizierter 24 %‑ und subjektiv empfundener 20 %‑Beschleunigung – ein wichtiger didaktischer Befund: **subjektives Effizienzempfinden ist kein verlässlicher Indikator**.

#### 1.4 Spannungsfeld „mit/ohne KI von Anfang an"

Zwei Pole sind in der internationalen CS‑Education‑Community vertreten:

- **Volle Integration ab Tag 1** (Vadaparty/Porter et al. 2024; Porter & Zingaro Lehrbuch „Learn AI‑Assisted Python Programming", 2. Auflage 2024): Da Profis KI nutzen und LLMs CS1‑Aufgaben lösen, sei Drill kontraproduktiv; Curriculum auf Decomposition und Testing umbauen.
- **Skeptische Position / „KI‑freie Fundierung":** Prather et al. (ICER 2024) und das SWK‑Impulspapier mahnen: „Übernehmen LLM frühzeitig die Textproduktion, wird diese Kompetenzentwicklung behindert und im ungünstigsten Fall unterbunden." Die SWK rät, „in der Grundschule und zu Beginn der Sekundarstufe I … weitgehend auf LLM" zu verzichten und basale Kompetenzen aufzubauen.

Das hier vorgeschlagene Konzept positioniert sich **zwischen** beiden Polen: kurze, bewusste KI‑freie Fundierungsphase (~10–15 % der Kurszeit), gefolgt von früh einsetzender, didaktisch eingehegter KI‑Nutzung. Begründung: Erwachsene Lernende in BFD‑/Arbeitsagentur‑Kontexten haben einen klaren Verwertungshorizont und brauchen einen schnellen Zugriff auf moderne Werkzeuge, dürfen aber nicht ohne Grundkonzepte mit ihnen arbeiten.

#### 1.5 Theoretische Bezugsrahmen

- **AI Literacy** nach Long & Magerko (CHI 2020): 17 Kompetenzen entlang von fünf Leitfragen („What is AI?", „What can AI do?", „How does AI work?", „How should AI be used?", „How do people perceive AI?").
- **Cognitive Load Theory / Constructivism:** Parsons‑Puzzles und Worked Examples reduzieren Cognitive Load und sind LLM‑resilient (Denny SIGCSE 2024 Keynote „A Puzzling Programming Pedagogy").
- **GI / Frankfurt‑Dreieck:** Drei Perspektiven – technologisch („Wie funktioniert das?"), gesellschaftlich‑kulturell („Wie wirkt das?"), anwendungsorientiert („Wie nutze ich das?"). Im GI‑Positionspapier 2023 explizit aufgegriffen.
- **Situated Learning / Cognitive Apprenticeship:** zentraler Rahmen für „Pair Programming mit KI", „Prompt‑and‑Verify".
- **„Versierte Koaktivität"** (Cress & Kimmerle 2023, im SWK‑Impulspapier 2024 zitiert): die KI als Denkwerkzeug zielgerichtet nutzen, statt Aufgaben an sie auszulagern.

---

### 2. Lernzieltaxonomie

Die Lernziele werden in einer um KI‑Dimensionen erweiterten Anderson/Krathwohl‑Taxonomie auf drei Ebenen formuliert.

#### 2.1 Drei‑Ebenen‑Modell

| Ebene | Inhalt | Anteil im Kurs |
|---|---|---|
| **A – Python‑Kernkompetenzen** | Datentypen, Kontrollstrukturen, Funktionen, Standardbibliotheken, OOP‑Grundzüge, Fehlerbehandlung, Dateioperationen, einfaches Testen | 40–50 % |
| **B – KI‑Nutzungskompetenzen** | Prompt‑Engineering, Tool‑Auswahl, Verifikationsmuster, Kontext‑Bereitstellung, Iterations‑Disziplin, Versionsmanagement von Prompts | 25–35 % |
| **C – Metakognition & kritisches Urteil** | Planen, Monitoring, Reflexion eigener Arbeit; Halluzinationserkennung, Lizenz‑/Datenschutz‑Bewusstsein, ethische Beurteilung, Eigenkompetenz‑Selbsteinschätzung | 20–25 % |

#### 2.2 Lernziel‑Matrix (gekürzt, exemplarisch)

| Anderson/Krathwohl‑Stufe | Ebene A: Python | Ebene B: KI‑Nutzung | Ebene C: Metakognition |
|---|---|---|---|
| Erinnern | Syntax‑Elemente nennen | Prompt‑Muster nennen | Halluzinations‑Indikatoren benennen |
| Verstehen | Programmverlauf nachvollziehen (Tracing) | Funktionsweise eines LLM grob erklären („stochastische Papageien", Losch et al. 2025) | Grenzen der eigenen Kompetenz benennen |
| Anwenden | Funktionen schreiben & ausführen | Prompts iterativ verbessern | Verifikationsschritte einsetzen |
| Analysieren | Code‑Strukturen vergleichen | KI‑Output mit Spec abgleichen | Eigenes Vorgehen dokumentieren |
| Bewerten | Code‑Qualität beurteilen | KI‑Vorschlag annehmen/ablehnen begründen | Über‑/Unterabhängigkeit von KI reflektieren |
| Erschaffen | Eigene Module komponieren | Aus Spec → Prompt → Tests → Code‑Pipeline aufbauen | Eigene Lernstrategie weiterentwickeln |

#### 2.3 Unterschied zu klassischen Python‑Kursen

Klassische Kurse fokussieren in der Regel ~80 % auf Ebene A. Das vorgeschlagene Konzept verlagert ca. ein Drittel der Lernzeit auf B und C. Die Ebene‑A‑Lernziele werden zudem feiner ausdifferenziert: Code‑Lesen und Tracing erhalten dasselbe Gewicht wie Code‑Schreiben (vgl. Denny et al., „Prompt Problems", arXiv 2311.05943; Vadaparty/Porter, CS1‑LLM, 2024).

---

### 3. Modulstruktur und Curriculumsaufbau

#### 3.1 Drei‑Phasen‑Modell mit Sequenzierungsbegründung

**Phase 0 – Orientierung & Setup (2–4 Stunden)**
Tooling, didaktischer Kontrakt zur KI‑Nutzung („wann, wie, mit welchen Tools – und wann ausdrücklich nicht"), Datenschutzbelehrung im BFD‑/Behördenkontext. Begründung: Heterogene Vorkenntnisse müssen ohne Stigmatisierung erhoben werden; manche TN sind bereits ChatGPT‑Power‑User, andere haben das Tool nie genutzt.

**Phase 1 – KI‑freie Fundierung (~10–15 % der Kurszeit)**
Bewusst ohne LLM; Ziel: notional machine, mentales Modell für Variablen, Kontrollfluss, Funktionen. Methode: Live‑Coding, Tracing, Parsons‑Puzzles. Begründung: SWK 2024 und MIT‑Studie; ohne dieses Fundament verstehen TN später KI‑Output nicht. Dauer absichtlich kurz, um Erwachsene nicht zu demotivieren.

**Phase 2 – KI‑augmentiertes Lernen (~50–60 %)**
Ab hier KI als „Lernpartner" (Erklärungen, Debugging‑Hilfe, Beispielgeneratoren – idealerweise mit pädagogischen Guardrails wie CS50‑Duck, CodeHelp oder CodeAid). Strikt durchgängig: das **Prompt‑and‑Verify‑Pattern** (siehe 4.1).

**Phase 3 – Programmierer:in als KI‑Dirigent:in (~25–30 %)**
Größere Projekte, in denen TN ein Spec → Prompt → Code‑Review → Test‑Pipeline durchlaufen. Methodisches Leitbild: „augmented coding" (Beck) bzw. „agentic engineering" (Karpathy 2026). Hier wird die professionelle Zielfigur explizit eingeübt.

#### 3.2 Modulskizzen

| # | Modultitel | Zentrale Inhalte | Kompetenz‑Ebene |
|---|---|---|---|
| M1 | Orientierung & KI‑Vertrag | Setup, Datenschutz, Selbstreflexion „Wo stehe ich?" | C |
| M2 | Python‑Fundierung ohne KI | Variablen, Kontrollfluss, Funktionen – per Hand | A |
| M3 | KI als Lernpartner | Erklärungslassen, Was‑wäre‑wenn, Codetracing mit LLM | A+B |
| M4 | Datenstrukturen & Prompt‑Disziplin | Listen, Dicts; gleichzeitig: gute Prompts schreiben | A+B |
| M5 | Code lesen vor Code schreiben | KI‑Output annotieren, Parsons‑Puzzles, Reverse Engineering | A+C |
| M6 | Funktionen, Module, Dekomposition | Problem zerlegen, kleine Funktionen LLM‑tauglich spezifizieren | A+B |
| M7 | Testen als Verifikationsstrategie | unittest/pytest, „Tests vor/nach KI‑Output" | A+B+C |
| M8 | Halluzinationen, Lizenzen, Quellen | Faktencheck, Lizenzfragen bei KI‑Code, AI Act/DSGVO | C |
| M9 | Datenarbeit (CSV, JSON, kleine Visualisierung) | Realistische Mini‑Projekte mit KI‑Unterstützung | A+B |
| M10 | Projektphase „KI‑Dirigent:in" | Spec → Prompt → Iteration → Review → Test → Doku | A+B+C |
| M11 | Reflexion & Transfer | Eigene Lernreise, Selbstkompetenz, Übergang in den Beruf | C |

Dies ist ein Modul‑**Rahmen** – keine operative Tagesplanung. Jedes Modul kann je nach Trägerformat (Vollzeit‑Umschulung, Teilzeit, Bildungsgutschein, BFD‑Kurs) zwischen ½ Tag und 1 Woche umfassen.

#### 3.3 Querschnittsthemen

Drei Themen ziehen sich durch alle Module:

1. **Datenethik / Datenschutz / Lizenzen** – DSGVO, EU AI Act (in Kraft seit 2.2.2025, schrittweise Geltung bis 2027), Lizenzfragen bei KI‑generiertem Code, Behördenrelevanz.
2. **Halluzinationserkennung & Verifikation** – jedes Modul hat mindestens einen Moment, in dem LLM‑Output bewusst fehlerhaft ist und identifiziert werden muss.
3. **Metakognition** – Lernjournal/Lernlogbuch, Selbsteinschätzungen, „Was hätte ich ohne KI gemacht?"‑Reflexionen.

---

### 4. Methodik und didaktische Prinzipien

#### 4.1 Sechs Leitprinzipien

1. **„KI‑freie Fundierung vor KI‑Nutzung"** – kurz, fokussiert auf das mentale Modell. Begründet durch SWK 2024 und MIT‑Befunde zur Cognitive Debt.
2. **„Prompt‑and‑Verify als Standard‑Workflow"** – jeder KI‑Output durchläuft eine vereinbarte Verifikation: Lesen → Erklären (wahlweise an die Lerngruppe oder per „Rubber‑Duck") → Test → Übernahme/Verwerfung. Anschluss an Willisons Definition: Review macht aus Vibe Coding regulares Software Engineering.
3. **„Code‑Reading vor Code‑Writing"** – inspiriert von Parsons‑Problemen (Denny SIGCSE 2024). LLM‑generierter Code wird zu Lese‑ und Annotationsmaterial.
4. **„Open‑AI‑Assessment statt Plagiatskontrolle"** – Prüfungssituationen werden mit zugänglicher KI gestellt, aber so gebaut, dass sie nur mit echtem Verständnis lösbar sind (Spec‑Lesen, Erklären, Modifizieren, Debuggen, Erklären eines vorgegebenen Snippets in eigenen Worten). Anschlussfähig an SWK 2024: „prozessorientierte Prüfungsformate", in denen die „versierte Koaktivität mit LLM als Lernziel geübt und geprüft" wird.
5. **„Dozent:in als Sparringspartner:in"** – Rolle wandelt sich vom Wissensvermittler zum Coach für Lernstrategien, Verifikationsroutinen, Prompt‑Hygiene, Reflexion.
6. **„Datenschutz‑by‑Default"** – im Behördenkontext ist DSGVO‑Konformität der Standard, nicht die Ausnahme.

#### 4.2 Methoden‑Übersicht

| Methode | Quelle / Hintergrund | Eingesetzt für | Phase |
|---|---|---|---|
| Live‑Coding / Tracing | Klassisch; Shah et al. ICER 2023 | Notional Machine, Verständnis | 1, 2 |
| Parsons‑Puzzles | Denny SIGCSE 2024 Keynote | Code‑Lesen ohne Syntax‑Last | 1, 2 |
| Prompt Problems | Denny et al. 2023 (Promptly) | Prompting als eigene Kompetenz | 2, 3 |
| Pair Programming mit KI | Mozannar et al.; Beck „augmented coding" | Realnähe, Diskursfähigkeit | 2, 3 |
| Reverse Engineering von KI‑Code | Eigene Methode, breit verwendet | Code‑Reading + Halluzinationscheck | 2 |
| Debugging‑Challenges mit injizierten KI‑Fehlern | Eigene didaktische Methode | Verifikationsroutine | 2, 3 |
| KI‑gestütztes Erklären‑lassen („explain in plain English") | MacNeil et al. SIGCSE 2023 | Verständnistiefe | 2 |
| Worked Examples | Atkinson et al. 2000 | Cognitive Load Senkung | 1, 2 |
| Lernjournal / Reflexionsbögen | Konstruktivistisch | Metakognition | alle |
| Open‑AI‑Prüfungsformate | SWK 2024; ähnlich CS1‑LLM Vadaparty/Porter 2024 | Assessment | 3 |

#### 4.3 Heterogenität der Vorkenntnisse

In BFD‑/Agentur‑/BWSA‑Kursen ist Heterogenität die Regel: ehemalige Soldat:innen mit Logistik‑/Technik‑Hintergrund, Quereinsteiger:innen, Wiedereinsteiger:innen. Drei Maßnahmen:

- **Diagnostische Eingangsphase** mit klaren Stufen, ohne Rangbildung.
- **Differenzierte KI‑Nutzungsregeln**: Teilnehmende mit Vorkenntnissen erhalten anspruchsvollere Prompt‑Aufgaben (z. B. Architektur‑Prompts), Anfänger:innen geführte Prompt‑Vorlagen.
- **Peer‑Tutoring** mit klaren Rollenwechseln, um „illusion of competence" (Prather et al. 2024) zu verhindern.

#### 4.4 Assessment‑Philosophie

Die SWK 2024 fordert „prozessorientierte Prüfungsformate", in denen die „versierte Koaktivität mit LLM als Lernziel geübt und geprüft" wird, zugleich aber „hilfsmittelfreie Prüfungsformate beizubehalten" sind. Daraus folgt eine Mischung:

- Hilfsmittelfreie Kurzformate (Tracing, Erklären, kleine Funktionen) zur Sicherung der Ebene A.
- KI‑offene Projektformate zur Prüfung der Ebenen B und C.
- Metakognitive Komponenten: Reflexionsgespräche, Lernjournal‑Auswertungen, Selbsteinschätzungen.

Konkrete Bewertungsraster werden hier bewusst nicht ausgearbeitet – sie sind träger‑ und maßnahmenspezifisch.

---

### 5. Rahmenbedingungen und praktische Aspekte

#### 5.1 Werkzeugauswahl‑Kriterien

| Kriterium | Begründung | Beispiele |
|---|---|---|
| DSGVO‑Konformität / AVV möglich | Behördenkontext (BFD, Jobcenter) | OpenAI Enterprise/Team mit EU‑Residency, Microsoft Copilot Enterprise, Mistral, Aleph Alpha |
| Pädagogische Guardrails | Vermeidung „Spoiler‑Antworten" | CS50‑Duck‑Pattern, CodeHelp (Liffiton et al. Koli Calling 2023), CodeAid (Kazemitabaar et al. CHI 2024), fobizz, schulKI |
| Niedrigschwelliger Zugang | Heterogene Hardware, BYOD nur bedingt sinnvoll | Google Colab, JupyterLite, replit.com (mit Vorsicht), DataCamp DataLab |
| Reproduzierbarkeit | Schulungsalltag & Förderfähigkeit | Standard‑Python‑Distribution, Anaconda, VS Code mit Extensions |
| Offline‑Fähigkeit (optional) | Datenschutzsensible Kontexte | Lokale LLMs (Ollama, Llama 3, GPT4All) |
| Förderfähigkeit (AZAV) | BFD‑/Bildungsgutschein‑relevant | Anbieterliste anhand AZAV‑Zertifizierung prüfen |

#### 5.2 Datenschutz im deutschen Behördenkontext

- Die kostenfreie ChatGPT‑Variante ist nach Tätigkeitsbericht 2023 des LfD Niedersachsen sowie nach Einschätzungen anderer Aufsichtsbehörden für die Verarbeitung personenbezogener Daten **nicht DSGVO‑konform**.
- Tragfähige Optionen für BFD/Arbeitsagentur/BWSA‑Kontexte: Enterprise‑Verträge mit AVV nach Art. 28 DSGVO, deaktiviertem Modelltraining, EU‑Data‑Residency – oder europäische Anbieter (Mistral, Aleph Alpha) – oder didaktische Frontends mit anonymisierten Pseudonym‑Zugängen (fobizz‑Klassenraum, schulKI).
- Der EU AI Act (in Kraft seit 2.2.2025) ergänzt die DSGVO: Bildungsanwendungen können in den Hochrisikobereich fallen.
- **Konzeptionelle Konsequenz:** Der Kurs vermittelt Datenschutz **als Kompetenz**, nicht als formales Disclaimer. Teilnehmende lernen, welche Eingaben in welche KI‑Tools wann zulässig sind – das ist berufsrelevant unabhängig vom Trägerkontext.

#### 5.3 Möglichkeiten und Grenzen

**Was der Kurs leistet:**
- solides Python‑Fundament auf Einsteiger‑/Grundlagenniveau,
- berufsrelevante KI‑Souveränität ab Tag 1,
- Reflexionsfähigkeit über eigene Kompetenzentwicklung,
- Anschlussfähigkeit zu typischen Folgeangeboten (Data Analyst, Data Engineering, Web‑Backend, Test‑Automatisierung).

**Was der Kurs nicht leistet:**
- keine Software‑Engineering‑Tiefe (Architektur, Build‑Systeme, CI/CD),
- keine Vermittlung von ML‑Theorie (das ist ein eigener Anschlusskurs),
- kein Ersatz für längere praktische Berufserfahrung,
- keine Garantie gegen rasche Werkzeug‑Veränderungen (das Konzept muss alle 12–18 Monate aktualisiert werden).

---

### 6. Kritische Reflexion und mögliche Einwände

#### 6.1 Argumente gegen frühe KI‑Integration

- **„Krücke‑Argument":** TN entwickeln keine Selbständigkeit, weil KI immer hilft. Empirisch gestützt durch Prather et al. 2024 und MIT 2025.
- **„Cognitive Offloading":** Lernen wird oberflächlich; Tankelevitch et al. (CHI 2024) zeigen erhöhte metakognitive Anforderungen.
- **„Falsches Selbstbild":** „illusion of competence" (Prather 2024) – TN überschätzen ihre Eigenkompetenz; METR 2025 dokumentiert diesen Effekt auch bei erfahrenen Profis.
- **Skepsis aus der deutschen Fachdidaktik:** Romeike („KI ist kein Werkzeug", computingeducation.de) betont, dass reine Werkzeugnutzung ohne fachliche Konzepte die Substanz unterminiert; Losch et al. (Informatik Spektrum 48(1), 2025) erinnern daran, dass LLMs „kein Weltwissen, keine Intentionalität und kein Bewusstsein" haben und im Kern „stochastische Papageien" sind.

#### 6.2 Argumente für frühe KI‑Integration

- **Realitätsnähe:** Laut der GitHub/Wakefield‑Research‑Studie „AI in Software Development" vom 20.8.2024 (n = 2.000 Enterprise‑Befragte in USA, Brasilien, Deutschland, Indien) gaben über 97 % der Entwickler:innen an, KI‑Coding‑Tools im Arbeitsalltag bereits genutzt zu haben; Karpathy 2026: „programming via LLM agents is increasingly becoming a default workflow for professionals."
- **Motivation:** Erwachsene Lernende in BFD‑/Agentur‑Kontexten benötigen schnelle Erfolgserlebnisse; ohne KI werden Wochen mit Syntax verbracht, ohne dass ein „echtes" Programm entsteht.
- **Beschäftigungsfähigkeit:** Stellenanzeigen verlangen seit 2024 zunehmend explizit KI‑Nutzungskompetenz.
- **Inklusion:** LLMs senken Sprach‑ und Zugangsbarrieren – wichtig für nicht‑muttersprachliche TN (Villegas Molina et al., ASEE 2025).

#### 6.3 Wie das Konzept mit der Spannung umgeht

Das Konzept löst die Spannung **nicht** auf, sondern macht sie produktiv:

- **Sequenzierung:** kurze KI‑freie Phase als Schutz gegen Skill Atrophy, danach KI‑Vollzugang mit didaktischen Guardrails.
- **Doppelte Bewertungslogik:** hilfsmittelfreie Kurzformate sichern Ebene A; KI‑offene Projekte sichern Ebenen B und C.
- **Explizite Reflexion:** TN führen Tagebuch über „Was hätte ich ohne KI gemacht?" – Karpathy‑Spektrum (Vibe Coding ↔ Augmented Coding ↔ Agentic Engineering) wird transparent gemacht.
- **Trägerkommunikation:** Bildungsträger erhalten ein nachvollziehbares Argumentationsgerüst, warum Drill‑Anteile reduziert und durch Reflexionsanteile ersetzt werden.

---

## Recommendations

**Stufe 1 – Sofort (vor dem nächsten Kurs):**
1. Tool‑Stack festlegen mit dokumentierter DSGVO‑Bewertung; mindestens eine Enterprise‑Lizenz (OpenAI Enterprise/Team, Microsoft Copilot Enterprise oder Mistral) und eine niederschwellige Pseudonym‑Lösung (fobizz oder schulKI) parallel.
2. „KI‑Vertrag" für TN entwerfen: was ist erlaubt, was nicht, was wird transparent dokumentiert.
3. Fundierungsphase (Phase 1) auf max. 15 % Kurszeit kalibrieren; Material für Parsons‑Puzzles und Tracing‑Übungen sammeln.

**Stufe 2 – Mittelfristig (nächste 1–2 Kursdurchläufe):**
4. Promptly‑artige Prompt‑Problems (Denny et al. 2023, Promptly: Tool‑Code als OER verfügbar) in Modul M5/M6 aufnehmen.
5. Open‑AI‑Prüfungsformate pilotieren und mit klassischen hilfsmittelfreien Formaten kombinieren.
6. Lernjournal als verbindlichen Teil etablieren; per Beobachtungsbogen kalibrieren.
7. Bildungsträger‑Kommunikation: Konzept in 2‑Seiten‑Argumentationspapier verdichten (für BFD‑Berater:innen, AZAV‑Trägeraudits).

**Stufe 3 – Langfristig (12–24 Monate):**
8. Wirksamkeit empirisch erheben: vergleichende Auswertung von TN‑Outcomes mit/ohne Modulrevision.
9. Konzept jährlich an die rapide Werkzeugentwicklung anpassen (Karpathy hat sein eigenes Schlagwort innerhalb eines Jahres revidiert – Vergleichbares ist erneut wahrscheinlich).
10. Anschluss‑Module entwickeln (Datenanalyse, Web‑Backend, Test‑Automatisierung) mit gleichem didaktischen Rahmen.

**Schwellenwerte / Trigger zur Konzeptanpassung:**
- Wenn die TN‑Quote, die in der Open‑AI‑Prüfung **ohne** Verständnis besteht, > 15 % erreicht: Verifikationsroutinen schärfen.
- Wenn neue Studien (METR‑Folgestudien, Prather‑Replikationen) substanziell andere Effektgrößen zeigen: Modulgewichte überprüfen.
- Wenn der Träger die KI‑Nutzung untersagt: Phase 1 ausbauen, Phasen 2/3 in „simulierter KI‑Mode" mit Beispiel‑Outputs durchführen.

---

## Caveats

1. **Schnelle Werkzeugentwicklung:** Karpathys Begriffswandel von „Vibe Coding" (2.2.2025) zu „Agentic Engineering" (4.2.2026) zeigt, wie volatil das Vokabular ist. Konkrete Tool‑Empfehlungen veralten schnell; das didaktische Gerüst (Drei‑Phasen, Sechs‑Prinzipien, Lernzielmatrix) ist robuster.
2. **Empirische Evidenzlage uneindeutig:** Effektgrößen variieren erheblich (METR 2025: −19 %; Peng et al. 2023: +55,8 %; Cui et al. 2023: +26,08 % PRs). Verallgemeinerungen sind unsicher; das Konzept folgt dem methodischen Mainstream, ist aber nicht „bewiesen" optimal.
3. **MIT‑Studie ist Schreib‑, nicht Programmierstudie:** Übertragbarkeit auf Programmierdidaktik ist plausibel, aber nicht direkt belegt.
4. **„Vibe Coding" ist mehrdeutig:** Karpathys Originaldefinition (Code nicht verstehen) und der heutige Sprachgebrauch („irgendwie KI‑gestütztes Coden") laufen auseinander; im Kurs muss explizit geklärt werden, was gemeint ist.
5. **Datenschutzlage ist im Fluss:** Der EU AI Act gilt schrittweise bis 2027; Aufsichtsbehörden‑Bewertungen können sich ändern.
6. **Heterogenität der Träger:** BFD, Arbeitsagentur und BWSA haben unterschiedliche Förderlogiken; Stundendichte, Prüfungsformate und KI‑Zugang variieren. Das Konzept ist Rahmen, nicht operativer Lehrplan.
7. **Skill Atrophy ist nicht deterministisch:** Mit gutem Scaffolding (Prather/Hou/Denny) lässt sich der Effekt abmildern; das Konzept setzt darauf, garantieren kann es das nicht.
8. **GI‑Positionspapier korrekt datiert:** Das Papier „Künstliche Intelligenz in der Bildung – Keine Verbote" ist vom 17.07.2023 (nicht 2024); 2024 erschien lediglich eine ergänzende GI‑Stellungnahme zur KMK.