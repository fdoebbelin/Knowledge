## Übersicht der Aufgabensammlung

Dieses Dokument enthält praxisorientierte Aufgaben und Übungen zur Projektstrukturplanung (WBS). Die Aufgaben sind in **drei Schwierigkeitsstufen** strukturiert (Basis, Fortgeschrittene, Experte) und adressieren die Lerninhalte schrittweise.

---
## Aufgabenblock 1: Grundverständnis & Theorie

### Aufgabe 1.1: Verständnis der 100%-Regel

**Basis-Level**

Gegeben ist folgende (fehlerhafte) WBS für ein IT-Projekt:

```
Projekt: Customer-Portal-Entwicklung
├── Frontend-Entwicklung
├── Backend-Entwicklung
├── Datenbank-Design
├── Testphase
└── Deployment
```

**Frage:**  
a) Ist diese WBS vollständig im Sinne der 100%-Regel? Begründet kurz.

b) Welche Elemente fehlen typischerweise? Notiert mindestens 3 fehlende Komponenten/Phasen.

c) Rekonstruiert die WBS, sodass sie die 100%-Regel erfüllt.

---

**Checkliste zur Überprüfung:**
- [ ] Sind alle Phasen vom Kick-off bis zum Abschluss berücksichtigt?
- [ ] Gehören Projektmanagement, QS und Dokumentation dazu?
- [ ] Sind Schulung, Übergabe oder Support berücksichtigt?
- [ ] Gibt es Überlappungen oder Lücken?

---

### Aufgabe 1.2: Zerlegungslogiken erkennen und vergleichen

**Fortgeschrittenes Level**

Ihr Team wird ein **Umzugsprojekt für ein Bürogebäude** durchführen. Es gibt drei Varianten, die WBS zu strukturieren:

**Variante A – Phasenorientiert:**
```
Umzugsprojekt
├── Phase 1: Planung & Vorbereitung
├── Phase 2: Umzugslogistik
├── Phase 3: Inbetriebnahme
└── Phase 4: Abschluss
```

**Variante B – Komponentenorientiert:**
```
Umzugsprojekt
├── IT-Infrastruktur
├── Möbel & Einrichtung
├── Reinigung & Instandhaltung
├── Kommunikation & Training
└── Facility Management
```

**Variante C – Prozessorientiert:**
```
Umzugsprojekt
├── Prozess: Planung
├── Prozess: Logistik & Transport
├── Prozess: Aufbau neuer Standort
└── Prozess: Betrieb & Support
```

**Fragen:**
a) Ordnet für **jede Variante** beispielhaft die folgenden Arbeitspakete zu:
   - IT-Netzwerk installieren
   - Schreibtische montieren
   - Mitarbeiter schulen
   - Umzugsfahrzeuge buchen
   - Alte Räume aufräumen

b) Welche Variante würdet ihr für dieses Projekt wählen und warum?

c) Nennt die **Vorteile und Nachteile** der gewählten Variante konkret für diesen Umzug.

---

### Aufgabe 1.3: RACI-Matrix erstellen

**Basis-Level**

Gegeben ist eine WBS für ein **Marketingkampagnen-Projekt**:

```
Marketingkampagne: „Frühjahrskollektion 2025"
├── Strategie & Konzept
├── Content-Erstellung
├── Design & Visuals
├── Media-Planung & Buchung
└── Kampagnen-Launch & Monitoring
```

Die beteiligten Rollen sind:
- **PM** = Projektmanager
- **MarkL** = Marketing-Leiter (Verantwortlicher)
- **Designer** = Grafikdesigner
- **Social** = Social-Media-Manager
- **KundR** = Kundenrepräsentant (Auftraggeber)

**Aufgabe:**  
Erstellt eine RACI-Matrix für die genannten Arbeitspakete und Rollen. Beachtet:
- Jedes Paket sollte **genau eine A haben**
- R kann mehrfach vorkommen
- C und I sollten gezielt eingesetzt werden

**Tabelle zum Ausfüllen:**

| Arbeitspakete | PM | MarkL | Designer | Social | KundR |
|---|---|---|---|---|---|
| Strategie & Konzept | | | | | |
| Content-Erstellung | | | | | |
| Design & Visuals | | | | | |
| Media-Planung & Buchung | | | | | |
| Kampagnen-Launch & Monitoring | | | | | |

---

## Aufgabenblock 2: Praktische WBS-Erstellung

### Aufgabe 2.1: WBS für ein IT-Projekt (YouTrack-Kontext)

