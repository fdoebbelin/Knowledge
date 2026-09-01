Angenommen, wir haben drei Tabellen in einer **Mitarbeiter-Datenbank**:

1. **Mitarbeiter (employees)**
    
    - `id` (Primärschlüssel)
    - `name` (Name des Mitarbeiters)
    - `abteilungs_id` (Fremdschlüssel, verweist auf `id` in **Abteilungen**)
2. **Abteilungen (departments)**
    
    - `id` (Primärschlüssel)
    - `abteilungsname` (Name der Abteilung)
    - `leiter_id` (Fremdschlüssel, verweist auf `id` in **Mitarbeiter**)
3. **Gehälter (salaries)**
    
    - `id` (Primärschlüssel)
    - `mitarbeiter_id` (Fremdschlüssel, verweist auf `id` in **Mitarbeiter**)
    - `gehalt` (Monatsgehalt des Mitarbeiters)

## Welches Ziel hat die Abfrage?
```sql
SELECT 
    e.name AS mitarbeiter_name,
    d.abteilungsname,
    l.name AS abteilungsleiter,
    s.gehalt
FROM employees e
JOIN departments d ON e.abteilungs_id = d.id
JOIN employees l ON d.leiter_id = l.id
JOIN salaries s ON e.id = s.mitarbeiter_id
WHERE s.gehalt > 3000;
```

---

- Zeige den Namen des Mitarbeiters, den Abteilungsnamen, den Namen des Abteilungsleiters und das Gehalt an.
- Nur Mitarbeiter mit einem Gehalt über **3000** sollen berücksichtigt werden.

---

### **SQL-Abfrage mit mehreren JOINs**

### **Erklärung der JOINs:**

4. `JOIN departments d ON e.abteilungs_id = d.id`  
    → Verknüpft **Mitarbeiter** mit ihrer Abteilung.
    
5. `JOIN employees l ON d.leiter_id = l.id`  
    → Holt den Namen des **Abteilungsleiters** durch einen **Self-Join** auf der `employees`-Tabelle.
    
6. `JOIN salaries s ON e.id = s.mitarbeiter_id`  
    → Verknüpft die **Gehälter** der Mitarbeiter.
    
7. `WHERE s.gehalt > 3000`  
    → Filtert nur Mitarbeiter mit einem Gehalt von mehr als **3000**.

### **Erwartete Ausgabe (Beispiel)**

| mitarbeiter_name | abteilungsname | abteilungsleiter | gehalt |
| ---------------- | -------------- | ---------------- | ------ |
| Alice            | IT             | Bob              | 4500   |
| Charlie          | HR             | David            | 3500   |
| Eve              | Sales          | Frank            | 5000   |
|                  |                |                  |        |
