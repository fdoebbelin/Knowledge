> [!info] Über dieses Dokument
> Referenzdokument für die Kursplanung. Enthält alle Module mit Lernzielen, Zeitaufwand und Abhängigkeiten. Als Projektdokument hinterlegen, damit alle Lernmodule konsistent aufgebaut werden.

## Kursziel

Teilnehmer mit IT-Hintergrund erlernen die Grundlagen parametrischen CAD-Designs und können eigenständig technische 3D-Modelle in FreeCAD erstellen und ableiten.

**FreeCAD-Version:** 1.0  
**Gesamtdauer:** ca. 12–14 Stunden (Intensivformat)  
**Sprache:** Deutsch (UI-Begriffe gemäß deutscher Lokalisierung)

---

## Modulübersicht

| #   | Modul                            | Workbench     | Dauer   | Abhängigkeit |
| --- | -------------------------------- | ------------- | ------- | ------------ |
| M01 | [[M01 – FreeCAD Grundlagen]]     | –             | 45 min  | –            |
| M02 | [[M02 – Sketcher Grundlagen]]    | *Sketcher*    | 90 min  | M01          |
| M03 | [[M03 – Sketcher Constraints]]   | *Sketcher*    | 90 min  | M02          |
| M04 | [[M04 – Part Design Grundlagen]] | *Part Design* | 90 min  | M03          |
| M05 | [[M05 – Part Design Vertiefung]] | *Part Design* | 90 min  | M04          |
| M06 | [[M06 – Baugruppen & Assembly]]  | *Assembly*    | 60 min  | M05          |
| M07 | [[M07 – Technische Zeichnung]]   | *TechDraw*    | 90 min  | M04          |
| M08 | [[M08 – Abschlussprojekt]]       | alle          | 120 min | M01–M07      |

---

## Detaillierte Modulbeschreibungen

### M01 – FreeCAD Grundlagen

**Lernziel:** Benutzeroberfläche sicher bedienen, Navigation beherrschen, erstes Dokument anlegen.

**Inhalte:**
- FreeCAD-Oberfläche: Menüleiste, Symbolleisten, Modellbaum (Model Tree), 3D-Ansicht, Aufgabenbereich
- Workbench-Konzept: Arbeitsumgebungen und deren Zweck
- 3D-Navigation: Maussteuerung, Ansichten, Numpad-Shortcuts
- Dokument anlegen, speichern, öffnen
- Einheiten und Voreinstellungen

**Tastenkürzel (Auswahl):**
- `V`, `F` – Ansicht auf Auswahl
- `Num 0`–`Num 6` – Standardansichten
- `Strg+S` – Speichern
- `Strg+Z` / `Strg+Y` – Rückgängig / Wiederholen

---

### M02 – Sketcher Grundlagen

**Lernziel:** 2D-Skizzen mit geometrischen Grundelementen erstellen.

**Workbench:** *Sketcher*

**Inhalte:**
- Skizze erstellen und Bezugsebene wählen (`Skizze → Skizze erstellen`)
- Zeichenwerkzeuge: Linie, Rechteck, Kreis, Bogen, Polygon
- Skizze schließen und Ergebnis im Modellbaum
- Skizze nachträglich bearbeiten
- Farb-Feedback: weiß (vollständig bestimmt), gelb (unterbeschränkt), rot (überbeschränkt)

**Neue Begriffe:**
- **Skizze:** 2D-Zeichnung, die als Basis für 3D-Operationen dient
- **Bezugsebene:** Flächige Referenz, auf der die Skizze liegt (XY, XZ, YZ)

---

### M03 – Sketcher Constraints

**Lernziel:** Skizzen durch geometrische und maßliche Randbedingungen vollständig bestimmen.

**Workbench:** *Sketcher*

**Inhalte:**
- Geometrische Constraints: Koinzidenz, Horizontal, Vertikal, Parallel, Rechtwinklig, Tangential, Symmetrie
- Maßliche Constraints: Abstand, Radius, Winkel (`Skizze → Sketcher-Randbedingungen → …`)
- Freiheitsgrade (Degrees of Freedom, DOF) verstehen
- Hilfselemente: Konstruktionsgeometrie (`Skizze → Sketcher-Geometrien → Konstruktionsmodus umschalten`)
- Strategie: erst Geometrie, dann Constraints

**Neue Begriffe:**
- **Constraint (Randbedingung):** Geometrische oder maßliche Einschränkung, die Freiheitsgrade einer Skizze reduziert
- **Vollständig bestimmt:** Skizze hat 0 verbleibende Freiheitsgrade – alle Elemente sind eindeutig positioniert

---

### M04 – Part Design Grundlagen

**Lernziel:** 3D-Körper durch Aufmaß und Tasche aus Skizzen erzeugen.

**Workbench:** *Part Design*

