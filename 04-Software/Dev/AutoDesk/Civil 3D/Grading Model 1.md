Ein **Grading Model** in **Autodesk Civil 3D** bezieht sich auf den Prozess und die Werkzeuge zur Modellierung von Geländeveränderungen oder **Oberflächengestaltungen** (englisch: "grading"). 
Es wird häufig verwendet, um detaillierte Entwürfe für Erdarbeiten zu erstellen, z. B. für Baugrundstücke, Straßenrampen, Böschungen, Dämme oder andere Geländemodifikationen.

### Wichtige Aspekte des Grading Models in Civil 3D:

#### 1. **Definition**

Das **Grading Model** besteht aus einer Sammlung von **Grading-Objekten**, die Änderungen an einer bestehenden Geländeoberfläche (z. B. einer Topographie) darstellen. Diese Änderungen können Böschungen, Aufschüttungen, Abtragungen oder andere Neigungen beinhalten, die entweder automatisch berechnet oder manuell definiert werden.

---

#### 2. **Hauptbestandteile**

- **Grading Groups**:
    
    - Eine Grading Group fasst mehrere Grading-Objekte zusammen und erstellt eine **Grading-Oberfläche** (Surface), die die Geländemodifikationen darstellt.
    - Sie enthält Berechnungen für Volumina (Erdmassen) und Schnitt-/Füllbereiche.
- **Targets (Ziele)**:
    
    - Ein Grading kann auf eine bestimmte bestehende Oberfläche oder eine definierte Höhe abzielen.
    - Beispiel: Eine Böschung, die von einer Straßenkante in die bestehende Topographie abfällt.
- **Feature Lines**:
    
    - Linien mit 3D-Eigenschaften, die die Basisgeometrie für das Grading definieren. Sie können Neigungen und Höhen zugewiesen bekommen.
    - Diese Linien definieren oft Kanten von Böschungen oder Baubereichen.

---

#### 3. **Workflow im Grading**

1. **Erstellung der Feature Line**:
    
    - Zeichne oder importiere eine 2D/3D-Linie (z. B. Grundstücksgrenze, Straßenkante oder Fundamentkanten) und definiere ihre Höhen und Neigungen.
2. **Definition des Grading-Kriteriums**:
    
    - Wähle ein Grading-Kriterium aus, z. B.:
        - **Böschungsneigung** (z. B. 1:3).
        - **Höhenversatz** (z. B. +2 m oder -1 m).
        - **Abstand zu einer Zieloberfläche**.
3. **Erstellung des Gradings**:
    
    - Wende das Grading auf die Feature Line an.
    - Automatische Erstellung einer **Grading-Oberfläche**, die die Änderungen darstellt.
4. **Analyse und Optimierung**:
    
    - Berechne Volumina (Erdbewegung).
    - Passe Neigungen, Höhen oder Kanten an, um Entwurfskriterien oder Bauvorgaben zu erfüllen.

---

#### 4. **Typische Anwendungen des Grading Models**

- **Böschungsplanung**:
    
    - Gestaltung von Böschungen für Straßen, Rampen, oder Hänge.
- **Grundstücksmodellierung**:
    
    - Erstellung von angepassten Höhenmodellen für Baugrundstücke, Parkplätze oder Gebäudeplattformen.
- **Geländeanpassungen**:
    
    - Modellierung von Aufschüttungen oder Abtragungen in einem bestehenden Gelände.
- **Erdbewegungsberechnung**:
    
    - Berechnung von Aushub- und Füllvolumina für Bauprojekte.

---

#### 5. **Vorteile des Grading Models**

- **Dynamische Anpassung**:
    
    - Änderungen an Feature Lines oder Kriterien passen das gesamte Grading und die zugehörige Oberfläche automatisch an.
- **Automatisierte Berechnungen**:
    
    - Automatische Erstellung von Böschungen, Volumenberechnungen und Geländeanpassungen.
- **Integration**:
    
    - Grading-Modelle können mit anderen Civil 3D-Objekten wie **Oberflächen**, **Achsen**, oder **Profilen** kombiniert werden.
- **Visualisierung**:
    
    - Bessere Darstellung von geplanten Geländemodifikationen und ihrer Auswirkungen auf das umgebende Gelände.

---

#### 6. **Typische Herausforderungen**

- **Komplexität bei großen Projekten**:
    
    - Viele Grading-Objekte in einer Grading Group können zu Berechnungsverzögerungen führen.
- **Überschneidungen**:
    
    - Unsaubere Feature Lines oder unklare Zieldefinitionen können zu Fehlern oder ungültigen Oberflächen führen.
- **Manuelle Anpassungen**:
    
    - In einigen Fällen ist manuelle Nachbearbeitung nötig, um spezielle Designanforderungen zu erfüllen.

---

#### 7. **Tools im Grading Model**

Civil 3D bietet spezialisierte Tools für das Grading:

- **Grading Creation Tools**: Werkzeuge zur Definition von Grading-Objekten.
- **Grading Volume Tools**: Zur Berechnung von Volumina und Massen.
- **Grading Editor**: Zur Anpassung bestehender Grading-Objekte.
