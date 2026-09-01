## 1. DDL (Data Definition Language)

### Datendefinition - Tabellen, Datenbanken, Indizes erstellen und ändern

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Datenbank erstellen** | `CREATE DATABASE dbname;` | Nicht unterstützt (dateibasiert) |
| **Datenbank auswählen** | `USE dbname;` | Nicht erforderlich (eine DB pro Datei) |
| **Datenbank löschen** | `DROP DATABASE dbname;` | Datei löschen |
| **Tabelle erstellen** | `CREATE TABLE users (`<br>`  id INT PRIMARY KEY AUTO_INCREMENT,`<br>`  name VARCHAR(100),`<br>`  email VARCHAR(100) UNIQUE`<br>`);` | `CREATE TABLE users (`<br>`  id INTEGER PRIMARY KEY AUTOINCREMENT,`<br>`  name TEXT,`<br>`  email TEXT UNIQUE`<br>`);` |
| **Datentypen** | INT, VARCHAR, TEXT, DATE, DATETIME, DECIMAL, FLOAT, DOUBLE, BOOLEAN, BLOB | INTEGER, TEXT, REAL, BLOB<br>(flexibles Typsystem) |
| **Auto-Increment** | `AUTO_INCREMENT` | `AUTOINCREMENT` |
| **Tabelle ändern** | `ALTER TABLE users`<br>`ADD COLUMN age INT;`<br><br>`ALTER TABLE users`<br>`MODIFY COLUMN name VARCHAR(150);`<br><br>`ALTER TABLE users`<br>`DROP COLUMN age;` | `ALTER TABLE users`<br>`ADD COLUMN age INTEGER;`<br><br>MODIFY nicht direkt unterstützt<br>(Tabelle neu erstellen)<br><br>DROP COLUMN nicht direkt unterstützt<br>(Tabelle neu erstellen) |
| **Tabelle umbenennen** | `RENAME TABLE old_name TO new_name;`<br>oder<br>`ALTER TABLE old_name RENAME TO new_name;` | `ALTER TABLE old_name RENAME TO new_name;` |
| **Spalte umbenennen** | `ALTER TABLE users`<br>`RENAME COLUMN old_col TO new_col;` | `ALTER TABLE users`<br>`RENAME COLUMN old_col TO new_col;` |
| **Tabelle löschen** | `DROP TABLE users;` | `DROP TABLE users;` |
| **Tabelle leeren** | `TRUNCATE TABLE users;` | `DELETE FROM users;`<br>`VACUUM;` |
| **Index erstellen** | `CREATE INDEX idx_name ON users(name);`<br><br>`CREATE UNIQUE INDEX idx_email ON users(email);` | `CREATE INDEX idx_name ON users(name);`<br><br>`CREATE UNIQUE INDEX idx_email ON users(email);` |
| **Index löschen** | `DROP INDEX idx_name ON users;` | `DROP INDEX idx_name;` |
| **Primärschlüssel** | `PRIMARY KEY` | `PRIMARY KEY` |
| **Fremdschlüssel** | `FOREIGN KEY (user_id)`<br>`REFERENCES users(id)`<br>`ON DELETE CASCADE` | `FOREIGN KEY (user_id)`<br>`REFERENCES users(id)`<br>`ON DELETE CASCADE`<br>(muss aktiviert werden: `PRAGMA foreign_keys = ON;`) |
| **Constraints** | CHECK, NOT NULL, DEFAULT, UNIQUE | CHECK, NOT NULL, DEFAULT, UNIQUE |

---

## 2. DML (Data Manipulation Language)

