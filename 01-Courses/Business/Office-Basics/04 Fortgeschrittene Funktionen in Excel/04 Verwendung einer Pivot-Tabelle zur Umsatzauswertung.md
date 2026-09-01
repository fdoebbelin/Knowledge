## Ausgangsdaten
Erstellen Sie eine Tabelle mit den folgenden Daten:

| Monat     | Region   | Produkt     | Umsatz |
|-----------|----------|-------------|--------|
| Januar    | Nord     | Produkt A   | 5000   |
| Januar    | Süd      | Produkt B   | 3000   |
| Februar   | Nord     | Produkt A   | 7000   |
| Februar   | Süd      | Produkt B   | 4000   |
| März      | Nord     | Produkt A   | 6000   |
| März      | Süd      | Produkt B   | 5000   |

#### Schritt 1: Datenbereich auswählen
1. **Öffnen Sie Excel und geben Sie die obigen Daten in ein neues Arbeitsblatt ein.**
2. **Markieren Sie den gesamten Datenbereich (A1:D7).**

#### Schritt 2: Pivot-Tabelle erstellen
1. **Gehen Sie zur Registerkarte „Einfügen“.**
2. **Klicken Sie auf „PivotTable“ in der Gruppe „Tabellen“.**
3. **Im Dialogfeld „PivotTable erstellen“:**
   - Stellen Sie sicher, dass der markierte Bereich korrekt ist.
   - Wählen Sie „Neues Arbeitsblatt“, um die Pivot-Tabelle in einem neuen Arbeitsblatt zu erstellen.
   - Klicken Sie auf „OK“.

#### Schritt 3: Felder in die Pivot-Tabelle ziehen
1. **Im rechten Bereich des neuen Arbeitsblatts sehen Sie den „PivotTable-Felder“ Bereich.**
2. **Ziehen Sie die Felder wie folgt:**
   - **„Monat“** in den Bereich „Zeilen“.
   - **„Region“** in den Bereich „Spalten“.
   - **„Umsatz“** in den Bereich „Werte“.

## Analyse der Pivot-Tabelle
1. **Die Pivot-Tabelle zeigt jetzt eine Zusammenfassung der Umsätze nach Monat und Region.**
2. **Sie können die Daten weiter analysieren, indem Sie zusätzliche Felder hinzufügen oder entfernen, oder die Darstellung ändern.**

#### Schritt 4: Pivot-Tabelle formatieren
1. **Klicken Sie irgendwo in die Pivot-Tabelle, um die „PivotTable-Tools“ anzuzeigen.**
2. **Gehen Sie zur Registerkarte „Entwurf“.**
3. **Wählen Sie einen PivotTable-Stil aus der Galerie „PivotTable-Designs“ aus, um das Layout und die Farben anzupassen.**

### Erweiterte Optionen
#### Pivot-Tabellenfilter anwenden
1. **Ziehen Sie das Feld „Produkt“ in den Bereich „Filter“.**
2. **Ein Dropdown-Menü erscheint über der Pivot-Tabelle.**
3. **Wählen Sie ein Produkt aus dem Dropdown-Menü aus, um die Daten für dieses Produkt zu filtern.**

#### Werte anzeigen als
1. **Klicken Sie in die Pivot-Tabelle auf einen der Umsatzwerte.**
2. **Klicken Sie mit der rechten Maustaste und wählen Sie „Wertfeldeinstellungen“.**
3. **Gehen Sie zur Registerkarte „Werte anzeigen als“.**
4. **Wählen Sie „% des Spaltensummes“, um die Umsatzwerte als Prozentsatz der Gesamtsumme der Spalte anzuzeigen.**
5. **Klicken Sie auf „OK“.**

### Beispiel Pivot-Tabelle nach Abschluss der obigen Schritte:

| Monat  | Nord   | Süd    | Gesamter Umsatz |
|--------|--------|--------|-----------------|
| Januar | 5000   | 3000   | 8000            |
| Februar| 7000   | 4000   | 11000           |
| März   | 6000   | 5000   | 11000           |
| Gesamtsumme | 18000 | 12000 | 30000         |

#### Schritt 5: Pivot-Tabelle aktualisieren
1. **Wenn sich Ihre Ausgangsdaten ändern, können Sie die Pivot-Tabelle aktualisieren, um die neuesten Daten anzuzeigen:**
   - Klicken Sie in die Pivot-Tabelle.
   - Gehen Sie zur Registerkarte „PivotTable-Analyse“ (früher „Analysieren“ genannt).
   - Klicken Sie auf „Aktualisieren“ in der Gruppe „Daten“.

### Zusammenfassung
Die Verwendung von Pivot-Tabellen in Excel ermöglicht es, komplexe Datensätze effizient zu analysieren und zusammenzufassen. Durch das Ziehen von Feldern in verschiedene Bereiche der Pivot-Tabelle können Sie Ihre Daten auf unterschiedliche Weise betrachten und tiefere Einblicke gewinnen.