# Lösung des Aufgabenblattes für Modul 3: Grundlegende Data Manipulation Language (DML)

## Aufgabe 1: Erstellen der Tabelle "Mitarbeiter"

Zur Erstellung der Tabelle "Mitarbeiter" verwenden wir den folgenden SQL-Befehl:

```sql
CREATE TABLE `Mitarbeiter` (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Vorname VARCHAR(50),
    Nachname VARCHAR(50),
    Abteilung VARCHAR(50),
    Gehalt DECIMAL(10, 2)
);
```

Dieser Befehl erstellt eine Tabelle mit den geforderten Spalten: ID (als Primärschlüssel), Vorname, Nachname, Abteilung und Gehalt. Der Datentyp DECIMAL(10, 2) für das Gehalt erlaubt Werte mit bis zu 10 Stellen insgesamt, davon 2 Nachkommastellen.

## Aufgabe 2: Einfügen von Datensätzen

Um mindestens 5 Datensätze in die Tabelle einzufügen, verwenden wir mehrere INSERT-Befehle:

```sql
INSERT INTO `Mitarbeiter` (ID, Vorname, Nachname, Abteilung, Gehalt) 
VALUES (1, 'Anna', 'Müller', 'Verkauf', 45000.00);
INSERT INTO `Mitarbeiter` (Vorname, Nachname, Abteilung, Gehalt) 
VALUES ('Peter', 'Schmidt', 'Marketing', 50000.00),
('Julia', 'Meier', 'IT', 60000.00),
('Thomas', 'Klein', 'Verkauf', 47000.00),
('Laura', 'Weber', 'HR', 52000.00);
```

Diese Befehle fügen fünf verschiedene Mitarbeiter mit unterschiedlichen Abteilungen und Gehältern in die Tabelle ein.

## Aufgabe 3: Aktualisieren des Gehalts eines bestimmten Mitarbeiters

Um das Gehalt eines bestimmten Mitarbeiters zu aktualisieren, verwenden wir den UPDATE-Befehl:

```sql
UPDATE Mitarbeiter
SET Gehalt = 48000.00
WHERE ID = 1;
```

Dieser Befehl erhöht das Gehalt des Mitarbeiters mit der ID 1 (Anna Müller) auf 48.000,00.

## Aufgabe 4: Ändern der Abteilung für alle Mitarbeiter einer bestimmten Abteilung

Um die Abteilung für alle Mitarbeiter einer bestimmten Abteilung zu ändern, verwenden wir ebenfalls den UPDATE-Befehl:

```sql
UPDATE Mitarbeiter
SET Abteilung = 'Vertrieb'
WHERE Abteilung = 'Verkauf';
```

Dieser Befehl ändert die Abteilung aller Mitarbeiter von 'Verkauf' zu 'Vertrieb'.

## Aufgabe 5: Löschen eines bestimmten Mitarbeiters

Um einen bestimmten Mitarbeiter aus der Tabelle zu löschen, verwenden wir den DELETE-Befehl:

```sql
DELETE FROM Mitarbeiter
WHERE ID = 5;
```

Dieser Befehl löscht den Mitarbeiter mit der ID 5 (Laura Weber) aus der Tabelle.

## Aufgabe 6: Löschen aller Mitarbeiter einer bestimmten Abteilung

Um alle Mitarbeiter einer bestimmten Abteilung zu löschen, verwenden wir ebenfalls den DELETE-Befehl:

```sql
DELETE FROM Mitarbeiter
WHERE Abteilung = 'Marketing';
```

Dieser Befehl löscht alle Mitarbeiter der Marketing-Abteilung aus der Tabelle.