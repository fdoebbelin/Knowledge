Ein **Grading Model** in **Autodesk Civil 3D** ist ein digitales Geländemodell, das für die Planung und Gestaltung von Geländeveränderungen genutzt wird. Es umfasst die Werkzeuge und Datenstrukturen, mit denen Benutzer Änderungen an einer vorhandenen Geländeoberfläche (z. B. durch Aufschüttung oder Abtrag) modellieren und analysieren können.

Das Grading Model dient insbesondere der Gestaltung von Böschungen, Bauplätzen, Straßenrampen, Parkplätzen und anderen Bereichen, bei denen die Erdarbeiten präzise geplant werden müssen.

---

### **Elemente eines Grading Models in Civil 3D**

1. **Feature Lines**:
    
    - 3D-Linien, die die Grundlage für das Grading bilden. Sie definieren die Geometrie und Höhe der zu bearbeitenden Geländebereiche.
    - Beispiel: Grundstücksgrenzen, Straßenkanten oder die Kontur eines Fundaments.
2. **Grading Objects**:
    
    - Diese Objekte repräsentieren die tatsächlichen Geländeänderungen (z. B. Böschungen oder Höhenunterschiede).
    - Sie werden mit bestimmten **Grading-Kriterien** erstellt (z. B. Böschungsneigung oder Höhe relativ zu einer Oberfläche).
3. **Grading Groups**:
    
    - Eine Sammlung von Grading Objects, die zusammenarbeiten und eine einheitliche Oberfläche darstellen.
    - Innerhalb der Grading Group werden Volumenberechnungen (Aushub/Füllung) durchgeführt.
4. **Grading Surfaces**:
    
    - Oberflächen, die durch die Grading-Objekte definiert werden. Sie stellen das bearbeitete Gelände visuell dar und können für Analysen (z. B. Volumina, Entwässerung) verwendet werden.

---

### **Workflow zur Erstellung eines Grading Models**

1. **Grundlinien erstellen**:
    
    - Erstelle oder importiere **Feature Lines**, die die Basisgeometrie für das Grading definieren (z. B. Grundstücksgrenzen, Straßenkanten).
2. **Grading-Kriterien auswählen**:
    
    - Wähle, wie das Grading erfolgen soll, z. B.:
        - Böschungen mit einer festen Neigung (z. B. 1:3).
        - Höhenversatz (z. B. 2 Meter höher oder tiefer als eine bestehende Oberfläche).
3. **Grading erstellen**:
    
    - Wende die Kriterien auf die Feature Line an, um Grading-Objekte zu erstellen.
    - Dies generiert automatisch ein angepasstes Geländemodell.
4. **Analyse und Anpassung**:
    
    - Berechne Volumina für Aushub und Aufschüttung.
    - Passe die Feature Lines oder Grading-Parameter an, um die gewünschten Ergebnisse zu erzielen.
5. **Integration mit anderen Civil 3D-Objekten**:
    
    - Kombiniere das Grading Model mit bestehenden Oberflächen, Straßenachsen oder Profilen, um ein vollständiges Infrastrukturmodell zu erstellen.

---

### **Anwendungsbeispiele für ein Grading Model**

1. **Bauplatzgestaltung**:
    
    - Modellierung eines ebenen Bauplatzes innerhalb einer unebenen Topographie mit Böschungen.
2. **Straßenplanung**:
    
    - Erstellung von Böschungen oder Rampen entlang von Straßen.
3. **Parkplätze und Terrassen**:
    
    - Gestaltung von flachen oder leicht geneigten Bereichen für Parkplätze oder Terrassen.
4. **Entwässerungsplanung**:
    
    - Modellierung von Gefällen zur Optimierung der Wasserableitung.

---

### **Vorteile des Grading Models in Civil 3D**

- **Effizienz**:
    
    - Automatische Erstellung und Anpassung von Geländemodifikationen.
- **Dynamik**:
    
    - Änderungen an Feature Lines oder Grading-Parametern passen das gesamte Modell automatisch an.
- **Integration**:
    
    - Grading-Objekte können mit anderen Civil 3D-Elementen wie Achsen, Oberflächen oder Profilen kombiniert werden.
- **Präzision**:
    
    - Exakte Volumenberechnungen für Aushub und Aufschüttung.
- **Visualisierung**:
    
    - Realistische Darstellung der geplanten Geländemodifikationen für Analysen und Präsentationen.

---

### **Herausforderungen**

- **Komplexität**:
    
    - Große oder komplexe Grading Groups können die Berechnungszeit erhöhen.
- **Genauigkeit**:
    
    - Fehlerhafte Feature Lines oder nicht definierte Ziele können ungewollte Ergebnisse erzeugen.
- **Manuelle Anpassungen**:
    
    - Spezifische Anforderungen können zusätzliche Bearbeitungszeit erfordern.