### Daten einfügen, ändern und löschen

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Einzelne Zeile einfügen** | `INSERT INTO users (name, email)`<br>`VALUES ('Max', 'max@email.de');` | `INSERT INTO users (name, email)`<br>`VALUES ('Max', 'max@email.de');` |
| **Mehrere Zeilen einfügen** | `INSERT INTO users (name, email) VALUES`<br>`('Anna', 'anna@email.de'),`<br>`('Tom', 'tom@email.de');` | `INSERT INTO users (name, email) VALUES`<br>`('Anna', 'anna@email.de'),`<br>`('Tom', 'tom@email.de');` |
| **Einfügen mit Standardwerten** | `INSERT INTO users () VALUES ();`<br>(alle Spalten mit DEFAULT) | `INSERT INTO users DEFAULT VALUES;` |
| **INSERT ... SELECT** | `INSERT INTO archive_users`<br>`SELECT * FROM users WHERE active = 0;` | `INSERT INTO archive_users`<br>`SELECT * FROM users WHERE active = 0;` |
| **INSERT OR REPLACE** | `REPLACE INTO users (id, name)`<br>`VALUES (1, 'Neuer Name');`<br><br>`INSERT INTO users (id, name)`<br>`VALUES (1, 'Name')`<br>`ON DUPLICATE KEY UPDATE name = 'Name';` | `INSERT OR REPLACE INTO users (id, name)`<br>`VALUES (1, 'Neuer Name');`<br><br>`REPLACE INTO users (id, name)`<br>`VALUES (1, 'Neuer Name');` |
| **INSERT IGNORE** | `INSERT IGNORE INTO users (email)`<br>`VALUES ('max@email.de');`<br>(ignoriert Duplikate) | `INSERT OR IGNORE INTO users (email)`<br>`VALUES ('max@email.de');` |
| **Daten aktualisieren** | `UPDATE users`<br>`SET name = 'Maria', email = 'maria@email.de'`<br>`WHERE id = 1;` | `UPDATE users`<br>`SET name = 'Maria', email = 'maria@email.de'`<br>`WHERE id = 1;` |
| **Alle Zeilen aktualisieren** | `UPDATE users SET active = 1;`<br>(Vorsicht!) | `UPDATE users SET active = 1;`<br>(Vorsicht!) |
| **UPDATE mit Berechnungen** | `UPDATE products`<br>`SET price = price * 1.1`<br>`WHERE category = 'Electronics';` | `UPDATE products`<br>`SET price = price * 1.1`<br>`WHERE category = 'Electronics';` |
| **Daten löschen** | `DELETE FROM users WHERE id = 1;` | `DELETE FROM users WHERE id = 1;` |
| **Alle Zeilen löschen** | `DELETE FROM users;`<br>(langsam, mit Logging)<br><br>`TRUNCATE TABLE users;`<br>(schnell, ohne Logging) | `DELETE FROM users;`<br><br>`VACUUM;`<br>(zum Freigeben von Speicher) |
| **LIMIT bei UPDATE/DELETE** | `DELETE FROM users`<br>`ORDER BY created_at ASC`<br>`LIMIT 100;` | `DELETE FROM users`<br>`WHERE id IN (`<br>`  SELECT id FROM users`<br>`  ORDER BY created_at ASC LIMIT 100`<br>`);` |

---

## 3. DQL (Data Query Language)

