## Einführung in DML

- Die Data Manipulation Language (DML) ist ein wesentlicher Bestandteil von SQL, 
	- der sich mit dem 
		- Einfügen, 
		- Aktualisieren und 
		- Löschen 
	- von Daten in einer Datenbank befasst. 
- Die drei Hauptbefehle der DML sind 
	- `INSERT`, 
	- `UPDATE` und 
	- `DELETE`. 
- Diese Befehle ermöglichen es uns, 
	- den Inhalt der Datenbanktabellen 
		- zu verwalten und 
		- zu manipulieren.

## INSERT-Anweisungen

- Der INSERT-Befehl wird verwendet, 
	- um neue Datensätze in eine Tabelle einzufügen. 

Die grundlegende Syntax lautet:

```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

Beispiel:
```sql
INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES (1, 'John', 'Doe', 'john.doe@example.com');
```

Man kann auch mehrere Datensätze gleichzeitig einfügen:

```sql
INSERT INTO customers (customer_id, first_name, last_name, email)
VALUES 
(2, 'Jane', 'Smith', 'jane.smith@example.com'),
(3, 'Bob', 'Johnson', 'bob.johnson@example.com');
```

## UPDATE-Anweisungen

- Der UPDATE-Befehl wird verwendet, 
	- um bestehende Datensätze in einer Tabelle 
	- zu ändern. 

Die grundlegende Syntax lautet:

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

Beispiel:
```sql
UPDATE customers
SET email = 'john.doe.new@example.com'
WHERE customer_id = 1;
```

- Es ist wichtig, die `WHERE`-Klausel zu verwenden, um nur die gewünschten Datensätze zu aktualisieren. 
- Ohne `WHERE`-Klausel werden alle Datensätze in der Tabelle aktualisiert.

## DELETE-Anweisungen

- Der DELETE-Befehl wird verwendet, 
	- um Datensätze aus einer Tabelle 
	- zu entfernen. 

Die grundlegende Syntax lautet:

```sql
DELETE FROM table_name
WHERE condition;
```

Beispiel:
```sql
DELETE FROM customers
WHERE customer_id = 3;
```

- Auch hier ist die `WHERE`-Klausel wichtig, um nur die gewünschten Datensätze zu löschen. 
- Ohne `WHERE`-Klausel werden alle Datensätze in der Tabelle gelöscht.

## Sicherheitsaspekte und Best Practices

- Verwenden Sie immer eine `WHERE`-Klausel bei `UPDATE`- und `DELETE`-Anweisungen, 
	- es sei denn, Sie möchten absichtlich alle Datensätze ändern oder löschen.
- Testen Sie `UPDATE`- und `DELETE`-Anweisungen zuerst 
	- mit einer `SELECT`-Anweisung, um sicherzustellen, 
	- dass Sie die richtigen Datensätze auswählen.
- Verwenden Sie Transaktionen für komplexe Operationen, 
	- um die Datenintegrität zu gewährleisten.
- Seien Sie vorsichtig mit der Verwendung von Platzhaltern wie * in `INSERT`-Anweisungen. 
	- Es ist besser, die Spalten explizit anzugeben.
- Beachten Sie die Einschränkungen und Beziehungen zwischen Tabellen, 
	- um referenzielle Integrität zu wahren.

## Fortgeschrittene DML-Konzepte

- INSERT ... SELECT: Einfügen von Daten aus einer anderen Tabelle.
   ```sql
   INSERT INTO new_customers (customer_id, name, email)
   SELECT customer_id, CONCAT(first_name, ' ', last_name), email
   FROM customers
   WHERE customer_id > 1000;
   ```

- MERGE (oder UPSERT in einigen Datenbanksystemen): Kombination aus INSERT und UPDATE.

- Bulk Insert: Einfügen großer Datenmengen für bessere Leistung.

- Soft Delete: Verwendung eines Flags anstelle des physischen Löschens von Datensätzen.