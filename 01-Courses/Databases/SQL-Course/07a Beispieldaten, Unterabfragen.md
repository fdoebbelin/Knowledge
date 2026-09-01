## Tabellendeklarationen

```sql
-- Employees Tabelle
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Customers Tabelle
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

-- Orders Tabelle
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Products Tabelle
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Order_Items Tabelle
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Departments Tabelle
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(50),
    budget DECIMAL(12, 2)
);
```
## Beispieldaten

```sql
-- Tabelle employees
INSERT INTO employees (employee_id, name, department, salary) VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'IT', 60000),
(3, 'Charlie', 'IT', 70000),
(4, 'Diana', 'Finance', 80000),
(5, 'Eve', 'Finance', 90000);

-- Tabelle customers
INSERT INTO customers (customer_id, name, city) VALUES
(1, 'John Doe', 'New York'),
(2, 'Jane Smith', 'Los Angeles'),
(3, 'Emily Davis', 'Chicago'),
(4, 'Michael Brown', 'Houston'),
(5, 'Sarah Wilson', 'Phoenix');

-- Tabelle orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2025-01-01', 1500),
(2, 2, '2025-01-02', 2000),
(3, 3, '2025-01-03', 1200),
(4, 4, '2025-01-04', 800),
(5, 5, '2025-01-05', 3000);

-- Tabelle products
INSERT INTO products (product_id, name, price) VALUES
(1, 'Laptop', 1000),
(2, 'Smartphone', 800),
(3, 'Tablet', 600),
(4, 'Monitor', 300),
(5, 'Keyboard', 50);

-- Tabelle order_items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(3, 4, 1),
(4, 5, 10);

-- Tabelle departments
INSERT INTO departments (department_id, name, budget) VALUES
(1, 'HR', 100000),
(2, 'IT', 200000),
(3, 'Finance', 150000),
(4, 'Marketing', 120000);
```