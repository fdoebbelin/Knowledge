Um in Excel positive Werte grün und negative Werte rot zu hinterlegen, können Sie die bedingte Formatierung verwenden. Diese Funktion ermöglicht es, die Formatierung von Zellen basierend auf deren Inhalt automatisch anzupassen. Hier ist eine Schritt-für-Schritt-Anleitung, wie Sie dies erreichen können:

### Schritt 1: Daten eingeben
1. **Öffnen Sie ein neues Excel-Arbeitsblatt.**
2. **Geben Sie einige Werte in eine Spalte ein.** Zum Beispiel:
   - In Zelle A1: `10`
   - In Zelle A2: `-5`
   - In Zelle A3: `20`
   - In Zelle A4: `-15`
   - In Zelle A5: `0`

### Schritt 2: Bereich auswählen
1. **Markieren Sie den Bereich, den Sie formatieren möchten.**
   - Zum Beispiel den Bereich A1:A5.

### Schritt 3: Bedingte Formatierung anwenden
1. **Gehen Sie zur Registerkarte „Start“.**
2. **Klicken Sie auf „Bedingte Formatierung“ in der Gruppe „Formatvorlagen“.**
3. **Wählen Sie „Regel verwalten...“.**

### Schritt 4: Regel für positive Werte erstellen
1. **Klicken Sie auf „Neue Regel...“.**
2. **Wählen Sie „Nur Zellen formatieren, die enthalten“.**
3. **Stellen Sie die Regel wie folgt ein:**
   - Im ersten Dropdown-Menü wählen Sie „Zellwert“.
   - Im zweiten Dropdown-Menü wählen Sie „größer als“.
   - Im Feld geben Sie `0` ein.
4. **Klicken Sie auf „Formatieren...“.**
5. **Wählen Sie die Registerkarte „Ausfüllen“ und wählen Sie eine grüne Hintergrundfarbe.**
6. **Klicken Sie auf „OK“, um die Formatierung zu bestätigen.**
7. **Klicken Sie erneut auf „OK“, um die Regel zu erstellen.**

### Schritt 5: Regel für negative Werte erstellen
1. **Klicken Sie auf „Neue Regel...“.**
2. **Wählen Sie „Nur Zellen formatieren, die enthalten“.**
3. **Stellen Sie die Regel wie folgt ein:**
   - Im ersten Dropdown-Menü wählen Sie „Zellwert“.
   - Im zweiten Dropdown-Menü wählen Sie „kleiner als“.
   - Im Feld geben Sie `0` ein.
4. **Klicken Sie auf „Formatieren...“.**
5. **Wählen Sie die Registerkarte „Ausfüllen“ und wählen Sie eine rote Hintergrundfarbe.**
6. **Klicken Sie auf „OK“, um die Formatierung zu bestätigen.**
7. **Klicken Sie erneut auf „OK“, um die Regel zu erstellen.**

### Schritt 6: Regeln anwenden und überprüfen
1. **Stellen Sie sicher, dass beide Regeln im „Manager für Regeln zur bedingten Formatierung“ aufgeführt sind.**
2. **Klicken Sie auf „Übernehmen“ und dann auf „OK“.**
3. **Überprüfen Sie, ob die positiven Werte grün und die negativen Werte rot hinterlegt sind.**

## Beispiel:
Nach der Anwendung der bedingten Formatierung sollten Ihre Zellen wie folgt aussehen:
- Zelle A1 (10) sollte grün hinterlegt sein.
- Zelle A2 (-5) sollte rot hinterlegt sein.
- Zelle A3 (20) sollte grün hinterlegt sein.
- Zelle A4 (-15) sollte rot hinterlegt sein.
- Zelle A5 (0) sollte keine spezielle Formatierung haben, da sie weder positiv noch negativ ist.

Durch die bedingte Formatierung können Sie Ihre Daten visuell ansprechend und leicht verständlich gestalten. Diese Technik ist besonders nützlich für Finanzberichte, Bestandslisten oder jede andere Art von numerischen Daten, bei denen die Unterscheidung zwischen positiven und negativen Werten wichtig ist.