**Fortgeschrittenes Level**

**Szenario:**  
Euer Unternehmen möchte eine **interne Webanwendung zur Urlaubsverwaltung** entwickeln. Die wichtigsten Anforderungen sind:
- Mitarbeiter können Urlaub beantragen
- Manager können Anträge genehmigen/ablehnen
- HR kann Urlaubsbestände verwalten
- System soll mit der bestehenden Personaldatenbank integriert werden
- Go-Live ist in 4 Monaten geplant

**Aufgabe:**
1. Strukturiert ein Projekt mit einer **4–5-stufigen WBS**. Wählt selbst, ob ihr **phasen-, komponenten- oder hybridorientiert** vorgehen möchtet.

2. Definiert die **Arbeitspakete** (unterste Ebene) so, dass sie in 2–3 Wochen abarbeitbar sind.

3. Ordnet jedem Arbeitspakete eine **Rollenkombination** zu (z.B. Developer + QA-Tester).

4. Markiert, welche Pakete ihr in **YouTrack als Epics** und welche als **Stories/Issues** modelliert würdet.

**Vorlage zur Dokumentation:**

```
Projekt: Urlaubsverwaltungs-Webanwendung

├── Ebene 1: [Hauptkategorie]
    ├── Ebene 2: [Subkomponente]
    │   └── Arbeitspakete (Ebene 3): 
    │       - [Name, Beschreibung, verantwortliche Rolle(n)]
    │       - [Name, Beschreibung, verantwortliche Rolle(n)]
    ...
```

---

### Aufgabe 2.2: WBS für ein Bauprojekt

**Experte-Level**

**Szenario:**  
Euer Unternehmen renoviert die **Zentrale eines Pharma-Konzerns (10.000 m²)**. Das Projekt umfasst:
- Gesamtdauer: 18 Monate
- Budget: 25 Mio. Euro
- Bestandteile: Rohbau, Elektrik, Heizung/Kühlung, Innenausbau, IT-Infrastruktur
- Viele externe Subunternehmer und Zulieferer
- Hohe Qualitätsanforderungen und Compliance-Vorgaben

**Aufgabe:**
1. Erarbeitet eine **komponentenorientierte WBS** mit **4 Hierarchieebenen**:
   - Ebene 1: Projekt
   - Ebene 2: Gewerke (Rohbau, Elektrik, etc.)
   - Ebene 3: Untergewerke / Bereiche
   - Ebene 4: Arbeitspakete

2. Konkretisiert mindestens **2 Gewerke** mit jeweils 3–4 Arbeitspaketen.

3. Erstellt für **ein ausgewähltes Paket** eine kleine RACI-Matrix mit den Rollen:
   - Projektleiter (PL)
   - Bauleitung (BL)
   - Gewerk-Unternehmer (UN)
   - Architekt (Arch)
   - Bauherr / Auftraggeber (AG)

4. Diskutiert: Welche **Fehlerquellen** würden bei einer solch großen Baumaßnahme entstehen, wenn die WBS unzureichend ist?

---

### Aufgabe 2.3: WBS für ein Organisationsprojekt (Prozessoptimierung)

**Basis bis Fortgeschrittenes Level**

**Szenario:**  
Ein **Logistikunternehmen** möchte seine **Bestellprozesse digitalisieren und optimieren**. Aktuell sind diese manuell, papierbasiert und fehleranfällig.

**Aufgabe:**
1. Erstellt eine **prozessorientierte WBS**, die folgende Bereiche adressiert:
   - Analyse des Ist-Zustands
   - Design des Soll-Prozesses
   - IT-Systemauswahl und -konfiguration
   - Schulung und Change Management
   - Go-Live und Supportphase

2. Definiert unter jedem Hauptprozess **3–4 Arbeitspakete**.

3. Markiert mit `[KAT]` (Kritisch), welche Pakete ihr als **kritisch für den Erfolg** einschätzt, und begründet dies kurz.

**Beispiel:**
```
Projektname: Bestellprozess-Digitalisierung

├── Prozess 1: Analyse & Diagnostik [KAT]
│   ├── Ist-Prozess-Mapping
│   ├── Schmerzpunkte-Identifikation
│   ├── Interviews mit Key-Usern
│   └── Bericht & Empfehlungen [KAT]
│
├── Prozess 2: Design & Konzeption
    ...
```

---

## Aufgabenblock 3: Fehleranalyse und Best Practices

### Aufgabe 3.1: Fehlerhafte WBS analysieren und korrigieren

**Basis-Level**

