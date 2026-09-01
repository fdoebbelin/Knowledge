## Ziele

- Verständnis der grundlegenden Konzepte relationaler Datenbanken.
- Anwendung von Primär- und Fremdschlüsseln zur Verknüpfung von Tabellen.
- Einführung in die Normalisierung, um Datenstrukturen zu optimieren.

---

## Grundlagen relationaler Datenbanken

- **Tabellen**: Basisstruktur zur Organisation von Daten.
- **Attribute**: Spalten, die die Eigenschaften eines Datensatzes beschreiben.
- **Datensätze**: Einzelne Einträge (Zeilen) in einer Tabelle.

---

## Schlüsselkonzepte

- **Primärschlüssel (PK)**:
    - Eindeutiger Bezeichner für jeden Datensatz in einer Tabelle.
    - Beispiel: „Kundennummer“ in der Kundentabelle.
- **Fremdschlüssel (FK)**:
    - Verknüpft Tabellen und stellt Beziehungen her.
    - Beispiel: „Kundennummer“ in der Bestelltabelle verweist auf die Kundentabelle.
- **Beziehungen**:
    - **1:1**: Ein Eintrag in Tabelle A entspricht einem Eintrag in Tabelle B.
    - **1:n**: Ein Eintrag in Tabelle A ist mit mehreren Einträgen in Tabelle B verbunden.
    - **n:m**: Mehrere Einträge in Tabelle A sind mit mehreren Einträgen in Tabelle B verknüpft (Auflösung durch Zwischentabelle).

---

## Datenintegrität und Konsistenz

- **Integritätsregeln**:
    - **Entity-Integrität**: Jeder Datensatz hat einen eindeutigen Primärschlüssel.
    - **Referenzielle Integrität**: Fremdschlüssel müssen auf existierende Primärschlüssel verweisen.
- **Constraints**:
    - **NOT NULL**: Verhindert leere Felder.
    - **UNIQUE**: Verhindert doppelte Werte.
    - **CHECK**: Prüft Bedingungen für Feldwerte.

---

## Einführung in die Normalisierung

- **1. Normalform (1NF)**:
    - Daten in Tabellenform, keine mehrfachen Einträge in Zellen.
- **2. Normalform (2NF)**:
    - Entfernung von Teildaten, sodass jedes Attribut vom ganzen Primärschlüssel abhängt.
- **3. Normalform (3NF)**:
    - Entfernung transitiver Abhängigkeiten zwischen Attributen.

**Warum ist Normalisierung wichtig?**

- Vermeidung von Redundanz und Anomalien.
- Verbesserung der Datenbankeffizienz.