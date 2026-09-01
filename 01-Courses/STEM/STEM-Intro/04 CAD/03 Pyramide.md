## (A) Skizze für die Grundfläche
1. Wechsle zu PartDesign / Sketcher
2. Erstelle einen neuen Körper + neue Skizze auf der XY-Ebene
3. Zeichne ein Quadrat (oder beliebiges Polygon)
4. Skizze schließen
## (B) Punkt als Spitze erzeugen
Damit FreeCAD loften kann, braucht es eine zweite "Skizze" als Punkt:
1. Erstelle eine neue Ebene oberhalb der Grundfläche:
    - `PartDesign → Bezugselement → Bezugspunkt`
    - Abstand z. B. Höhe = 50 mm
2. Skizze schließen
## (C) Loft erzeugen
1. Wähle:
    - zuerst Grundflächen-Skizze
    - dann Punkt-Skizze
2. Wechsel in Part → Loft 
3. OK