Gegeben ist folgende WBS für ein **Softwareentwicklungs-Projekt**:

```
Projekt: E-Learning-Plattform
├── Entwickler-Team arbeitet an Features
├── Tester überprüft Qualität
├── Infrastruktur wird aufgebaut
├── Dokumentation findet statt
├── Schulung der Nutzer
└── Nach Go-Live: Support
```

**Probleme erkennen:**

a) Welche WBS-Prinzipien sind **verletzt**? Nennt mindestens 3 Mängel.

b) Sind die Ebenen logisch strukturiert? Begründet.

c) **Rekonstruiert die WBS** korrekt. Nutzt entweder eine **phasen- oder komponentenorientierte** Struktur mit mindestens 4 Ebenen.

**Verbesserungschecklist:**
- [ ] Sind Phasen klar getrennt?
- [ ] Ist jedes Paket eindeutig zuweisbar?
- [ ] Gibt es zeitliche oder fachliche Lücken?
- [ ] Ist die Nomenklatur konsistent?
- [ ] Folgt die Struktur einem klaren Muster?

---

### Aufgabe 3.2: WBS und Scope-Creep

**Fortgeschrittenes Level**

**Szenario:**  
Während des Projekts **„Webshop-Relaunch"** treten die folgenden Change Requests auf:
1. Der Kunde möchte ein **zusätzliches Zahlungsmodul** (Apple Pay, Google Pay)
2. Ein neues **Empfehlungssystem** (Algorithmus) soll hinzugefügt werden
3. Die **Datensicherheit** muss erhöht werden (neue Encryption)
4. Eine **Produktbewertungs-Funktion** wurde vergessen

**Aufgabe:**
1. Gegeben ist diese ursprüngliche WBS:

```
Webshop-Relaunch
├── Anforderungsanalyse
├── Frontend-Entwicklung
├── Backend-Entwicklung
├── Payment-Integration
├── Testing & QA
├── Deployment
└── Post-Launch-Support
```

2. Für **jeden Change Request**:
   - Ordnet ihn einer bestehenden WBS-Position zu ODER
   - Fügt ihn als **neue Komponente ein** (mit Begründung)
   - Schätzt den Aufwand: **Gering (1–2 Tage), Mittel (1–2 Wochen), Hoch (> 2 Wochen)**

3. Diskutiert: Wie könnte die **ursprüngliche WBS besser strukturiert** werden, um solche Anforderungsschübe früher zu erkennen?

---

### Aufgabe 3.3: WBS-Review und Lessons Learned

**Experte-Level**

**Szenario:**  
Ein abgeschlossenes Projekt **„Messeneugestaltung"** zeigte folgende Probleme:
- Viele ungeplante Zusatzaufgaben (20 % Überlauf)
- Klare Verantwortlichkeiten fehlten → Missverständnisse
- Externe Lieferanten waren nicht adäquat koordiniert
- Design-Änderungen führten zu Ripple-Effekten in anderen Paketen

**Aufgabe:**
1. Entwickelt eine **verbesserte WBS-Struktur** für ein ähnliches zukünftiges Messeprojekt.

2. Integriert folgende **Lessons Learned** explizit in die Struktur:
   - Klare Verantwortlichkeitsebenen durch RAM/RACI
   - Puffer für Design-Änderungen
   - Explizite Lieferanten-Koordinationspakete
   - Prozesse für Scope-Change-Anfragen

3. Präsentiert eure verbesserte WBS mit Begründung der Veränderungen.

---

## Aufgabenblock 4: Praktische Anwendung & Tool-Integration

### Aufgabe 4.1: WBS in YouTrack abbilden

**Fortgeschrittenes Level**

**Aufgabe:**
Ihr habt die folgende WBS für ein **App-Entwicklungs-Projekt**:

```
App-Relaunch: Mobile News Reader
├── Frontend
│   ├── UI-Design
│   ├── News-Feed-Anzeige
│   └── Benutzer-Profil-Management
├── Backend
│   ├── News-API-Integration
│   ├── Authentifizierung
│   └── Datenbank-Setup
├── Testing & QA
│   ├── Funktionstests
│   └── Lasttests
└── Deployment & Support
```

**Aufgabe in YouTrack:**
1. Modelliert diese WBS als **Projekt mit Komponenten und Epics/Stories**:
   - Welche Elemente werden zu **Komponenten**?
   - Welche zu **Epics** und welche zu **Stories/Issues**?

2. Definiert für jede Story 2–3 **Subtasks** (konkrete Arbeitschritte).

