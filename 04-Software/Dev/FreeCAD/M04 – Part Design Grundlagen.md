# M04 – Part Design Grundlagen

> [!info] Modulinfo
> **Workbench:** *Part Design* | **Dauer:** ca. 90 min | **Voraussetzung:** [[M03 – Sketcher Constraints]]
> **Lernziel:** 3D-Körper durch Aufmaß und Tasche aus Skizzen erzeugen sowie Kanten mit Fase und Verrundung bearbeiten.

---

## Konzept: Parametrischer Modellbaum

*Part Design* arbeitet **feature-basiert**: Jede Operation (Aufmaß, Tasche, Verrundung …) wird als **Feature** im Modellbaum gespeichert. Features bauen sequenziell aufeinander auf – das Modell entsteht als Geschichte von Operationen, die jederzeit nachträglich editiert werden können.

**Wichtige Begriffe:**

| Begriff | Bedeutung |
|---|---|
| **Body** | Container-Objekt, das alle Features eines zusammenhängenden Volumenkörpers enthält |
| **Feature** | Einzelne Modellierungsoperation im parametrischen Baum |
| **Aufmaß (Pad)** | Extrusion einer Skizze entlang einer Achse zu einem Volumenkörper |
| **Tasche (Pocket)** | Extrusion einer Skizze in einen Körper hinein – entfernt Material |

> [!warning] Ein Body – ein Körper
> Jeder *Part Design*-Body muss zu jedem Zeitpunkt einen **zusammenhängenden** Volumenkörper ergeben. Operationen, die den Körper trennen würden, schlagen fehl. Für Mehrkörper-Modelle separate Bodies anlegen.

---

## Teil 1 – Einführung & Demonstration

### 1.1 Body anlegen und erste Skizze

**Ausgangspunkt:** Neues FreeCAD-Dokument (`Strg+N`), Workbench *Part Design* wählen.

1. `Part Design → Body` – neuen Body-Container anlegen.
   Der Modellbaum zeigt nun `Body` mit einem `Origin`-Eintrag (Standardebenen XY, XZ, YZ).
2. `Skizze → Skizze erstellen` – Bezugsebene **XY_Plane** wählen → OK.
3. Rechteck zeichnen (`G`, `R`): Startpunkt nahe dem Ursprung, Endpunkt diagonal.
4. Ursprung einbeziehen: Koinzidenz-Constraint (`C`, `O`) zwischen einem Eckpunkt des Rechtecks und dem Ursprungspunkt setzen.
5. Breite bemaßen (`C`, `D`): **80 mm**. Höhe bemaßen (`C`, `D`): **50 mm**.
6. Skizze schließen: `Skizze → Skizze schließen`.

> [!tip] Farb-Feedback
> Weiße Elemente = vollständig bestimmt (DOF = 0) → bereit für 3D-Operation.

---

### 1.2 Aufmaß (Pad) – Skizze zu 3D-Körper

`Part Design → Aufmaß`

Im Aufgabenbereich:
- **Typ:** Bemaßung
- **Länge:** `20 mm`
- Vorschau in der 3D-Ansicht prüfen → **OK**

Der Modellbaum zeigt jetzt: `Body → Sketch → Pad`.

> [!example] Ergebnis
> Ein quaderförmiger Volumenkörper (80 × 50 × 20 mm) liegt auf der XY-Ebene.

---

### 1.3 Skizze auf einer Körperfläche erstellen

Statt einer Standardebene kann jede **Körperfläche** als Skizzenbasis dienen:

1. Die **Deckfläche** des Quaders anklicken (hellere Farbgebung bei Hover).
2. `Skizze → Skizze erstellen` – FreeCAD verwendet die angeklickte Fläche automatisch als Bezugsebene.
3. Kreis zeichnen (`G`, `C`): Mittelpunkt nahe der Flächenmitte.
4. Mittelpunkt mit dem Flächenmittelpunkt ausrichten:
   - Horizontalen Abstand (`C`, `I`): **40 mm** vom linken Rand.
   - Vertikalen Abstand (`C`, `J`): **25 mm** vom unteren Rand.
5. Radius bemaßen (`C`, `N`): **12 mm**.
6. Skizze schließen.

---

### 1.4 Tasche (Pocket) – Material entfernen

`Part Design → Tasche`

Im Aufgabenbereich:
- **Typ:** Bemaßung
- **Tiefe:** `20 mm` *(entspricht der vollen Körperhöhe → Durchgangsbohrung)*
- Alternativ **Typ:** *Durch alles* für automatische Durchgangsbohrung → **OK**

> [!example] Ergebnis
> Zylindrische Bohrung (Ø 24 mm) durch den gesamten Quader.

---

### 1.5 Fase und Verrundung – Kanten bearbeiten

**Fase** (45°-Abschrägung einer Kante):
1. Obere Außenkanten des Quaders anklicken (mehrere mit `Strg`+Klick).
2. `Part Design → Fase`
3. **Größe:** `2 mm` → **OK**

**Verrundung** (Kantenrundung mit Radius):
1. Untere Außenkanten anklicken.
2. `Part Design → Verrundung`
3. **Radius:** `3 mm` → **OK**

