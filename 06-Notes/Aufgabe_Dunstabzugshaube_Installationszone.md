# Aufgabe: Dunstabzugshaube über dem Induktionskochfeld

*BFD-Schulung Elektroinstallation · Praktische Übung zu DIN 18015-3*

---

## Ausgangssituation

Die im vorhergehenden Schulungsblatt geplante Küche (siehe Schemazeichnung *„Installationszonen Küche nach DIN 18015-3"*) wird um eine **wandmontierte Dunstabzugshaube** erweitert. Die Eckdaten:

| Element | Maß |
|---|---|
| Raumhöhe (Fertigdecke) | 2 500 mm |
| Induktionskochfeld, Breite | 600 mm |
| Kochfeldmitte (horizontal, ab linker Wandanschlag) | 900 mm |
| Oberkante Arbeitsplatte / Kochfeld | 900 mm |
| Schachtverkleidung (Edelstahl-Kamin oberhalb der Haube), Breite | 200 mm |
| Unterkante Schachtverkleidung | 1 900 mm |

Die Dunsthaube sitzt **mittig über dem Kochfeld**. Die Schachtverkleidung verläuft von 1 900 mm bis zur Decke, ebenfalls mittig über dem Kochfeld.

Die Versorgung erfolgt über eine **eigene Schuko-Steckdose**. Diese soll vollständig hinter der Schachtverkleidung verschwinden – sichtbar bleibt nur die Verkleidung, kein Kabel.

---

## Aufgabenstellung

### Teilaufgabe a) – Steckdosenposition (5 Punkte)

1. Bestimmen Sie die **vertikale Einbauhöhe** der Steckdose (Mitte) in mm über Fertigfußboden.
2. Bestimmen Sie die **horizontale Position** der Steckdose in mm bezogen auf den linken Wandanschlag.
3. Begründen Sie Ihre Wahl mit der **Installationszone nach DIN 18015-3**.
4. *Falle:* Wäre eine Position bei 1 950 mm zulässig? Begründen Sie.

### Teilaufgabe b) – Stromkreis und Schutzmaßnahme (4 Punkte)

1. Welche Spannung, Leitungsquerschnitt und Absicherung wählen Sie?
2. Wird ein **eigener Endstromkreis** benötigt, oder kann an einen vorhandenen Stromkreis angeschlossen werden?
3. Welche **Schutzmaßnahme** ist zwingend vorzusehen?

### Teilaufgabe c) – Sicherheitsabstand (3 Punkte)

1. Welcher **Mindestabstand** zwischen Induktionskochfeld und Unterkante Haube ist einzuhalten?
2. Auf welche Norm bzw. Quelle stützt sich diese Angabe?
3. Prüfen Sie rechnerisch: Reicht die Geometrie (1 900 mm Unterkante Schachtverkleidung – 900 mm Kochfeld = 1 000 mm), wenn die Haube selbst 350 mm hoch ist?

### Teilaufgabe d) – Erreichbarkeit (3 Punkte)

1. Die Steckdose verschwindet hinter der Schachtverkleidung. Wie wird die Anforderung der **Erreichbarkeit** nach DIN 18015 erfüllt?
2. Was wäre alternativ zulässig, wenn die Verkleidung gemauert (nicht demontierbar) ausgeführt würde?

---

## Lösungshinweise

### Zu a) Steckdosenposition

**1. Vertikale Höhe**

Die Steckdose ist in der oberen waagerechten Installationszone **ZH-o** zu platzieren.

> **DIN 18015-3:2016-09, Tabelle 1 und Bild 1:**
> Die obere waagerechte Installationszone (ZH-o) liegt zwischen **15 cm und 45 cm unterhalb der Fertigdecke**.

Bei einer Raumhöhe von 2 500 mm ergibt sich:

- ZH-o-Untergrenze: 2 500 − 450 = **2 050 mm**
- ZH-o-Obergrenze: 2 500 − 150 = **2 350 mm**

**Empfohlene Einbauhöhe (Mitte Steckdose): ca. 2 200 mm**

Damit liegt die Dose:

- ✓ deutlich über 1 900 mm (vollständig hinter der Verkleidung verborgen)
- ✓ innerhalb der zulässigen Installationszone ZH-o
- ✓ mit ausreichend Abstand zur Decke für Montage und Wartung

**2. Horizontale Position**

Die Steckdose muss innerhalb des 200 mm breiten Schachtbereichs liegen, der mittig über dem Kochfeld (Mitte bei 900 mm) verläuft:

- Schachtverkleidung horizontal: x = **800 mm bis 1 000 mm**
- **Empfohlene Steckdosenmitte: x = 900 mm** (zentriert auf das Kochfeld)

Bei der Zuleitung ist die Verlegung auf den waagerechten und senkrechten Installationszonen einzuhalten: Die Steckdose liegt in ZH-o; die Zuleitung verläuft waagerecht in ZH-o aus der nächsten ZS-Zone (Raumecke), nicht diagonal durch die Wand.

**3. Falle: 1 950 mm wäre NICHT zulässig**

Eine Höhe von 1 950 mm wäre zwar **geometrisch hinter der Verkleidung verborgen**, aber **außerhalb von ZH-o** (diese beginnt erst bei 2 050 mm). Eine Steckdose dort verstößt gegen DIN 18015-3 – die Norm kennt zwischen ZH-m (100–120 cm) und ZH-o keine weitere zulässige waagerechte Zone.

> **Merksatz für die Schulung:**
> *„Versteckt ist nicht gleich normgerecht."* Eine verdeckte Lage befreit nicht von der Einhaltung der Installationszonen nach DIN 18015-3. Wer später bohrt, sucht in den genormten Zonen – nicht in versteckten Sonderpositionen.

### Zu b) Stromkreis und Schutzmaßnahme

**1. Spannung, Leitung, Absicherung**

- Spannung: **230 V AC, einphasig**
- Steckdose: **Schuko nach DIN 49440**, Unterputz, IP 20 ausreichend (trockener Bereich oberhalb Spritzwasserzone)
- Leitung: **NYM-J 3 × 1,5 mm²**
- Absicherung: **Leitungsschutzschalter B16 A** (Charakteristik B, ausgelegt für Hausinstallation mit überwiegend ohmschen/induktiven Lasten)

**2. Stromkreis-Zuordnung**

Eine wandmontierte Dunstabzugshaube hat eine typische Anschlussleistung von **250–350 W** (Motor 150–250 W + LED-Beleuchtung 20–50 W), max. ca. 600 W bei stärkeren Modellen. Ein eigener Endstromkreis ist daher **nicht zwingend** vorgeschrieben.

> **DIN 18015-2:2010-11 („Mindestausstattung von Wohnungen mit elektrischen Anlagen"):**
> Definiert Mindestzahl und -anordnung der Stromkreise. Eine Dunsthaube kann an einen vorhandenen Steckdosen- oder Beleuchtungsstromkreis angeschlossen werden, sofern die Summenbelastung beachtet wird.

**Praxisempfehlung:** Anschluss an den **Stromkreis der Küchenbeleuchtung**, *nicht* an die Arbeitsflächen-Steckdosen. Begründung: Bei Auslösen des stark belasteten Arbeitsflächen-Kreises (Wasserkocher, Toaster, Kaffeemaschine) bleibt die Hauben-Beleuchtung über der Kochstelle als zweite Lichtquelle erhalten – relevant aus Sicherheitssicht beim Kochvorgang.

**3. Schutzmaßnahme**

> **DIN VDE 0100-410:2018-10, Abschnitt 411.3.3:**
> In Räumen für Hauswirtschaft und Wohnzwecke sind alle Endstromkreise für Steckdosen mit einem Bemessungsstrom bis 32 A mit einer Fehlerstrom-Schutzeinrichtung (RCD) mit IΔn ≤ 30 mA zu schützen.

→ **Zusätzlicher RCD-Schutz 30 mA ist zwingend.** Da die Haube über eine Steckdose angeschlossen wird, fällt der Stromkreis unter diese Pflicht. Ein vorhandener FI/RCD-Schalter der Küchenstromkreise muss diese Steckdose mit absichern.

### Zu c) Sicherheitsabstand Kochfeld – Haube

**1. Mindestabstand (Herstellerangabe maßgeblich)**

> **DIN EN 60335-2-31 („Besondere Anforderungen für Dunstabzugshauben und andere Kochdunstabzüge"):**
> Der Hersteller hat in der Montageanleitung den Mindestabstand zwischen Oberkante Kochstelle und Unterkante Dunstabzugshaube anzugeben. Diese Angabe ist verbindlich.

**Gängige Mindestabstände in der Praxis:**

| Kochstelle | Mindestabstand zur Haube |
|---|---|
| Induktion / Glaskeramik (Strahlung) | **650 mm** |
| Elektro-Kochplatten (Gusseisen) | 700 mm |
| Gas (DVGW-Arbeitsblatt G 5640) | **750 mm** |

**2. Norm-Bezug**

- **DIN EN 60335-2-31** (Produktsicherheit der Haube; Pflicht zur Herstellerangabe)
- **Montageanleitung des Herstellers** (rechtsverbindlich für die Installation)
- Bei Gas: **DVGW G 5640** (Dunstabzugshauben über Gaskochstellen)
- Bei gleichzeitigem Betrieb mit raumluftabhängigen Feuerstätten zusätzlich **TRGI 2018** und Feuerverordnungen der Länder beachten (Stichwort: Druckwächter, Fensterkontaktschalter)

**3. Geometrieprüfung**

| Maß | Wert |
|---|---|
| Oberkante Kochfeld | 900 mm |
| Mindestabstand (Induktion) | 650 mm |
| → Unterkante Haube min. | 1 550 mm |
| Haubenhöhe (Annahme) | 350 mm |
| → Oberkante Haube | 1 900 mm |
| Unterkante Schachtverkleidung | 1 900 mm |

→ **Geometrie passt bündig.** Bei Einhaltung von 650 mm Abstand und 350 mm hoher Haube schließt die Schachtverkleidung exakt an der Haubenoberkante an.

*Hinweis:* Bei einer höheren Haube (z. B. 400 mm) muss entweder der Abstand zur Kochfläche vergrößert oder die Schachtverkleidung tiefer angesetzt werden. Maße im Herstellerprospekt **vor Beginn der Stemmarbeiten** prüfen!

### Zu d) Erreichbarkeit

**1. Demontierbare Schachtverkleidung**

> **DIN 18015-1:2020-05, Abschnitt 6 („Anordnung der Betriebsmittel"):**
> Steckdosen und Anschlussstellen sind so anzuordnen, dass sie ohne Hilfsmittel oder mit zumutbarem Aufwand erreichbar sind.

Edelstahl- oder Aluminium-Schachtverkleidungen für Dunsthauben sind in der Regel **zweiteilig teleskopierbar** ausgeführt und werden mit max. 2–4 Schrauben am Wandhalter befestigt. Damit gilt die Erreichbarkeit als gegeben – ein Servicetechniker kann die Verkleidung ohne Spezialwerkzeug abnehmen.

**2. Alternative: gemauerter Schacht**

Bei massiver Ausführung (gemauert, verputzt) wäre eine **Revisionsöffnung** mit verschraubter Klappe oberhalb des Steckdosenstandorts vorzusehen.

Alternativ ist ein **Festanschluss über Geräteanschlussdose** zulässig:

> **DIN 18015-1, Anmerkung zu 6.4:**
> Fest angeschlossene Verbrauchsmittel unterliegen nicht der Erreichbarkeitspflicht der Steckdosenanordnung.

In diesem Fall wäre die Haube nicht über eine Steckdose, sondern über eine Geräteanschlussdose (GAD) anzuschließen.

- **Vorteil:** Erreichbarkeit nicht erforderlich, Verkleidung kann fest verputzt werden.
- **Nachteil:** Austausch der Haube erfordert einen Elektriker (kein einfaches „Stecker ziehen").

---

## Bewertungsschema

| Teilaufgabe | Punkte | Lernziel |
|---|:---:|---|
| a) Steckdosenposition | 5 | Anwendung DIN 18015-3, Verständnis „Zone vs. Geometrie" |
| b) Stromkreis | 4 | Anwendung DIN 18015-2, DIN VDE 0100-410, RCD-Pflicht |
| c) Mindestabstand | 3 | Geräte­sicherheits-Norm + Praxisrechnung |
| d) Erreichbarkeit | 3 | DIN 18015-1, Alternativen erkennen |
| **Gesamt** | **15** | |

---

## Lernziele

Nach Bearbeitung dieser Aufgabe können die Teilnehmenden:

- ✓ die Installationszonen ZH-o, ZH-m, ZH-u und ZS nach **DIN 18015-3** identifizieren und auf konkrete Geometrien anwenden,
- ✓ den **Unterschied zwischen „geometrisch verdeckt" und „normgerecht installiert"** erkennen und begründen,
- ✓ Mindestabstände nach **DIN EN 60335-2-31** und Herstellerangaben rechnerisch überprüfen,
- ✓ die RCD-Pflicht aus **DIN VDE 0100-410** auf Wohnungs-Stromkreise korrekt anwenden,
- ✓ Erreichbarkeitsanforderungen nach **DIN 18015-1** bewerten und sinnvolle Alternativen (Festanschluss, Revisionsöffnung) aufzeigen.

---

## Verwendete Normen und Vorschriften

| Norm / Vorschrift | Inhalt |
|---|---|
| **DIN 18015-1:2020-05** | Elektrische Anlagen in Wohngebäuden – Planungsgrundlagen |
| **DIN 18015-2:2010-11** | Mindestausstattung mit elektrischen Anlagen |
| **DIN 18015-3:2016-09** | Leitungsführung und Anordnung der Betriebsmittel |
| **DIN VDE 0100-410:2018-10** | Schutzmaßnahmen – Schutz gegen elektrischen Schlag |
| **DIN VDE 0100-559** | Auswahl und Errichtung – Leuchten und Beleuchtungsanlagen |
| **DIN EN 60335-2-31** | Sicherheit elektrischer Geräte – Dunstabzugshauben |
| **DIN 49440** | Steckvorrichtungen mit Schutzkontakt (Schuko) |
| **DVGW G 5640** | Dunstabzugshauben über Gaskochstellen |
| **TRGI 2018** | Technische Regeln für Gasinstallationen (bei Gasfeuerstätten) |

---

*Erstellt für BFD-Schulungsmaterial · Praktische Übung zu DIN 18015-3 · Raumhöhe 2 500 mm · Ausgangsgeometrie siehe Schulungsblatt „Installationszonen in der Küche"*
