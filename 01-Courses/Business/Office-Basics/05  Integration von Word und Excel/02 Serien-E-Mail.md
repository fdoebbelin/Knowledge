Hier ist eine detaillierte Anleitung zur Erstellung und zum Versand einer Serien-E-Mail mit Excel und Word, bei der die Serienbrieffelder mit den Regel-Dialogen erstellt werden. Diese Übung führt Sie durch das Anlegen einer Adresstabelle in Excel, die Erstellung des Serien-E-Mail-Dokuments in Word und die Vorschau der E-Mails mit der Zuordnung der E-Mail-Adressen und der Kontrolle aller Datensätze.

## Schritt 1: Anlegen einer Adresstabelle in Excel

1. **Öffnen Sie ein neues Excel-Arbeitsblatt.**
2. **Geben Sie die Spaltenüberschriften in die Zellen A1 bis D1 ein:**
   - A1: Geschlecht
   - B1: Vorname
   - C1: Nachname
   - D1: Emailadresse

3. **Geben Sie die folgenden Beispieldatensätze in die Zeilen 2 bis 6 ein:**

| Geschlecht | Vorname  | Nachname  | Emailadresse          |
|------------|----------|-----------|-----------------------|
| Herr       | Max      | Mustermann| max.mustermann@example.com |
| Frau       | Erika    | Meier     | erika.meier@example.com    |
| Herr       | Thomas   | Müller    | thomas.mueller@example.com |
| Frau       | Sabine   | Schmidt   | sabine.schmidt@example.com |
| Herr       | Peter    | Fischer   | peter.fischer@example.com  |

4. **Speichern Sie die Excel-Datei unter einem geeigneten Namen, z.B. „Adressliste.xlsx“.**

## Schritt 2: Anlegen des Serien-Emaildokuments in Word

1. **Öffnen Sie Microsoft Word und erstellen Sie ein neues Dokument.**
2. **Gehen Sie zur Registerkarte „Sendungen“.**
3. **Klicken Sie auf „Seriendruck starten“ und wählen Sie „E-Mail-Nachrichten“.**
4. **Klicken Sie auf „Empfänger auswählen“ und wählen Sie „Vorhandene Liste verwenden...“.**
5. **Navigieren Sie zu der zuvor gespeicherten Excel-Datei „Adressliste.xlsx“ und wählen Sie sie aus.**
   - Wählen Sie das Arbeitsblatt mit den Adressen aus (normalerweise „Tabelle1$“).

6. **Schreiben Sie die Serien-E-Mail in das Word-Dokument, z.B.:**

```
Sehr geehrte<<Anrede>> <<Nachname>>,

wir laden Sie herzlich zur Firmenvorstellung der MetaRow Software UG ein. Unser Geschäftsführer, Herr Franz Herrmann, wird Ihnen unser neuestes Produkt vorstellen und Ihre Fragen beantworten.

Wir freuen uns auf Ihre Teilnahme.

Mit freundlichen Grüßen,
Ihr MetaRow Software Team
```

### Anrede über Regel-Dialoge einfügen

1. **Setzen Sie den Cursor an die Stelle, an der die Anrede eingefügt werden soll, nach "Sehr geehrte".**
2. **Gehen Sie zur Registerkarte „Sendungen“.**
3. **Klicken Sie auf „Regeln“ und wählen Sie „Wenn...Dann...Sonst...“.**
4. **Im Dialogfeld „Wenn...Dann...Sonst...“:**
   - Feldname: Wählen Sie „Geschlecht“.
   - Vergleich: Wählen Sie „Gleich“.
   - Vergleichswert: Geben Sie „Herr“ ein.
   - Dann Text: Geben Sie „r Herr“ ein.
   - Sonst Text: Geben Sie „ Frau“ ein.
5. **Klicken Sie auf „OK“.**

   - Das Ergebnis sollte wie folgt aussehen:

```
Sehr geehrte{ IF { MERGEFIELD Geschlecht } = "Herr" "r Herr" " Frau" } <<Nachname>>,
```

6. **Fügen Sie das Seriendruckfeld für den Nachnamen ein:**
   - Klicken Sie auf „Seriendruckfeld einfügen“ und wählen Sie „Nachname“.

### Vorschau und Kontrolle

1. **Gehen Sie zur Registerkarte „Sendungen“.**
2. **Klicken Sie auf „Vorschau Ergebnisse“, um die Seriendruckfelder mit den tatsächlichen Daten zu sehen.**
3. **Blättern Sie durch die Datensätze, um sicherzustellen, dass die Anrede und die E-Mail-Adressen korrekt sind:**
   - Verwenden Sie die Pfeiltasten „Nächster Datensatz“ und „Vorheriger Datensatz“ in der Gruppe „Vorschau Ergebnisse“, um alle Datensätze zu überprüfen.

### Senden der Serien-E-Mails

1. **Gehen Sie zur Registerkarte „Sendungen“.**
2. **Klicken Sie auf „Fertig stellen und zusammenführen“ und wählen Sie „E-Mail-Nachrichten senden...“.**
3. **Im Dialogfeld „Mit E-Mail-Nachrichten zusammenführen“:**
   - An: Wählen Sie das Seriendruckfeld für die E-Mail-Adresse (z.B. „Emailadresse“).
   - Betreffzeile: Geben Sie den Betreff der E-Mail ein, z.B. „Einladung zur Firmenvorstellung“.
   - Mailformat: Wählen Sie „HTML“.
4. **Klicken Sie auf „OK“, um den Versand der E-Mails zu starten.**

### Zusammenfassung

Diese Übung führt Sie durch die Erstellung einer Adresstabelle in Excel, die Erstellung eines Serien-E-Mail-Dokuments in Word mit variabler Anrede über Regel-Dialoge und die Vorschau der E-Mails zur Kontrolle der Daten. Mit diesen Schritten können Sie personalisierte E-Mails effizient erstellen und versenden.