Die Befehle **`GRANT`** und **`REVOKE`** sind essenzielle Werkzeuge zur Steuerung des Zugriffs auf Datenbanken, Tabellen und andere Objekte in MariaDB.

## **1. `GRANT` – Berechtigungen erteilen**

Der **`GRANT`-Befehl** wird verwendet, um einem Benutzer spezifische Berechtigungen auf eine Datenbank, eine Tabelle oder eine bestimmte Spalte zu erteilen.

### **Syntax:**

```sql
GRANT <Berechtigung(en)> ON <Datenbank>.<Tabelle> TO '<Benutzer>'@'<Host>';
```

### **Beispiele:**

#### **1.1. Zugriff auf eine gesamte Datenbank gewähren**

```sql
GRANT ALL PRIVILEGES ON shopdb.* TO 'shopadmin'@'localhost';
```

➡ Der Benutzer `shopadmin` hat nun **volle Kontrolle** (`ALL PRIVILEGES`) über die gesamte **Datenbank `shopdb`**.

#### **1.2. Nur Leserechte auf eine Tabelle gewähren**

```sql
GRANT SELECT ON shopdb.kunden TO 'mitarbeiter'@'%';
```

➡ Der Benutzer `mitarbeiter` kann nun **Daten aus der Tabelle `kunden` lesen**, aber keine Änderungen vornehmen.

#### **1.3. Schreibrechte auf eine Tabelle erteilen**

```sql
GRANT INSERT, UPDATE, DELETE ON shopdb.bestellungen TO 'lager'@'192.168.1.%';
```

➡ Der Benutzer `lager` kann von **jedem Rechner im Netzwerk** (`192.168.1.%`) Bestellungen **einfügen, ändern und löschen**.

#### **1.4. Rechte auf eine bestimmte Spalte einschränken**

```sql
GRANT SELECT (name, preis) ON shopdb.produkte TO 'kunde'@'%';
```

➡ Der Benutzer `kunde` darf nur die **Spalten `name` und `preis`** der Tabelle `produkte` einsehen.

#### **1.5. Erlauben, Berechtigungen weiterzugeben (`GRANT OPTION`)**

```sql
GRANT SELECT, INSERT ON shopdb.* TO 'manager'@'localhost' WITH GRANT OPTION;
```

➡ Der Benutzer `manager` kann die ihm gewährten **SELECT- und INSERT-Rechte** an andere Benutzer weitergeben.
## **2. `REVOKE` – Berechtigungen entziehen**

Der **`REVOKE`-Befehl** entfernt zuvor vergebene Berechtigungen von einem Benutzer.
### **Syntax:**
```sql
REVOKE <Berechtigung(en)> ON <Datenbank>.<Tabelle> FROM '<Benutzer>'@'<Host>';
```
### **Beispiele:**

#### **2.1. Lese- und Schreibrechte von einer Tabelle entfernen**

```sql
REVOKE SELECT, INSERT, UPDATE ON shopdb.kunden FROM 'mitarbeiter'@'%';
```

➡ Der Benutzer `mitarbeiter` kann **nicht mehr** auf die Tabelle `kunden` zugreifen.

#### **2.2. Alle Rechte auf eine Datenbank entziehen**

```sql
REVOKE ALL PRIVILEGES ON shopdb.* FROM 'shopadmin'@'localhost';
```

➡ `shopadmin` hat **keinen Zugriff mehr** auf die Datenbank `shopdb`.

#### **2.3. Entzug der Berechtigung, Rechte weiterzugeben**

```sql
REVOKE GRANT OPTION ON shopdb.* FROM 'manager'@'localhost';
```

➡ `manager` kann **keine Rechte mehr an andere Benutzer weitergeben**.

## **3. Auswirkungen von `REVOKE`**

- **Sofortige Wirkung**: Sobald eine Berechtigung entzogen wird, kann der betroffene Benutzer die entsprechende Aktion nicht mehr ausführen.
- **Aktive Sitzungen**: Ein Benutzer, der gerade eine Abfrage ausführt, kann betroffen sein, sobald `REVOKE` angewendet wurde.
- **Indirekte Auswirkungen**: Wenn Berechtigungen über Rollen oder `GRANT OPTION` vergeben wurden, kann `REVOKE` auch andere Benutzer betreffen.
- **Kein automatisches Löschen von Objekten**: Falls ein Benutzer Tabellen oder Views erstellt hat, bleiben diese auch nach dem Entzug seiner Rechte bestehen.

**Zusammenfassung:**

- **`GRANT`** ermöglicht es, Benutzern **gezielte Zugriffsrechte** auf Datenbanken und Tabellen zu erteilen.
- **`REVOKE`** entzieht zuvor vergebene Rechte, wodurch Benutzer keine Aktionen mehr ausführen können.
- Die **richtige Nutzung** von `GRANT` und `REVOKE` hilft dabei, **Datensicherheit** und **minimale Berechtigungsvergabe** sicherzustellen.