### Daten abfragen

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Alle Daten abfragen** | `SELECT * FROM users;` | `SELECT * FROM users;` |
| **Bestimmte Spalten** | `SELECT name, email FROM users;` | `SELECT name, email FROM users;` |
| **WHERE-Bedingung** | `SELECT * FROM users WHERE age >= 18;` | `SELECT * FROM users WHERE age >= 18;` |
| **Vergleichsoperatoren** | `=, !=, <, >, <=, >=, <>`<br>`LIKE, NOT LIKE, IN, NOT IN`<br>`BETWEEN, IS NULL, IS NOT NULL` | `=, !=, <, >, <=, >=, <>`<br>`LIKE, NOT LIKE, IN, NOT IN`<br>`BETWEEN, IS NULL, IS NOT NULL` |
| **Logische Operatoren** | `AND, OR, NOT` | `AND, OR, NOT` |
| **LIKE Pattern** | `SELECT * FROM users`<br>`WHERE name LIKE 'M%';`<br>(`%` = beliebig viele Zeichen)<br>(`_` = genau ein Zeichen) | `SELECT * FROM users`<br>`WHERE name LIKE 'M%';`<br>(`%` = beliebig viele Zeichen)<br>(`_` = genau ein Zeichen) |
| **Case-Insensitive LIKE** | Standard case-insensitive | Case-insensitive nur für ASCII-Zeichen |
| **REGEXP** | `SELECT * FROM users`<br>`WHERE email REGEXP '^[a-z]+@';` | Nicht standardmäßig verfügbar<br>(kann per Extension hinzugefügt werden) |
| **IN-Operator** | `SELECT * FROM users`<br>`WHERE id IN (1, 2, 3);` | `SELECT * FROM users`<br>`WHERE id IN (1, 2, 3);` |
| **BETWEEN** | `SELECT * FROM products`<br>`WHERE price BETWEEN 10 AND 100;` | `SELECT * FROM products`<br>`WHERE price BETWEEN 10 AND 100;` |
| **ORDER BY** | `SELECT * FROM users`<br>`ORDER BY name ASC;`<br><br>`SELECT * FROM users`<br>`ORDER BY age DESC, name ASC;` | `SELECT * FROM users`<br>`ORDER BY name ASC;`<br><br>`SELECT * FROM users`<br>`ORDER BY age DESC, name ASC;` |
| **LIMIT und OFFSET** | `SELECT * FROM users LIMIT 10;`<br><br>`SELECT * FROM users LIMIT 10 OFFSET 20;`<br><br>`SELECT * FROM users LIMIT 20, 10;`<br>(OFFSET, COUNT - veraltet) | `SELECT * FROM users LIMIT 10;`<br><br>`SELECT * FROM users LIMIT 10 OFFSET 20;` |
| **DISTINCT** | `SELECT DISTINCT city FROM users;` | `SELECT DISTINCT city FROM users;` |
| **Aggregatfunktionen** | `COUNT(*), SUM(), AVG(), MIN(), MAX()` | `COUNT(*), SUM(), AVG(), MIN(), MAX()` |
| **GROUP BY** | `SELECT city, COUNT(*) as anzahl`<br>`FROM users`<br>`GROUP BY city;` | `SELECT city, COUNT(*) as anzahl`<br>`FROM users`<br>`GROUP BY city;` |
| **HAVING** | `SELECT city, COUNT(*) as anzahl`<br>`FROM users`<br>`GROUP BY city`<br>`HAVING anzahl > 5;` | `SELECT city, COUNT(*) as anzahl`<br>`FROM users`<br>`GROUP BY city`<br>`HAVING anzahl > 5;` |
| **INNER JOIN** | `SELECT u.name, o.order_date`<br>`FROM users u`<br>`INNER JOIN orders o ON u.id = o.user_id;` | `SELECT u.name, o.order_date`<br>`FROM users u`<br>`INNER JOIN orders o ON u.id = o.user_id;` |
| **LEFT JOIN** | `SELECT u.name, o.order_date`<br>`FROM users u`<br>`LEFT JOIN orders o ON u.id = o.user_id;` | `SELECT u.name, o.order_date`<br>`FROM users u`<br>`LEFT JOIN orders o ON u.id = o.user_id;` |
| **RIGHT JOIN** | `SELECT u.name, o.order_date`<br>`FROM users u`<br>`RIGHT JOIN orders o ON u.id = o.user_id;` | Nicht unterstützt<br>(umschreiben als LEFT JOIN) |
| **FULL OUTER JOIN** | `SELECT u.name, o.order_date`<br>`FROM users u`<br>`LEFT JOIN orders o ON u.id = o.user_id`<br>`UNION`<br>`SELECT u.name, o.order_date`<br>`FROM users u`<br>`RIGHT JOIN orders o ON u.id = o.user_id;` | Nicht direkt unterstützt<br>(über UNION simulieren) |
| **CROSS JOIN** | `SELECT * FROM table1 CROSS JOIN table2;` | `SELECT * FROM table1 CROSS JOIN table2;` |
| **Subqueries** | `SELECT * FROM users`<br>`WHERE id IN (SELECT user_id FROM orders);` | `SELECT * FROM users`<br>`WHERE id IN (SELECT user_id FROM orders);` |
| **UNION** | `SELECT name FROM users`<br>`UNION`<br>`SELECT name FROM customers;`<br>(entfernt Duplikate) | `SELECT name FROM users`<br>`UNION`<br>`SELECT name FROM customers;` |
| **UNION ALL** | `SELECT name FROM users`<br>`UNION ALL`<br>`SELECT name FROM customers;`<br>(behält Duplikate) | `SELECT name FROM users`<br>`UNION ALL`<br>`SELECT name FROM customers;` |

