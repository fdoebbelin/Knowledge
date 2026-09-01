## Übung: Erstellung eines Haushaltsbuchs in Excel

### Ausgangsdaten
Erstellen Sie eine Tabelle mit den folgenden Spaltenüberschriften:
- Datum
- Kategorie
- Beschreibung
- Betrag

### 1. Bedingte Formatierung

#### Schritt 1: Wochenenden rot markieren
1. **Öffnen Sie ein neues Arbeitsblatt und geben Sie die Spaltenüberschriften in die Zellen A1:D1 ein.**
2. **Geben Sie einige Beispieldaten ein.**
3. **Markieren Sie die Spalte „Datum“ (z.B. A2:A100).**
4. **Gehen Sie zur Registerkarte „Start“.**
5. **Klicken Sie auf „Bedingte Formatierung“.**
6. **Wählen Sie „Neue Regel...“.**
7. **Wählen Sie „Formel zur Ermittlung der zu formatierenden Zellen verwenden“.**
8. **Geben Sie die folgende Formel ein:**
   ```
   =WOCHENTAG(A2; 2)>5
   ```
   - Diese Formel markiert Samstage (6) und Sonntage (7).

9. **Klicken Sie auf „Formatieren...“ und wählen Sie eine rote Hintergrundfarbe.**
10. **Klicken Sie auf „OK“, um die Regel anzuwenden.**

#### Schritt 2: Positive Beträge grün und negative Beträge rot markieren
1. **Markieren Sie die Spalte „Betrag“ (z.B. D2:D100).**
2. **Gehen Sie zur Registerkarte „Start“.**
3. **Klicken Sie auf „Bedingte Formatierung“.**
4. **Wählen Sie „Neue Regel...“.**
5. **Wählen Sie „Nur Zellen formatieren, die enthalten“.**
6. **Stellen Sie die Regel für positive Beträge ein:**
   - Im ersten Dropdown-Menü wählen Sie „Zellwert“.
   - Im zweiten Dropdown-Menü wählen Sie „größer als“.
   - Im Feld geben Sie `0` ein.
7. **Klicken Sie auf „Formatieren...“ und wählen Sie eine grüne Hintergrundfarbe.**
8. **Klicken Sie auf „OK“, um die Regel anzuwenden.**
9. **Wiederholen Sie die Schritte 4 bis 8 für negative Beträge:**
   - Wählen Sie „Zellwert“.
   - Wählen Sie „kleiner als“.
   - Geben Sie `0` ein.
   - Wählen Sie eine rote Hintergrundfarbe.

### 2. Datenüberprüfung der Beträge als Zahl im Bereich -10000 und +10000
1. **Markieren Sie die Spalte „Betrag“ (z.B. D2:D100).**
2. **Gehen Sie zur Registerkarte „Daten“.**
3. **Klicken Sie auf „Datenüberprüfung“.**
4. **Wählen Sie im Dropdown-Menü „Datenüberprüfung...“.**
5. **Im Dialogfeld „Datenüberprüfung“:**
   - Wählen Sie die Registerkarte „Einstellungen“.
   - Wählen Sie bei „Zulassen“ den Eintrag „Dezimal“.
   - Bei „Daten“ wählen Sie „zwischen“.
   - Geben Sie bei „Minimum“ `-10000` und bei „Maximum“ `10000` ein.
6. **Klicken Sie auf „OK“.**

### 3. Datenüberprüfung der Spalte „Kategorie“ mit einer Liste, die auf einem extra Blatt gespeichert wird

#### Schritt 1: Kategorienliste erstellen
1. **Erstellen Sie ein neues Blatt und benennen Sie es „Kategorien“.**
2. **Geben Sie in Spalte A die möglichen Kategorien ein (z.B. „Miete“, „Lebensmittel“, „Transport“, „Freizeit“).**
3. **Markieren Sie die Liste der Kategorien (z.B. A1:A4).**
4. **Geben Sie der markierten Liste einen Namen:**
   - Gehen Sie zur Registerkarte „Formeln“.
   - Klicken Sie auf „Namensmanager“ und dann auf „Neu“.
   - Geben Sie einen Namen ein, z.B. „Kategorien“.
   - Klicken Sie auf „OK“.

#### Schritt 2: Datenüberprüfung einrichten
1. **Gehen Sie zurück zu Ihrem Haushaltsbuch-Blatt.**
2. **Markieren Sie die Spalte „Kategorie“ (z.B. B2:B100).**
3. **Gehen Sie zur Registerkarte „Daten“.**
4. **Klicken Sie auf „Datenüberprüfung“.**
5. **Im Dialogfeld „Datenüberprüfung“:**
   - Wählen Sie die Registerkarte „Einstellungen“.
   - Bei „Zulassen“ wählen Sie „Liste“.
   - Geben Sie bei „Quelle“ `=Kategorien` ein (oder den Namen, den Sie Ihrer Liste gegeben haben).
6. **Klicken Sie auf „OK“.**

### 4. Schutz und Ausblenden des Kategorieblattes

#### Schritt 1: Blatt ausblenden
1. **Rechtsklicken Sie auf das Blatt „Kategorien“.**
2. **Wählen Sie „Ausblenden“.**

#### Schritt 2: Arbeitsmappe schützen
1. **Gehen Sie zur Registerkarte „Überprüfen“.**
2. **Klicken Sie auf „Blatt schützen“.**
3. **Im Dialogfeld „Blatt schützen“:**
   - Aktivieren Sie die gewünschten Optionen (z.B. „Formatierung der Zellen“ deaktivieren, damit diese nicht geändert werden können).
   - Geben Sie ein Passwort ein (optional).
1. **Klicken Sie auf „OK“.**