FreeCAD gibt es zwei wichtige Arbeitsbereiche, mit denen man 3D-Modelle bauen kann: **Part** und **Part Design**. Beide können ähnliche Dinge tun, aber sie funktionieren unterschiedlich und eignen sich für verschiedene Modelle.

---

## 🔷 **Part – Arbeiten mit fertigen Bausteinen**

Stell dir vor, du hast eine Kiste voller **fertiger 3D-Formen**: Würfel, Zylinder, Kugeln usw.  
Im Part-Bereich kannst du diese Formen **nehmen, bewegen, schneiden, zusammenkleben** und daraus ein Modell bauen.

### **So arbeitet man im Part-Bereich:**

- Du startest mit fertigen Körpern (Box, Kugel usw.).
- Du kombinierst sie über **Booleans**:
    - _Verschmelzen_ (Fuse),
    - _Ausschneiden_ (Cut),
    - _Überlappen_ (Common).
- Jeder Körper bleibt ein **eigenständiges Objekt**.
### **Wann nutzt man das?**
- Wenn man schnell einfache Modelle braucht.
- Wenn man importierte 3D-Dateien bearbeiten möchte.
- Bei Formen, die man gut aus Grundkörpern zusammensetzen kann.

## 🔶 **Part Design – Modellieren wie in der Industrie**
Part Design funktioniert wie ein **professionelles CAD-System**:  
Du startest mit einer **Skizze** und baust das Modell **Schritt für Schritt** auf.

### **So arbeitet man in Part Design:**
- Zuerst eine **Skizze** auf einer Ebene zeichnen (z. B. ein Rechteck).
- Die Skizze **extrudieren** (= dicker machen).
- Dann weitere Änderungen hinzufügen:
    - Löcher (Pocket)
    - Rundungen (Fillet)
    - Symmetrische Wiederholungen (Pattern)

Alle Schritte gehören zu **einem einzigen Körper (Body)** und hängen **parametrisch** zusammen.  
Änderst du die Skizze, ändert sich das komplette Modell automatisch mit.

### **Wann nutzt man das?**
- Bei **genauen, mechanischen Bauteilen**.
- Wenn ein Modell **änderbar** oder **perfekt maßhaltig** sein soll.
- Beim 3D-Druck oder technischen Konstruktionen.

## 🎯 **Kurz gesagt**

- **Part = Lego-Technik**: Fertige Bausteine kombinieren.
- **Part Design = Modellieren mit System**: Skizzen + Features, wie in professionellen CAD-Programmen.