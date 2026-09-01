# Aufgabenblatt: Grundlegende Data Manipulation Language (DML)

## Übersicht der SQL-Befehle

Für dieses Modul werden wir uns auf die folgenden DML-Befehle konzentrieren:

1. INSERT
2. UPDATE
3. DELETE

## Kurzbeschreibung der SQL-Befehle

### 1. INSERT

Der INSERT-Befehl wird verwendet, um neue Datensätze in eine Tabelle einzufügen.

Syntax:
```sql
INSERT INTO tabelle (spalte1, spalte2, spalte3, ...)
VALUES (wert1, wert2, wert3, ...);
```

### 2. UPDATE

Der UPDATE-Befehl wird verwendet, um bestehende Datensätze in einer Tabelle zu ändern.

Syntax:
```sql
UPDATE tabelle
SET spalte1 = wert1, spalte2 = wert2, ...
WHERE bedingung;
```

### 3. DELETE

Der DELETE-Befehl wird verwendet, um Datensätze aus einer Tabelle zu löschen.

Syntax:
```sql
DELETE FROM tabelle
WHERE bedingung;
```

## Aufgaben

4. Erstellen Sie eine Tabelle "Mitarbeiter" mit den Spalten ID (Primärschlüssel), Vorname, Nachname, Abteilung und Gehalt.

5. Fügen Sie mindestens 5 Datensätze in die Tabelle "Mitarbeiter" ein.

6. Aktualisieren Sie das Gehalt eines bestimmten Mitarbeiters.

7. Ändern Sie die Abteilung für alle Mitarbeiter einer bestimmten Abteilung.

8. Löschen Sie einen bestimmten Mitarbeiter aus der Tabelle.

9. Löschen Sie alle Mitarbeiter einer bestimmten Abteilung.

Hinweis: Achten Sie bei den UPDATE- und DELETE-Befehlen besonders auf die WHERE-Klausel, um unbeabsichtigte Änderungen oder Löschungen zu vermeiden.

Quellen
