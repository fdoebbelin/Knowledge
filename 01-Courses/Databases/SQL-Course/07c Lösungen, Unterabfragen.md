## 1. Unterabfragen in WHERE-Klauseln

Aufgabe: Finden Sie alle Mitarbeiter, deren Gehalt über dem Durchschnittsgehalt liegt.

```sql
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

Diese Abfrage wird Diana und Eve zurückgeben, da ihre Gehälter über dem Durchschnitt von 70.000 liegen.

## 2. Unterabfragen in FROM-Klauseln

Aufgabe: Erstellen Sie eine Liste der Städte und ihrer durchschnittlichen Bestellsumme, aber nur für Städte, deren Durchschnittsbestellsumme über 1000 liegt.

```sql
SELECT city, avg_order_amount
FROM (
    SELECT c.city, AVG(o.total_amount) as avg_order_amount
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.city
) AS city_averages
WHERE avg_order_amount > 1000;
```

Diese Abfrage wird New York, Los Angeles, Chicago und Phoenix zurückgeben, da ihre durchschnittlichen Bestellsummen über 1000 liegen.

## 3. Korrelierte Unterabfragen

Aufgabe: Finden Sie alle Mitarbeiter, die mehr verdienen als der Durchschnitt in ihrer Abteilung.

```sql
SELECT name, department, salary
FROM employees e1
WHERE salary >= (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department = e1.department
);
```

Diese Abfrage wird Charlie aus der IT-Abteilung und Eve aus der Finanzabteilung zurückgeben, da sie mehr als der Durchschnitt in ihren jeweiligen Abteilungen verdienen.