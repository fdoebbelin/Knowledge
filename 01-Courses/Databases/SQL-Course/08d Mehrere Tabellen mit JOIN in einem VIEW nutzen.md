Wir erstellen ein Beispiel mit **Mitarbeiter**, **Abteilungen** und **Projekte**, um zu zeigen, wie ein VIEW mit einem **JOIN** verwendet werden kann.

## **1. Datenbank- und Tabellenerstellung**

### **Tabelle: mitarbeiter**

```sql
CREATE DATABASE firma;
USE firma;

CREATE TABLE mitarbeiter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    abteilung_id INT,
    email VARCHAR(100),
    gehalt DECIMAL(10,2)
);
```

### **Tabelle: abteilungen**

```sql
CREATE TABLE abteilungen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    standort VARCHAR(50)
);
```

### **Tabelle: projekte**

```sql
CREATE TABLE projekte (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    mitarbeiter_id INT,
    status ENUM('In Arbeit', 'Abgeschlossen', 'Geplant'),
    FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(id)
);
```

---

## **2. Beispiel-Daten einfügen**

### **Daten für `abteilungen`**

```sql
INSERT INTO abteilungen (name, standort) VALUES
('IT', 'Berlin'),
('Marketing', 'München'),
('Buchhaltung', 'Hamburg');
```

### **Daten für `mitarbeiter`**

```sql
INSERT INTO mitarbeiter (name, abteilung_id, email, gehalt) VALUES
('Alice Meier', 1, 'alice@firma.de', 5500.00),
('Bob Schmidt', 2, 'bob@firma.de', 4800.00),
('Clara Fischer', 3, 'clara@firma.de', 4200.00);
```
### **Daten für `projekte`**

```sql
INSERT INTO projekte (name, mitarbeiter_id, status) VALUES
('Website-Redesign', 1, 'In Arbeit'),
('SEO-Kampagne', 2, 'Abgeschlossen'),
('Finanzanalyse 2024', 3, 'Geplant');
```
## **3. VIEW mit JOIN für Benutzerzugriff erstellen**

### **Beispiel 1: Mitarbeiter mit Abteilungsnamen anzeigen (INNER JOIN)**

```sql
CREATE VIEW mitarbeiter_abteilung AS 
SELECT 
    m.name AS mitarbeiter_name, 
    a.name AS abteilung, 
    a.standort 
FROM mitarbeiter m
JOIN abteilungen a ON m.abteilung_id = a.id;
```

**Ergebnis:**

```
+------------------+------------+----------+
| mitarbeiter_name | abteilung  | standort |
+------------------+------------+----------+
| Alice Meier      | IT         | Berlin   |
| Bob Schmidt      | Marketing  | München  |
| Clara Fischer    | Buchhaltung| Hamburg  |
+------------------+------------+----------+
```

---

### **Beispiel 2: Projekte mit verantwortlichen Mitarbeitern anzeigen**

```sql
CREATE VIEW projekte_mitarbeiter AS 
SELECT 
    p.name AS projekt_name, 
    m.name AS mitarbeiter_name, 
    m.email, 
    p.status 
FROM projekte p
JOIN mitarbeiter m ON p.mitarbeiter_id = m.id;
```

**Ergebnis:**

```
+--------------------+------------------+------------------+---------------+
| projekt_name       | mitarbeiter_name | email            | status        |
+--------------------+------------------+------------------+---------------+
| Website-Redesign   | Alice Meier      | alice@firma.de   | In Arbeit     |
| SEO-Kampagne       | Bob Schmidt      | bob@firma.de     | Abgeschlossen |
| Finanzanalyse 2024 | Clara Fischer    | clara@firma.de   | Geplant       |
+--------------------+------------------+------------------+---------------+
```

## **5. Berechtigungen für Benutzer setzen**

Damit ein Benutzer `user1` nur auf den **View** zugreifen kann, nicht aber auf die Originaltabellen:

```sql
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'passwort123';

GRANT SELECT ON firma.mitarbeiter_abteilung TO 'user1'@'localhost';
GRANT SELECT ON firma.projekte_mitarbeiter TO 'user1'@'localhost';
```

➡ `user1` kann jetzt nur die Daten aus den Views abrufen, aber keine direkten Änderungen an den Originaltabellen vornehmen.

## **6. Fazit**

✅ **VIEWS mit JOINS ermöglichen eine gezielte Datenfreigabe aus mehreren Tabellen**  
✅ **Benutzer können nur die relevanten Informationen sehen, ohne Zugriff auf die Originaltabellen zu erhalten**  
✅ **Ideal zur Steuerung des Datenzugriffs in Multi-User-Datenbanken**

Mit **GRANT/REVOKE** kann der Zugriff auf diese Views genau geregelt werden, um **Datensicherheit** zu gewährleisten.