---

## 4. DCL (Data Control Language)

### Berechtigungen verwalten

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Benutzer erstellen** | `CREATE USER 'username'@'localhost'`<br>`IDENTIFIED BY 'password';` | Nicht unterstützt<br>(dateibasierte Berechtigungen) |
| **Berechtigungen gewähren** | `GRANT SELECT, INSERT, UPDATE`<br>`ON database.table`<br>`TO 'username'@'localhost';`<br><br>`GRANT ALL PRIVILEGES`<br>`ON database.*`<br>`TO 'username'@'localhost';` | Nicht unterstützt<br>(Zugriffsrechte über Betriebssystem) |
| **Berechtigungen entziehen** | `REVOKE SELECT, INSERT`<br>`ON database.table`<br>`FROM 'username'@'localhost';` | Nicht unterstützt |
| **Berechtigungen anzeigen** | `SHOW GRANTS FOR 'username'@'localhost';` | Nicht unterstützt |
| **Benutzer löschen** | `DROP USER 'username'@'localhost';` | Nicht unterstützt |
| **Passwort ändern** | `ALTER USER 'username'@'localhost'`<br>`IDENTIFIED BY 'new_password';`<br><br>`SET PASSWORD FOR 'username'@'localhost'`<br>`= PASSWORD('new_password');` | Nicht unterstützt |
| **Zugriffskontrolle** | Benutzer- und rollenbasiert | Dateibasiert über Betriebssystem |

**Hinweis:** SQLite ist eine eingebettete Datenbank ohne Mehrbenutzer-Unterstützung. Zugriffsrechte werden über das Dateisystem des Betriebssystems gesteuert.

---

## 5. TCL (Transaction Control Language)

### Transaktionen steuern

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Transaktion starten** | `START TRANSACTION;`<br>oder<br>`BEGIN;` | `BEGIN;`<br>oder<br>`BEGIN TRANSACTION;` |
| **Transaction Modi** | `START TRANSACTION READ ONLY;`<br>`START TRANSACTION READ WRITE;` | `BEGIN DEFERRED;`<br>`BEGIN IMMEDIATE;`<br>`BEGIN EXCLUSIVE;` |
| **Änderungen bestätigen** | `COMMIT;` | `COMMIT;` |
| **Änderungen rückgängig** | `ROLLBACK;` | `ROLLBACK;` |
| **Savepoint erstellen** | `SAVEPOINT savepoint_name;` | `SAVEPOINT savepoint_name;` |
| **Zu Savepoint zurück** | `ROLLBACK TO SAVEPOINT savepoint_name;` | `ROLLBACK TO savepoint_name;` |
| **Savepoint löschen** | `RELEASE SAVEPOINT savepoint_name;` | `RELEASE savepoint_name;` |
| **Autocommit** | `SET autocommit = 0;` (deaktivieren)<br>`SET autocommit = 1;` (aktivieren)<br>Standard: aktiviert | Immer aktiviert außerhalb expliziter Transaktionen |
| **Transaction Isolation** | `SET TRANSACTION ISOLATION LEVEL`<br>`READ UNCOMMITTED;`<br>`READ COMMITTED;`<br>`REPEATABLE READ;`<br>`SERIALIZABLE;` | Nur SERIALIZABLE<br>(höchstes Isolationslevel) |
| **Transaktionsstatus** | `SELECT @@autocommit;`<br>`SELECT @@transaction_isolation;` | Keine direkten Statusabfragen |
| **Nested Transactions** | Nicht direkt unterstützt<br>(nur Savepoints) | Nicht direkt unterstützt<br>(nur Savepoints) |

