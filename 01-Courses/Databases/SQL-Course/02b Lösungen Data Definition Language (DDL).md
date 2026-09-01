## 1. Erstellen der Tabelle "Employees"

```sql
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2)
);
```

- Dieser Befehl erstellt die Tabelle "Employees" mit den spezifizierten Spalten. 
- Der `employee_id` wird als Primärschlüssel festgelegt.

## 2. Hinzufügen einer neuen Spalte "department"

```sql
ALTER TABLE Employees
ADD department VARCHAR(50);
```

- Dieser Befehl fügt die neue Spalte "department" zur bestehenden Tabelle "Employees" hinzu.

## 3. Ändern des Datentyps der Spalte "salary"

```sql
ALTER TABLE Employees
MODIFY COLUMN salary DECIMAL(12,2);
```

- Hier wird der Datentyp der Spalte "salary" von DECIMAL(10,2) zu DECIMAL(12,2) geändert, um eine höhere Präzision zu ermöglichen.

## 4. Erstellen eines Indexes auf der Spalte "last_name"

```sql
CREATE INDEX idx_last_name
ON Employees (last_name);
```

- Dieser Befehl erstellt einen Index auf der Spalte "last_name", was Abfragen beschleunigen kann, die nach dem Nachnamen suchen.

## 5. Erstellen der Tabelle "Departments"

```sql
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);
```

- Hier wird die Tabelle "Departments" erstellt. 
- Beachten Sie den Fremdschlüssel `manager_id`, der auf die `employee_id` in der Tabelle "Employees" verweist.

## 6. Hinzufügen einer Fremdschlüssel-Beziehung zur Tabelle "Employees"

```sql
ALTER TABLE Employees
ADD department_id INT;
ALTER TABLE Employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department) REFERENCES Departments(department_id);
```

- Dieser Befehl fügt eine Fremdschlüssel-Beziehung zwischen der Spalte "department" in "Employees" und der Spalte "department_id" in "Departments" hinzu.

## 7. Löschen des Indexes auf der Spalte "last_name"

```sql
DROP INDEX idx_last_name ON Employees;
```

- Hier wird der zuvor erstellte Index auf der Spalte "last_name" entfernt.

## 8. Erstellen eines zusammengesetzten Indexes

```sql
CREATE INDEX idx_last_first_name
ON Employees (last_name, first_name);
```

- Dieser Befehl erstellt einen zusammengesetzten Index auf den Spalten "last_name" und "first_name", was Abfragen optimieren kann, die beide Spalten verwenden.

## 9. Löschen der Tabelle "Departments"

```sql
DROP TABLE Departments;
```

- Dieser letzte Befehl löscht die Tabelle "Departments" vollständig aus der Datenbank.