> [!tip] Reihenfolge im Modellbaum
> Fase und Verrundung am Ende setzen – sie bauen auf der Endgeometrie auf. Frühe Kantenoperationen können bei späteren Formbeschneidungen zu Fehlern führen.

---

### 1.6 Parameter nachträglich ändern

Die Stärke von *Part Design*: Jedes Feature bleibt editierbar.

- Im Modellbaum `Pad` **doppelklicken** → Aufgabenbereich öffnet sich → Länge auf `30 mm` ändern → **OK**
- Alle abhängigen Features (Pocket, Fase, Verrundung) aktualisieren sich automatisch.

---

## Teil 2 – Übungen

### Übung 1 – Grundkörper mit Bohrung ⭐

**Ziel:** Einen Zylinder mit Sackloch-Bohrung modellieren.

**Teilschritte:**
1. Neues Dokument, Body anlegen.
2. Auf der XY-Ebene einen Kreis (Ø 60 mm, Mittelpunkt im Ursprung) skizzieren und vollständig bestimmen.
3. Aufmaß: **40 mm** → Vollzylinder.
4. Auf der Deckfläche einen konzentrischen Kreis (Ø 30 mm) skizzieren.
5. Tasche: **25 mm** tief (Sackloch, kein Durchgangsloch) → **OK**.

**Erwartetes Ergebnis:** Hohlzylinder mit 7,5 mm Wandstärke und geschlossenem Boden.

> [!tip] Konzentrisch
> Mittelpunkt der Taschenskizze mit einem Koinzidenz-Constraint auf den Mittelpunkt der projizierten Außenkante legen – oder: beide Mittelpunkte koinzident zum Ursprung der Fläche.

---

### Übung 2 – Winkel mit Passung ⭐⭐

**Ziel:** L-förmigen Winkel (Winkelprofil) modellieren.

**Teilschritte:**
1. Body anlegen. Auf XY-Ebene ein L-Profil skizzieren:
   - Außenkontur: 60 × 60 mm Quadrat
   - Innenkontur (Ausschnitt oben rechts): 54 × 54 mm
   - Wandstärke damit: **6 mm** auf beiden Schenkeln
   - Alle Elemente vollständig bestimmen.
2. Aufmaß: **80 mm**.
3. Vier Bohrungen hinzufügen: Auf einer der 6-mm-Flächen vier Kreise (Ø 5 mm) mit je **15 mm** Abstand von den Enden skizzieren → Tasche `Durch alles`.
4. Verrundung der Innenkante (Übergang der beiden Schenkel): **R 4 mm**.

**Erwartetes Ergebnis:** L-Profil mit 4 Befestigungsbohrungen und verrundeter Innenkante.

---

### Übung 3 – Parametrische Änderung & Fehleranalyse ⭐⭐⭐

**Ziel:** Robustheit eines parametrischen Modells prüfen und Fehler beheben.

**Ausgangspunkt:** Ergebnis aus Übung 2 (oder neu aufbauen).

**Teilschritte:**
1. Wandstärke von 6 mm auf **3 mm** ändern:
   - Im Modellbaum die Basisskizze doppelklicken.
   - Maßliche Constraints der Innenkontur anpassen.
   - Skizze schließen → Modell aktualisiert sich.
2. Prüfen: Sind die Bohrungen noch korrekt positioniert? Passen die Verrundungsradien?
3. Bohrungstiefe durch Anpassen der Tasche von `Durch alles` auf **8 mm** (Sackloch) ändern.
4. Aufmaßlänge von 80 mm auf **120 mm** ändern – beobachten, wie die Bohrungen mitwandern oder nicht.

**Erwartetes Ergebnis:** Verständnis für abhängige vs. unabhängige Constraint-Referenzen im parametrischen Modell.

> [!warning] Typischer Fehler
> Wenn ein Feature nach der Änderung **rot** im Modellbaum erscheint, hat es seine geometrische Referenz verloren (z. B. eine Fläche existiert nicht mehr). Feature doppelklicken und die Referenz neu zuweisen.

---

## Selbstkontrolle

| Kriterium | Erledigt |
|---|---|
| Body und Modellbaum-Konzept verstanden | ☐ |
| Aufmaß aus einer Skizze erzeugt | ☐ |
| Tasche (Durchgang und Sackloch) erstellt | ☐ |
| Skizze auf Körperfläche angelegt | ☐ |
| Fase und Verrundung angewendet | ☐ |
| Feature im Modellbaum nachträglich editiert | ☐ |

---

## Querverweise

- [[M03 – Sketcher Constraints]] – Vollständig bestimmte Skizzen als Voraussetzung
- [[M05 – Part Design Vertiefung]] – Drehteil, Bezugselemente, Muster
- [[PartDesign – Symbolleistenreferenz]] – Alle Symbole der *Part Design*-Workbench
- [[Glossar FreeCAD#Body]]
- [[Glossar FreeCAD#Aufmaß (Pad)]]
- [[Glossar FreeCAD#Tasche (Pocket)]]
- [[Glossar FreeCAD#Feature]]
- [[Cheat Sheet – Tastenkürzel]]
