Ein **VIEW (Sicht)** ist eine virtuelle Tabelle, die das Ergebnis einer gespeicherten SQL-Abfrage darstellt. **VIEWS** dienen als **Sicherheitsmechanismus**, indem sie Benutzern **eingeschränkten Zugriff auf bestimmte Daten** gewähren, ohne dass diese direkt auf die Originaltabellen zugreifen können.

---

## **1. Vorteile von VIEWS für die Sicherheit**

- **Einschränkung des Datenzugriffs**: Nur relevante Spalten oder Zeilen werden angezeigt  
- **Schutz sensibler Daten**: Verstecken vertraulicher Informationen  
- **Abstraktionsschicht**: Struktur der Originaltabelle bleibt verborgen  
- **Rechteverwaltung**: GRANT kann auf den VIEW anstelle der Tabelle angewendet werden

## **2. Beispiel: Einrichtung einer Datenbank mit VIEWS zur Zugriffskontrolle**

### **Tabellendefinition**

Wir erstellen eine Tabelle **mitarbeiter**, die sensible Daten wie **Gehälter** enthält.

```sql
CREATE DATABASE firma;
USE firma;

CREATE TABLE mitarbeiter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    abteilung VARCHAR(50),
    gehalt DECIMAL(10,2)
);
```

### **Daten einfügen**

```sql
INSERT INTO mitarbeiter (name, abteilung, gehalt) VALUES
('Alice Meier', 'IT', 5500.00),
('Bob Schmidt', 'Buchhaltung', 4800.00),
('Clara Fischer', 'Marketing', 4200.00);
```
## **3. View zur Zugriffskontrolle erstellen**

### **Szenario:**

Wir möchten, dass **Mitarbeiter nur die Namen und Abteilungen sehen**, aber **keine Gehälter** einsehen können.

```sql
CREATE VIEW mitarbeiter_view AS 
SELECT name, abteilung FROM mitarbeiter;
```
## **4. Rechte nur für den VIEW vergeben**

Nun erlauben wir einem Benutzer (`user1`), nur auf den **VIEW**, nicht aber auf die Originaltabelle zuzugreifen.

```sql
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'passwort123';

GRANT SELECT ON firma.mitarbeiter_view TO 'user1'@'localhost';
```

`user1` kann jetzt **die Sicht nutzen**, aber hat **keinen Zugriff auf `mitarbeiter` direkt**.
## **5. Test mit `user1`**

Als `user1` angemeldet, versuchen wir:

```sql
SELECT * FROM mitarbeiter_view;
```

 Ausgabe:

| name          | abteilung   |     |
| ------------- | ----------- | --- |
| Alice Meier   | IT          |     |
| Bob Schmidt   | Buchhaltung |     |
| Clara Fischer | Marketing   |     |


Wenn `user1` versucht, direkt auf `mitarbeiter` zuzugreifen:

```sql
SELECT * FROM mitarbeiter;
```

**Fehlermeldung:**

```
ERROR 1142 (42000): SELECT command denied to user 'user1' for table 'mitarbeiter'
```

## **6. Erweiterte Zugriffskontrolle mit Views**

### **1. Filterung nach Abteilung**

Ein View für die **IT-Abteilung**, damit nur Mitarbeiter der IT-Abteilung sichtbar sind:

```sql
CREATE VIEW it_mitarbeiter AS 
SELECT name FROM mitarbeiter WHERE abteilung = 'IT';
```
### **2. Nur bestimmte Spalten bearbeiten**

Wenn ein Benutzer `user2` nur das **Feld `abteilung` ändern**, aber nicht andere Spalten sehen soll:

```sql
CREATE VIEW update_abteilung AS 
SELECT id, abteilung FROM mitarbeiter;

GRANT UPDATE (abteilung) ON update_abteilung TO 'user2'@'localhost';
```

`user2` kann nur die Abteilung ändern, aber **keine Namen oder Gehälter sehen**.
## **7. Fazit**

**VIEWS ermöglichen eine feingranulare Zugriffskontrolle**, indem sie nur ausgewählte Daten anzeigen.  
**Benutzer können auf VIEWS beschränkt werden**, ohne Zugriff auf die Originaltabellen zu erhalten.  
**Sicherheitsvorteil**: Keine direkten Manipulationen an der Originaltabelle möglich.

Durch den gezielten Einsatz von **VIEWS** und **GRANT/REVOKE** lässt sich der **Datenzugriff sicher und flexibel steuern**.