3. Vergebt **Zuständigkeiten** (Assignees) und **geschätzte Aufwände**.

4. Erklärt, wie diese Struktur den **Projektverlauf** in YouTrack unterstützt (Dashboards, Reports, Tracking).

---

### Aufgabe 4.2: WBS mit Zeitplanung verknüpfen

**Experte-Level**

**Szenario:**  
Gegeben ist eine WBS für ein **Produktentwicklungs-Projekt** (6-Monats-Projekt). Folgende Abhängigkeiten existieren:

```
Produktentwicklung
├── Phase 1: Konzept & Design (Woche 1–4)
│   ├── Marktanalyse (Woche 1–2)
│   ├── Designkonzept (Woche 2–4) [abhängig von Marktanalyse]
│   └── Prototyp-Erstellung (Woche 3–4)
│
├── Phase 2: Entwicklung (Woche 5–18)
│   ├── Firmware-Entwicklung (Woche 5–14)
│   ├── Hardware-Integration (Woche 12–17) [startet nach Designkonzept]
│   └── Schnittstellen-Optimierung (Woche 15–18) [abhängig von beiden]
│
├── Phase 3: Testing (Woche 15–20)
│   ├── Funktionstests (Woche 15–18) [parallel zu Entwicklung]
│   └── Feldtests (Woche 19–20)
│
└── Phase 4: Markteinführung (Woche 21–26)
    ├── Produktion ramp-up (Woche 21–23)
    ├── Marketing & Launch (Woche 24–26)
    └── Support ramp-up (Woche 25–26)
```

**Aufgabe:**
1. Zeichnet einen **Gantt-ähnlichen Überblick** oder eine **Netzplan-Skizze** mit den Abhängigkeiten.

2. Identifiziert den **kritischen Pfad** (längste Kette von abhängigen Aktivitäten).

3. Benennt **Risikopakete**, wo Verzögerungen das Gesamtprojekt beeinflussen.

4. Definiert **Meilensteine** für jede Phase und Übergänge.

5. Diskutiert: Wie könnten Phasen **parallelisiert** oder **gepuffert** werden?

---

## Persönliche Notizen & Reflexion

### Notizbereich: Meine wichtigsten Erkenntnisse

```
Was habe ich über WBS gelernt?
_________________________________
_________________________________

Wo nutze ich WBS in meinen Projekten?
_________________________________
_________________________________

Welche Fehler werde ich künftig vermeiden?
_________________________________
_________________________________

Frage an den Trainer/Trainer?
_________________________________
_________________________________
```

---

## Zusammenfassung: Checklist für WBS-Erstellung

### Vor der WBS-Erstellung
- [ ] Projektumfang und Ziele geklärt
- [ ] Stakeholder identifiziert
- [ ] Rough Timeline definiert
- [ ] Welche Zerlegungslogik passt? (Phase / Komponente / Prozess)

### Während der WBS-Erstellung
- [ ] Arbeitspakete sind konkret und messbar
- [ ] 100%-Regel: Keine Lücken, keine Überlappungen
- [ ] Detaillierungsgrad richtig: 2–3 Wochen pro Paket (Daumenregel)
- [ ] Alle „unsichtbaren" Arbeiten erfasst (PM, QA, Dokumentation, Schulung, Support)
- [ ] Stakeholder-Review durchgeführt

### Nach der WBS-Erstellung
- [ ] Verantwortlichkeitsmatrix (RACI/RAM) erstellt
- [ ] WBS in Projekt-Tool (YouTrack, MS Project, Asana) abgebildet
- [ ] Abhängigkeiten und Zeitlogik definiert
- [ ] Ressourcen allokiert
- [ ] Change-Prozess für WBS-Adjustments etabliert

---

## Lösungshinweise

Die detailliert kommentierten Lösungen finden sich im separaten Dokument **05c_Projektstrukturplanung_Lösungen.md**.

---

## Zusätzliche Ressourcen zur Vertiefung

- **PMBOK Guide (Project Management Institute):** Kapitel Scope Management
- **PRINCE2 Method:** Product-Breakdown-Structure (PBS)
- **ISO/IEC/IEEE 42010:** Architecture Description of Software-Intensive Systems
- **Video-Tutorial:** „WBS erstellen – Schritt für Schritt" (verfügbar auf LMS)
- **Tool-Dokumentation:**
  - YouTrack: https://www.jetbrains.com/help/youtrack/
  - MS Project: https://support.microsoft.com/en-us/project
  - Asana: https://asana.com/guide