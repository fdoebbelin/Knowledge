## Aufgabe 1: Zuordnung von SQL-Befehlen

1. `SELECT` (DQL)
   - Funktion: Daten aus einer oder mehreren Tabellen abfragen

2. `CREATE TABLE` (DDL)
   - Funktion: Neue Tabelle in der Datenbank erstellen

3. `INSERT` (DML)
   - Funktion: Neue Datensätze in eine Tabelle einfügen

4. `GRANT` (DCL)
   - Funktion: Berechtigungen an Benutzer oder Rollen vergeben

5. `UPDATE` (DML)
   - Funktion: Bestehende Datensätze in einer Tabelle aktualisieren

6. `ALTER TABLE` (DDL)
   - Funktion: Struktur einer bestehenden Tabelle ändern

7. `COMMIT` (TCL)
   - Funktion: Transaktion abschließen und Änderungen dauerhaft speichern

8. `REVOKE` (DCL)
   - Funktion: Zuvor erteilte Berechtigungen entziehen

9. `DELETE` (DML)
   - Funktion: Datensätze aus einer Tabelle löschen

10. `DROP TABLE` (DDL)
    - Funktion: Existierende Tabelle aus der Datenbank entfernen

## Aufgabe 2: Kurzbeschreibungen

- `CREATE TABLE`: 
	- Erstellt eine neue Tabelle in der Datenbank mit definierten Spalten und Datentypen.
- `ALTER TABLE`: 
	- Modifiziert die Struktur einer bestehenden Tabelle, z.B. durch Hinzufügen oder Entfernen von Spalten.
- `DROP TABLE`: 
	- Löscht eine existierende Tabelle und alle darin enthaltenen Daten permanent aus der Datenbank.
- `SELECT`: 
	- Ruft Daten aus einer oder mehreren Tabellen ab, basierend auf spezifizierten Kriterien.
- `INSERT`: 
	- Fügt neue Datensätze in eine bestehende Tabelle ein.
- `UPDATE`: 
	- Ändert bestehende Datensätze in einer Tabelle basierend auf spezifizierten Bedingungen.
- `DELETE`: 
	- Entfernt Datensätze aus einer Tabelle, die bestimmte Kriterien erfüllen.
- `GRANT`: 
	- Erteilt spezifische Berechtigungen an Benutzer oder Rollen für Datenbankobjekte.
- `REVOKE`: 
	- Entzieht zuvor erteilte Berechtigungen von Benutzern oder Rollen.
- `COMMIT`: 
	- Schließt eine Transaktion ab und macht alle Änderungen innerhalb der Transaktion permanent.
- `ROLLBACK`: 
	- Macht alle Änderungen rückgängig, die seit dem letzten `COMMIT` oder `ROLLBACK` in einer Transaktion gemacht wurden.

## Aufgabe 3: Beispielanwendungen

- DDL: 
	- Erstellung einer neuen Tabelle für Kundeninformationen in einem CRM-System.
- DML: 
	- Aktualisierung der Adresse eines bestehenden Kunden nach einem Umzug.
- DQL: 
	- Abfrage aller Bestellungen eines bestimmten Kunden im letzten Monat.
- DCL: 
	- Vergabe von Leserechten an einen neuen Mitarbeiter für bestimmte Tabellen.
- TCL: 
	- Sicherstellung, dass eine komplexe Reihe von Datenbankoperationen entweder vollständig oder gar nicht ausgeführt wird z.B. Überweisung im Bankverkehr.
## Aufgabe 4: SQL-Dialekte

- MySQL: 
	- Verwendet von **MySQL** und **MariaDB**
- T-SQL (Transact-SQL): 
	- Verwendet von **Microsoft SQL Server** und **Sybase**
- PL/SQL: 
	- Verwendet von **Oracle Database**

## Aufgabe 5: Diskussion

Wichtigkeit der Unterteilung von SQL-Befehlen in Gruppen:
- Strukturierung und Organisation: 
	- Die Gruppierung hilft, SQL-Befehle logisch zu organisieren, was das Verständnis und die Anwendung erleichtert.
- Sicherheit und Zugriffssteuerung: 
	- Die Unterteilung ermöglicht eine granulare Vergabe von Berechtigungen, z.B. können DML-Rechte vergeben werden, ohne DDL-Zugriff zu gewähren.
- Aufgabentrennung: 
	- Verschiedene Rollen (z.B. Entwickler, Datenbankadministratoren) können sich auf spezifische Befehlsgruppen konzentrieren.
- Lernprozess: 
	- Die Gruppierung erleichtert das Erlernen von SQL, da verwandte Konzepte zusammengefasst sind.
- Performanceoptimierung: 
	- Bestimmte Befehlsgruppen (z.B. DDL) können unterschiedliche Auswirkungen auf die Datenbankleistung haben, was bei der Optimierung berücksichtigt werden kann.

Vorteile für Datenbankadministratoren und Entwickler:
- Klarere Aufgabenteilung und Verantwortlichkeiten
- Einfachere Fehlerbehebung und Troubleshooting
- Besseres Verständnis der Datenbankstruktur und -operationen
- Effizientere Planung und Durchführung von Datenbankprojekten
- Vereinfachte Schulung und Einarbeitung neuer Teammitglieder