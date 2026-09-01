## Thema 1: Grundlagen von UML

- **Definition UML**:
    - Unified Modeling Language, eine standardisierte grafische Sprache zur Visualisierung, Spezifikation, Konstruktion und Dokumentation von Software-Systemen.
    - Ziel: Vereinfachung der Kommunikation zwischen Entwicklern, Architekten und weiteren Stakeholdern.
- **Geschichte**:
    - Entwicklung in den 1990er Jahren durch Grady Booch, James Rumbaugh und Ivar Jacobson.
    - Standardisierung durch die Object Management Group (OMG).
- **Einsatzgebiete**:
    - Modellierung von Softwarearchitekturen, Geschäftsprozessen und Systementwürfen.
    - Unterstützung bei der Analyse, dem Design und der Implementierung von Softwarelösungen.

## Thema 2: Übersicht über UML-Diagrammtypen

- **Hauptkategorien**:
    - **Strukturdiagramme**: Beschreiben die statischen Aspekte eines Systems.
    - **Verhaltensdiagramme**: Modellieren die dynamischen Aspekte und das Verhalten eines Systems.
- **Häufig verwendete Diagrammtypen**:
    - **Klassendiagramme** (Struktur): Zeigen Klassen, Attribute, Methoden und deren Beziehungen.
    - **Objektdiagramme** (Struktur): Abbildung spezifischer Instanzen von Klassen.
    - **Use-Case-Diagramme** (Verhalten): Darstellung von Anwendungsfällen und beteiligten Akteuren.
    - **Sequenzdiagramme** (Verhalten): Visualisierung von Interaktionen zwischen Objekten.
    - **Aktivitätsdiagramme** (Verhalten): Modellierung von Abläufen oder Workflows.

## Thema 3: Einführung in Klassendiagramme

- **Definition**:
    - Beschreiben die statische Struktur eines Systems durch Klassen, deren Attribute, Methoden und Beziehungen.
- **Elemente eines Klassendiagramms**:
    - **Klassen**: Repräsentieren die zentralen Elemente eines Systems.
        - Darstellung als Rechteck mit drei Bereichen:
            1. Klassenname.
            2. Attribute (Eigenschaften, z. B. `name: String`).
            3. Methoden (Operationen, z. B. `getName(): String`).
    - **Beziehungen**: Verbindungen zwischen Klassen.
        - **Assoziationen**: Beziehungen zwischen zwei oder mehr Klassen (z. B. Kunde ↔ Bestellung).
        - **Aggregation**: "Hat-ein"-Beziehung; Teile können unabhängig existieren (z. B. Bibliothek ↔ Buch).
        - **Komposition**: "Besteht-aus"-Beziehung; Teile sind abhängig vom Ganzen (z. B. Auto ↔ Motor).
        - **Vererbung**: Spezialisierung einer Klasse (z. B. Fahrzeug → Auto).
        - **Abhängigkeit**: Temporäre Beziehung; eine Klasse nutzt eine andere (z. B. `OrderProcessor` ↔ `PaymentService`).

## Thema 4: Einführung in Objektdiagramme

- **Definition**:
    - Zeigen Instanzen (Objekte) von Klassen und deren Zustand zu einem bestimmten Zeitpunkt.
- **Elemente eines Objektdiagramms**:
    - **Objekte**: Instanzen von Klassen mit spezifischen Attributwerten (z. B. `kunde1: Kunde {name=„Max Mustermann“}`).
    - **Links**: Konkrete Verbindungen zwischen Objekten, basierend auf Assoziationen im Klassendiagramm.
- **Beispielanwendung**: Darstellung eines konkreten Szenarios, z. B. aktueller Warenkorb eines Kunden.

#### **Übungen**

- **Ziel**: Praktische Anwendung der theoretischen Inhalte zur Festigung der Grundlagen.
- **Übung 1**: Erstellen eines einfachen Klassendiagramms basierend auf einer Textbeschreibung.
    - Beispiel: Modellierung eines Bibliothekssystems (Klassen: Buch, Kunde, Ausleihe).
- **Übung 2**: Ableiten eines Objektdiagramms aus einem bestehenden Klassendiagramm.
    - Beispiel: Darstellung von konkreten Objekten und deren Beziehungen für das Bibliotheksszenario.

---

Dieser Ablaufplan bietet eine klare Struktur und beschreibt die relevanten Begriffe und Konzepte präzise, um ein solides Verständnis der Grundlagen von UML zu vermitteln.