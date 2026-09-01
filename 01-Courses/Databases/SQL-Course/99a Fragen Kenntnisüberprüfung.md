### **Modul 1: Einführung in SQL und Überblick der Befehlsgruppen**

**1. Welche der folgenden Aussagen zur Geschichte von SQL ist korrekt?**  
a) SQL wurde 1970 von Microsoft entwickelt  
b) SQL ist eine standardisierte Sprache für relationale Datenbanken  
c) SQL kann nur in MySQL verwendet werden  
d) SQL ist eine Programmiersprache wie Python oder Java  
**Antwort:** b

**2. Welcher SQL-Dialekt wird hauptsächlich von Microsoft-Datenbanken wie SQL Server verwendet?**  
a) MySQL  
b) PostgreSQL  
c) T-SQL  
d) PL/SQL  
**Antwort:** c

**3. Welche der folgenden Befehle gehört zur Data Definition Language (DDL)?**  
a) INSERT  
b) CREATE  
c) SELECT  
d) UPDATE  
**Antwort:** b

**4. Was ist der Zweck der Data Manipulation Language (DML)?**  
a) Festlegen der Benutzerrechte  
b) Definieren der Datenbankstruktur  
c) Verwalten und Manipulieren von Daten in Tabellen  
d) Erstellen von gespeicherten Prozeduren  
**Antwort:** c

---

### **Modul 2: Data Definition Language (DDL)**

**5. Was bewirkt der Befehl `DROP TABLE kunden`?**  
a) Löscht alle Daten in der Tabelle `kunden`, aber nicht die Tabelle selbst  
b) Löscht die Tabelle `kunden` vollständig aus der Datenbank  
c) Löscht die Datenbank, in der die Tabelle `kunden` existiert  
d) Setzt alle Daten in `kunden` auf NULL  
**Antwort:** b

**6. Wie kann eine bestehende Tabelle geändert werden, um eine neue Spalte hinzuzufügen?**  
a) MODIFY TABLE  
b) ALTER TABLE  
c) UPDATE TABLE  
d) CHANGE TABLE  
**Antwort:** b

---

### **Modul 3: Data Manipulation Language (DML)**

**7. Welche SQL-Anweisung fügt eine neue Zeile in eine Tabelle ein?**  
a) ADD  
b) INSERT  
c) UPDATE  
d) APPEND  
**Antwort:** b

**8. Welche Bedingung wird benötigt, um sicherzustellen, dass nur bestimmte Zeilen mit `DELETE` gelöscht werden?**  
a) LIMIT  
b) ORDER BY  
c) WHERE  
d) GROUP BY  
**Antwort:** c

---

### **Modul 4: SELECT-Anweisungen Grundlagen**

**9. Was ist die Funktion des `DISTINCT`-Schlüsselworts?**  
a) Gruppiert Zeilen basierend auf bestimmten Bedingungen  
b) Entfernt doppelte Werte aus einer Spalte in den Ergebnissen  
c) Sortiert die Ergebnisse aufsteigend  
d) Wandelt alle Zeichen in Großbuchstaben um  
**Antwort:** b

**10. Wie kann man sicherstellen, dass die Ergebnisse in absteigender Reihenfolge sortiert werden?**  
a) ORDER BY ASC  
b) ORDER BY DESC  
c) SORT DESC  
d) GROUP BY DESC  
**Antwort:** b

---

### **Modul 5: Aggregatfunktionen und Gruppierung**

**11. Welche der folgenden Funktionen wird verwendet, um die Anzahl der Zeilen in einer Tabelle zu berechnen?**  
a) SUM()  
b) COUNT()  
c) AVG()  
d) MAX()  
**Antwort:** b

**12. Was ist der Unterschied zwischen `GROUP BY` und `HAVING`?**  
a) `GROUP BY` filtert Zeilen, `HAVING` filtert Gruppen  
b) `HAVING` filtert Zeilen, `GROUP BY` filtert Gruppen  
c) `GROUP BY` sortiert Daten, `HAVING` entfernt Duplikate  
d) `HAVING` ist nur mit `DISTINCT` nutzbar  
**Antwort:** a

---

### **Modul 6: Joins**

**13. Welche Art von JOIN gibt nur übereinstimmende Zeilen aus beiden Tabellen zurück?**  
a) INNER JOIN  
b) LEFT JOIN  
c) RIGHT JOIN  
d) FULL OUTER JOIN  
**Antwort:** a

**14. Welche Aussage über einen CROSS JOIN ist korrekt?**  
a) Erstellt eine Verknüpfung basierend auf einem Fremdschlüssel  
b) Gibt das kartesische Produkt der beiden Tabellen zurück  
c) Gibt nur Datensätze zurück, die in beiden Tabellen vorkommen  
d) Erfordert eine `ON`-Bedingung  
**Antwort:** b

---

### **Modul 7: Unterabfragen**

**15. Welche der folgenden Schlüsselwörter wird verwendet, um zu überprüfen, ob eine Unterabfrage Ergebnisse liefert?**  
a) CHECK  
b) EXISTS  
c) COUNT  
d) UNIQUE  
**Antwort:** b

**16. Welche Art von Unterabfrage wird innerhalb der `FROM`-Klausel verwendet?**  
a) Skalare Unterabfrage  
b) Korrelierte Unterabfrage  
c) Inline-View  
d) WHERE-Unterabfrage  
**Antwort:** c

---

### **Modul 8: Data Control Language (DCL)**

**17. Welche der folgenden Aussagen über `GRANT` ist korrekt?**  
a) `GRANT` wird verwendet, um Daten zu manipulieren  
b) `GRANT` gibt einem Benutzer spezifische Berechtigungen  
c) `GRANT` wird verwendet, um Tabellen zu erstellen  
d) `GRANT` löscht eine Datenbank  
**Antwort:** b

**18. Welcher Befehl wird verwendet, um Berechtigungen zu entziehen?**  
a) DENY  
b) REVOKE  
c) REMOVE  
d) DROP  
**Antwort:** b

**19. Warum sind VIEWS nützlich in SQL?**  
a) Sie erhöhen die Geschwindigkeit von DML-Operationen  
b) Sie schützen sensible Daten, indem sie nur relevante Spalten anzeigen  
c) Sie erlauben das dauerhafte Speichern von Abfrageergebnissen  
d) Sie ersetzen normale Tabellen in einer Datenbank  
**Antwort:** b

**20. Welche der folgenden Berechtigungen kann mit `GRANT` vergeben werden?**  
a) SELECT, INSERT, UPDATE, DELETE  
b) ALTER, CREATE, DROP  
c) ALL PRIVILEGES  
d) Alle oben genannten  
**Antwort:** d