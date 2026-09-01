
```sql
---Aufgabe1
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2)
);

---Aufgabe2
ALTER TABLE Employees
ADD department VARCHAR(50);

---Aufgabe3
---SQLite
CREATE TABLE Employees_new (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(12, 2),  -- Geänderter Datentyp
    department VARCHAR(50)

);

INSERT INTO Employees_new (
  employee_id, 
  first_name, 
  last_name, 
  email, 
  hire_date, 
  salary, 
  department
)
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  email, 
  hire_date, 
  salary, 
  department
FROM Employees;

DROP TABLE Employees;

ALTER TABLE Employees_new RENAME TO Employees;

---Aufgabe4
CREATE INDEX idx_last_name
ON Employees (last_name);

---Aufgabe5
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);

---Aufgabe6
ALTER TABLE Employees
ADD department_id INT;
PRAGMA foreign_keys = ON;

CREATE TABLE Employees_new (
    employee_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    hire_date DATE,
    salary DECIMAL(12, 2),
    department VARCHAR(50),
    department_id INTEGER,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Employees_new (employee_id, first_name, last_name, email, hire_date, salary, department, department_id)

SELECT employee_id, first_name, last_name, email, hire_date, salary, department, department_id FROM Employees;

DROP TABLE Employees;

ALTER TABLE Employees_new RENAME TO Employees;

---Aufgabe7
DROP INDEX IF EXISTS idx_last_name;

---Aufgabe8
CREATE INDEX idx_last_first_name
ON Employees (last_name, first_name);

---Aufgabe9
ALTER TABLE Employees
DROP COLUMN department; hat Kontextmenü

```