**Inhalte:**
- Body und Feature-Konzept: parametrischer Modellbaum
- Aufmaß (Pad): Skizze zu 3D-Körper extrudieren (`Part Design → Aufmaß`)
- Tasche (Pocket): Material aus Körper entfernen (`Part Design → Tasche`)
- Fase und Verrundung: Kanten bearbeiten (`Part Design → Fase`, `Part Design → Verrundung`)
- Skizze auf Körperfläche erstellen

**Neue Begriffe:**
- **Body:** Container für ein zusammenhängendes Part-Design-Modell
- **Feature:** Einzelne Modellierungsoperation im parametrischen Baum (Pad, Pocket, Fillet …)
- **Aufmaß (Pad):** Extrusion einer Skizze entlang einer Achse zu einem Volumenkörper

---

### M05 – Part Design Vertiefung

**Lernziel:** Komplexere Geometrien durch erweiterte Operationen und Referenzen erstellen.

**Workbench:** *Part Design*

**Inhalte:**
- Rotation (Revolution): Körper durch Drehung einer Skizze (`Part Design → Drehteil`)
- Bezugselemente: Bezugsebene, Bezugsachse, Bezugspunkt (`Part Design → Bezugselemente`)
- Muster: lineares und polares Muster (`Part Design → Lineares Muster`, `Part Design → Polares Muster`)
- Spiegeln (`Part Design → Gespiegeltes Objekt`)
- Parametrik nutzen: Maße nachträglich ändern

**Neue Begriffe:**
- **Drehteil (Revolution):** Volumenkörper, der durch Rotation einer Profilskizze um eine Achse entsteht
- **Bezugselement:** Virtuelle Referenzgeometrie (Ebene, Achse, Punkt) ohne Masse oder Volumen

---

### M06 – Baugruppen & Assembly

**Lernziel:** Mehrere Einzelteile zu einer Baugruppe zusammenfügen und verbinden.

**Workbench:** *Assembly*

**Inhalte:**
- Neues Assembly-Dokument anlegen
- Teile einfügen (`Assembly → Komponente einfügen`)
- Joints (Verbindungen): Fest, Drehgelenk, Schieber (`Assembly → Verbindung erstellen`)
- Explosionsansicht
- Abhängigkeiten zwischen Teilen

> [!warning] Versionshinweis
> Die *Assembly*-Workbench ist seit FreeCAD 1.0 nativ integriert. Ältere Tutorials verwenden externe Addons (A2plus, Assembly4) – diese Anleitungen nicht verwenden.

---

### M07 – Technische Zeichnung

**Lernziel:** Aus einem 3D-Modell eine normgerechte technische Zeichnung ableiten.

**Workbench:** *TechDraw*

**Inhalte:**
- Neues TechDraw-Dokument, Seitenformat wählen (`TechDraw → Seite einfügen → …`)
- Ansichten einfügen: Haupt-, Hilfs-, Schnittansicht (`TechDraw → Ansicht einfügen`)
- Bemaßung: Länge, Radius, Winkel (`TechDraw → Bemaßung`)
- Schriftfeld ausfüllen
- Export als PDF (`Datei → Exportieren`)

**Neue Begriffe:**
- **Projektion:** Darstellung eines 3D-Körpers auf einer 2D-Zeichenebene (Europäische/Amerikanische Normprojektion)
- **Schnittansicht:** Darstellung des Körperinneren durch einen gedachten Schnitt

---

### M08 – Abschlussprojekt

**Lernziel:** Eigenständiges Modellieren eines mehrteiligen Objekts von der Skizze bis zur Zeichnung.

**Inhalte:**
- Aufgabenstellung: Einfache Mechanik (z. B. Scharnierverbindung, Klemmhalterung)
- Teilaufgaben:
  1. Einzelteile modellieren (M02–M05)
  2. Baugruppe erstellen (M06)
  3. Technische Zeichnung eines Teils ableiten (M07)
- Selbstkontrolle anhand der Checkliste

> [!tip] Empfehlung
> Abschlussprojekt-Modell vorab festlegen und als STEP-Referenzdatei im Projekt hinterlegen, damit Teilnehmer ihr Ergebnis vergleichen können.

---

## Querverweise & Ressourcen

- [[Glossar FreeCAD]] – Alle Fachbegriffe alphabetisch
- [[Cheat Sheet – Tastenkürzel]] – Schnellreferenz Shortcuts
- [[Cheat Sheet – Sketcher Constraints]] – Übersicht alle Randbedingungen
- [FreeCAD Dokumentation](https://wiki.freecad.org) – Offizielle Referenz (EN)
- [FreeCAD Forum](https://forum.freecad.org) – Community

---

## Konventionen in den Modulen

| Element | Format | Beispiel |
|---|---|---|
| Menüoperation | Pfad in Backticks | `Part Design → Aufmaß` |
| Nur-Symbolleisten-Operation | Bild + Name | `![[pd_pad.png]] Aufmaß` |
| Tastenkürzel | Backticks | `Strg+Z` |
| Workbench | Kursiv | *Part Design* |
| Interner Link | Doppelklammer | `[[M02 – Sketcher Grundlagen]]` |
| Hinweis | Obsidian-Callout | `> [!info]` |
