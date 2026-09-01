## Übersicht der SQL-Befehle

Für die folgenden Übungen werden Sie hauptsächlich diese DDL-Befehle verwenden:

- `CREATE TABLE`
- `ALTER TABLE`
- `DROP TABLE`
- `CREATE INDEX`
- `DROP INDEX`

## Kurzbeschreibung der SQL-Befehle

### CREATE TABLE
Erstellt eine neue Tabelle in der Datenbank.

Syntax:
```sql
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);
```

### ALTER TABLE
Modifiziert die Struktur einer bestehenden Tabelle.

Syntax:
```sql
ALTER TABLE table_name
ADD column_name datatype;

ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE table_name
MODIFY COLUMN column_name datatype;
```

### DROP TABLE
Löscht eine bestehende Tabelle aus der Datenbank.

Syntax:
```sql
DROP TABLE table_name;
```

### CREATE INDEX
Erstellt einen Index für eine oder mehrere Spalten einer Tabelle.

Syntax:
```sql
CREATE INDEX index_name
ON table_name (column1, column2, ...);
```

### DROP INDEX
Löscht einen bestehenden Index.

Syntax:
```sql
DROP INDEX index_name ON table_name;
```

## Aufgaben

### 1. Erstellen Sie eine Tabelle "Employees" mit folgenden Spalten:
- employee_id (Integer, Primärschlüssel)
- first_name (VARCHAR(50))
- last_name (VARCHAR(50))
- email (VARCHAR(100))
- hire_date (DATE)
- salary (DECIMAL(10,2))

### 2. Fügen Sie der Tabelle "Employees" eine neue Spalte "department" (VARCHAR(50)) hinzu.

### 3. Ändern Sie den Datentyp der Spalte "salary" zu DECIMAL(12,2).

### 4. Erstellen Sie einen Index auf der Spalte "last_name" der Tabelle "Employees".

### 5. Erstellen Sie eine neue Tabelle "Departments" mit folgenden Spalten:
- department_id (Integer, Primärschlüssel)
- department_name (VARCHAR(100))
- manager_id (Integer, Fremdschlüssel zur Tabelle Employees)

### 6. Fügen Sie der Tabelle "Employees" eine Fremdschlüssel-Beziehung zur Tabelle "Departments" hinzu, die auf die Spalte "department_id" verweist.

### 7. Löschen Sie den zuvor erstellten Index auf der Spalte "last_name" der Tabelle "Employees".

### 8. Erstellen Sie einen zusammengesetzten Index auf den Spalten "last_name" und "first_name" der Tabelle "Employees".

### 9. Löschen Sie die Tabelle "Departments".

Hinweis: Achten Sie darauf, die korrekte Syntax für Ihre spezifische Datenbankumgebung zu verwenden, da es leichte Variationen zwischen verschiedenen Datenbankmanagementsystemen geben kann.