
## Ziel:
Dieses Arbeitsblatt führt Sie durch die Verwendung der bedingten Formatierung, um Wochenenden in einer Liste von Datumsangaben hervorzuheben. Diese Technik ist nützlich, um wichtige Daten visuell zu unterscheiden und die Analyse zu erleichtern.

## Einführung
Bedingte Formatierung in Excel ermöglicht es, Zellen basierend auf bestimmten Kriterien automatisch zu formatieren. Dies kann verwendet werden, um bestimmte Tage, wie Wochenenden, hervorzuheben.

## Abschnitt 1: Bedingte Formatierung für Wochenenden

### Übung 1: Einfache Datumsreihe erstellen

1. **Öffnen Sie ein neues Excel-Arbeitsblatt.**
2. **Erstellen Sie eine Liste von Datumsangaben:**
   - Geben Sie in Zelle A1 das Startdatum ein, z.B. `01.05.2024`.
   - Ziehen Sie den Füllziehpunkt (kleines Quadrat in der unteren rechten Ecke der Zelle) nach unten, um eine fortlaufende Reihe von Datumsangaben zu erstellen, z.B. bis zum `31.05.2024`.

### Übung 2: Bedingte Formatierung anwenden

1. **Markieren Sie den Bereich der Datumsangaben:**
   - Markieren Sie den Bereich A1:A31.

2. **Bedingte Formatierung öffnen:**
   - Gehen Sie zur Registerkarte „Start“.
   - Klicken Sie auf „Bedingte Formatierung“ in der Gruppe „Formatvorlagen“.
   - Wählen Sie „Neue Regel...“.

3. **Regel zur Hervorhebung von Wochenenden erstellen:**
   - Wählen Sie „Formel zur Ermittlung der zu formatierenden Zellen verwenden“.
   - Geben Sie die folgende Formel ein:
     ```
     =WOCHENTAG(A1;2)>5
     ```
     - `WOCHENTAG(A1, 2)`: Funktion, die den Wochentag des Datums in Zelle A1 zurückgibt, wobei Montag als 1 und Sonntag als 7 gezählt wird.
     - `> 5`: Bedingung, die prüft, ob der Tag ein Samstag (6) oder Sonntag (7) ist.

4. **Format auswählen:**
   - Klicken Sie auf „Formatieren...“.
   - Wählen Sie auf der Registerkarte „Ausfüllen“ eine Hintergrundfarbe aus, um die Wochenenden hervorzuheben (z.B. Hellrot).
   - Klicken Sie auf „OK“.

5. **Regel anwenden:**
   - Klicken Sie erneut auf „OK“, um die Regel anzuwenden.
   - Die Wochenenden in der Liste sollten nun mit der ausgewählten Hintergrundfarbe hervorgehoben sein.

### Übung 3: Bedingte Formatierung auf erweiterten Bereich anwenden

1. **Dateneingabe erweitern:**
   - Erweitern Sie die Liste der Datumsangaben bis zum `31.12.2024`.

2. **Bedingte Formatierung kopieren:**
   - Markieren Sie den Bereich der neuen Datumsangaben (z.B. A32:A365).
   - Gehen Sie zur Registerkarte „Start“.
   - Klicken Sie auf „Bedingte Formatierung“.
   - Wählen Sie „Regeln verwalten...“.
   - Wählen Sie die zuvor erstellte Regel aus und klicken Sie auf „Regel bearbeiten...“.
   - Ändern Sie den Bereich, auf den die Regel angewendet wird, auf den gesamten Bereich der Datumsangaben (z.B. $A$1:$A$365).
   - Klicken Sie auf „OK“.

3. **Ergebnis überprüfen:**
   - Stellen Sie sicher, dass alle Wochenenden im erweiterten Bereich entsprechend hervorgehoben sind.