---

## Wichtige Unterschiede im Überblick

### Datentypen

**MySQL:** Strikte Typisierung mit vielen Datentypen (INT, VARCHAR, DATE, DATETIME, etc.)

**SQLite:** Dynamisches Typsystem mit nur 5 Speicherklassen (NULL, INTEGER, REAL, TEXT, BLOB)

### Performance-Optimierung

| Feature | MySQL | SQLite |
|---------|-------|--------|
| **Query-Cache** | Verfügbar (deprecated ab 8.0) | Nicht verfügbar |
| **Query-Optimizer** | Ausgereift | Vorhanden, aber einfacher |
| **Indizes** | B-Tree, Hash, Full-Text, Spatial | Nur B-Tree |
| **Explain** | `EXPLAIN` und `EXPLAIN EXTENDED` | `EXPLAIN QUERY PLAN` |

### String-Funktionen

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Konkatenation** | `CONCAT('Hello', ' ', 'World')`<br>`'Hello' + ' ' + 'World'` (ab 8.0) | `'Hello' || ' ' || 'World'` |
| **Länge** | `LENGTH(str)`, `CHAR_LENGTH(str)` | `LENGTH(str)` |
| **Groß-/Kleinschreibung** | `UPPER(str)`, `LOWER(str)` | `UPPER(str)`, `LOWER(str)` |
| **Teilstring** | `SUBSTRING(str, pos, len)` | `SUBSTR(str, pos, len)` |
| **Trimmen** | `TRIM(str)`, `LTRIM(str)`, `RTRIM(str)` | `TRIM(str)`, `LTRIM(str)`, `RTRIM(str)` |
| **Ersetzen** | `REPLACE(str, from, to)` | `REPLACE(str, from, to)` |

### Datums-Funktionen

| Funktion | MySQL | SQLite |
|----------|-------|--------|
| **Aktuelles Datum** | `CURDATE()`, `CURRENT_DATE()` | `DATE('now')` |
| **Aktuelle Zeit** | `CURTIME()`, `CURRENT_TIME()` | `TIME('now')` |
| **Datum+Zeit** | `NOW()`, `CURRENT_TIMESTAMP()` | `DATETIME('now')` |
| **Datum formatieren** | `DATE_FORMAT(date, '%Y-%m-%d')` | `STRFTIME('%Y-%m-%d', date)` |
| **Datum rechnen** | `DATE_ADD(date, INTERVAL 1 DAY)`<br>`DATE_SUB(date, INTERVAL 1 MONTH)` | `DATE(date, '+1 day')`<br>`DATE(date, '-1 month')` |

---

## Praktische Tipps

### MySQL-spezifisch
- Benötigt Server-Installation und -konfiguration
- Mehrbenutzer-Unterstützung mit Rechteverwaltung
- Besser für große Datenmengen und viele gleichzeitige Zugriffe
- Unterstützt gespeicherte Prozeduren, Trigger, Views

### SQLite-spezifisch
- Keine Installation erforderlich, eine Datei = eine Datenbank
- Ideal für Entwicklung, Embedded Systems, Mobile Apps
- PRAGMA-Befehle für Konfiguration: `PRAGMA foreign_keys = ON;`
- Alle Änderungen werden sofort in die Datei geschrieben
- VACUUM zum Komprimieren nach großen Löschvorgängen

---

**Stand:** Februar 2025  
**Lizenz:** Für Schulungszwecke
