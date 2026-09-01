In Microsoft Word können Sie innerhalb der Formelfunktion in Tabellen ähnlich wie in Excel Feldbezüge verwenden, jedoch sind die Möglichkeiten und Funktionen in Word deutlich begrenzter als in Excel. In Word sind die Formeln hauptsächlich auf die Verarbeitung und Berechnung von Daten innerhalb von Tabellen beschränkt.

### Verwendung von Feldbezügen in Word-Tabellenformeln

1. **Einfügen einer Tabelle**: Beginnen Sie mit dem Einfügen einer Tabelle in Ihr Dokument, indem Sie auf „Einfügen“ > „Tabelle“ klicken und die gewünschte Größe der Tabelle auswählen.

2. **Eingabe von Daten**: Füllen Sie die Tabelle mit Daten, die Sie in Ihren Berechnungen verwenden möchten.

3. **Formel einfügen**:
   - Klicken Sie in die Zelle, in der Sie die Formel anzeigen möchten.
   - Gehen Sie zur Registerkarte „Layout“ unter „Tabellentools“.
   - Klicken Sie im Bereich „Daten“ auf „Formel“.

4. **Verwenden von Feldbezügen**:
   - In dem sich öffnenden Dialogfenster „Formel“ können Sie Ihre Berechnung eingeben.
   - Für Feldbezüge innerhalb der Tabelle verwenden Sie `ABOVE`, `BELOW`, `LEFT`, oder `RIGHT` um Werte aus Zellen oberhalb, unterhalb, links oder rechts von der Formelzelle zu referenzieren. Diese Schlüsselwörter beziehen sich auf alle Zellen in der entsprechenden Richtung in derselben Spalte oder Zeile bis zum ersten leeren Feld oder Ende des Bereiches.
   - Beispiel: Um die Summe aller Zahlen oberhalb der aktuellen Zelle zu berechnen, könnten Sie die Formel `=SUM(ABOVE)` eingeben.

1. **Formeloptionen anpassen**:
   - Word bietet auch die Möglichkeit, bestimmte Zellen direkt zu referenzieren, indem Sie die Zelle wie in Excel mit dem Spaltenbuchstaben und der Zeilennummer ansprechen:

```
=SUM(D1;D2;D3;D4)
oder
=SUM(D1:D4)
```

6. **Formel bestätigen**:
   - Klicken Sie auf „OK“, um die Formel zu bestätigen und die Berechnung in der Zelle durchzuführen.

### Einschränkungen und Unterschiede zu Excel
- **Komplexität**: Word-Formeln sind nicht so mächtig und flexibel wie Excel-Formeln. Sie sind hauptsächlich darauf ausgelegt, einfache Berechnungen wie Summen, Durchschnitte oder Produkte durchzuführen.
- **Dynamik**: Änderungen in den Zellwerten aktualisieren nicht automatisch die Ergebnisse von Formeln. Sie müssen die Formeln manuell aktualisieren, indem Sie die Zelle mit der Formel auswählen und `F9` drücken.
- **Funktionen**: Die Anzahl der verfügbaren Funktionen in Word ist begrenzt im Vergleich zu Excel.

Obwohl Word einige grundlegende tabellenbasierte Berechnungen ermöglicht, empfiehlt es sich, für umfangreiche und komplexe Datenanalysen oder Berechnungen Excel zu verwenden, da es hierfür speziell ausgelegt ist.