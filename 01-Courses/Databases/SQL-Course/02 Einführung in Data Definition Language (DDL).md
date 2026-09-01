- Die Data Definition Language (DDL) 
	- ist ein wesentlicher Bestandteil von SQL, der für die 
		- Definition und 
		- Verwaltung der Datenbankstruktur 
	- verwendet wird. 
- DDL-Befehle ermöglichen es uns, Datenbankobjekte wie 
	- Tabellen, 
	- Indizes und 
	- Schemata 
	- zu erstellen, zu ändern und zu löschen.

## Hauptbefehle der DDL

Die wichtigsten DDL-Befehle sind:
- `CREATE`: 
	- Zum Erstellen neuer Datenbankobjekte
- `ALTER`: 
	- Zum Ändern bestehender Datenbankobjekte
- DROP: 
	- Zum Löschen von Datenbankobjekten

## CREATE TABLE

Der `CREATE TABLE`-Befehl wird verwendet, um eine neue Tabelle in der Datenbank zu erstellen.

Syntax:

```sql
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...,
    PRIMARY KEY (column)
);
```

Beispiel:

```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE
);
```

Erklärung der Komponenten:
- `table_name`: 
	- Der Name der zu erstellenden Tabelle
- `column`: 
	- Der Name jeder Spalte in der Tabelle
- `datatype`: 
	- Der Datentyp jeder Spalte (z.B. `INT`, `VARCHAR`, `DATE`)
- `constraints`: 
	- Optionale Einschränkungen für jede Spalte (z.B. `NOT NULL`, `UNIQUE`)
- `PRIMARY KEY`: 
	- Definiert den Primärschlüssel der Tabelle

## ALTER TABLE

Der `ALTER TABLE`-Befehl wird verwendet, um die Struktur einer bestehenden Tabelle zu ändern.

Häufige Operationen:

- Hinzufügen einer neuen Spalte:

```sql
ALTER TABLE table_name
ADD column_name datatype constraints;
```

Beispiel:
```sql
ALTER TABLE Customers
ADD PhoneNumber VARCHAR(20);
```

- Ändern des Datentyps einer Spalte:

```sql
ALTER TABLE table_name
MODIFY COLUMN column_name new_datatype;
```

Beispiel:
```sql
ALTER TABLE Customers
MODIFY COLUMN Email VARCHAR(150);
```

- Löschen einer Spalte:

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

Beispiel:
```sql
ALTER TABLE Customers
DROP COLUMN DateOfBirth;
```

- Hinzufügen einer Constraint:

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column);
```

Beispiel:
```sql
ALTER TABLE Customers
ADD CONSTRAINT unique_email UNIQUE (Email);
```

## DROP TABLE

Der `DROP TABLE`-Befehl wird verwendet, um eine Tabelle vollständig aus der Datenbank zu entfernen.

Syntax:

```sql
DROP TABLE table_name;
```

Beispiel:

```sql
DROP TABLE Customers;
```

Wichtiger Hinweis: Der `DROP TABLE`-Befehl löscht die Tabelle und alle darin enthaltenen Daten unwiderruflich. Er sollte mit äußerster Vorsicht verwendet werden.

## Beste Praktiken für DDL

- Planen Sie Ihre Datenbankstruktur sorgfältig, bevor Sie mit der Implementierung beginnen.
- Verwenden Sie aussagekräftige Namen für Tabellen und Spalten.
- Wählen Sie geeignete Datentypen für jede Spalte, um Speicherplatz zu optimieren und Datenintegrität zu gewährleisten.
- Implementieren Sie geeignete `Constraints`, um die Datenintegrität zu wahren.
- Dokumentieren Sie Ihre Datenbankstruktur und alle vorgenommenen Änderungen.
- Testen Sie DDL-Befehle in einer Entwicklungsumgebung, bevor Sie sie in der Produktionsumgebung ausführen.
- Erstellen Sie Backups, bevor Sie größere strukturelle Änderungen vornehmen.

## Zusammenfassung

- Die Data Definition Language (DDL) ist ein grundlegender Bestandteil von SQL, der es uns ermöglicht, die Struktur unserer Datenbank zu definieren und zu verwalten. 
- Mit den Befehlen `CREATE TABLE`, `ALTER TABLE` und `DROP TABLE` können wir Tabellen erstellen, ändern und löschen. 
- Eine gute Beherrschung der DDL ist entscheidend für die effektive Verwaltung und Optimierung von Datenbankstrukturen.