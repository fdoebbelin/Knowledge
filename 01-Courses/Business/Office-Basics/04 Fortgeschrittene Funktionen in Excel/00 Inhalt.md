## 01 Fortgeschrittene Formeln und Funktionen

#### WENN-DANN-Logik (IF-Logik)

**Beschreibung:**
Die WENN-Funktion führt eine logische Prüfung durch und gibt einen Wert zurück, wenn die Bedingung wahr ist, und einen anderen Wert, wenn sie falsch ist.

**Syntax:**
```
=WENN(Prüfung; Dann_Wert; Sonst_Wert)
```

**Verwendung:**
1. Wählen Sie die Zelle, in der die WENN-Funktion verwendet werden soll.
2. Geben Sie die Formel ein:
   ```
   =WENN(A1>10; "Ja"; "Nein")
   ```
   - `A1>10`: Die Bedingung, die geprüft wird.
   - `"Ja"`: Der Wert, der zurückgegeben wird, wenn die Bedingung wahr ist.
   - `"Nein"`: Der Wert, der zurückgegeben wird, wenn die Bedingung falsch ist.

**Menübefehl:**
- Gehen Sie zur Registerkarte „Formeln“.
- Klicken Sie auf „Logisch“.
- Wählen Sie „WENN“.

#### Verknüpfungen (Verketten)

**Beschreibung:**
Die VERKETTEN-Funktion verbindet mehrere Textstrings zu einem einzigen Textstring.

**Syntax:**
```
=VERKETTEN(Text1; Text2; ...)
```

**Verwendung:**
1. Wählen Sie die Zelle, in der der kombinierte Text angezeigt werden soll.
2. Geben Sie die Formel ein:
   ```
   =VERKETTEN(A1; " "; B1)
   ```
   - `A1`: Der erste Textstring.
   - `" "`: Ein Leerzeichen.
   - `B1`: Der zweite Textstring.

**Menübefehl:**
- Gehen Sie zur Registerkarte „Formeln“.
- Klicken Sie auf „Text“.
- Wählen Sie „VERKETTEN“ (in neueren Versionen „TEXTKETTE“ oder „TEXTVERKETTEN“).

### 02 Daten sortieren und filtern

#### Daten sortieren

**Beschreibung:**
Das Sortieren von Daten erleichtert das Ordnen von Informationen nach bestimmten Kriterien.

**Verwendung:**
1. Wählen Sie den Bereich der Daten, die sortiert werden sollen.
2. Gehen Sie zur Registerkarte „Daten“.
3. Klicken Sie auf „Sortieren“.
4. Wählen Sie die Spalte und das Kriterium, nach dem sortiert werden soll (z.B. aufsteigend oder absteigend).

**Menübefehl:**
- Registerkarte „Daten“.
- Gruppe „Sortieren und Filtern“.
- Option „Sortieren“.

#### Daten filtern

**Beschreibung:**
Filtern ermöglicht es, bestimmte Daten anzuzeigen und andere auszublenden, basierend auf definierten Kriterien.

**Verwendung:**
1. Wählen Sie den Bereich der Daten, die gefiltert werden sollen.
2. Gehen Sie zur Registerkarte „Daten“.
3. Klicken Sie auf „Filtern“.
4. Verwenden Sie die Dropdown-Menüs in den Spaltenüberschriften, um die Daten nach spezifischen Kriterien zu filtern.

**Menübefehl:**
- Registerkarte „Daten“.
- Gruppe „Sortieren und Filtern“.
- Option „Filtern“.

### 03 Bedingte Formatierung

**Beschreibung:**
Bedingte Formatierung hebt Zellen hervor, die bestimmte Kriterien erfüllen, und erleichtert somit die visuelle Analyse von Daten.

**Verwendung:**
1. Wählen Sie den Bereich der Zellen, die bedingt formatiert werden sollen.
2. Gehen Sie zur Registerkarte „Start“.
3. Klicken Sie auf „Bedingte Formatierung“.
4. Wählen Sie eine Regel (z.B. „Zellwert ist größer als“) und legen Sie das Format fest.

**Menübefehl:**
- Registerkarte „Start“.
- Gruppe „Formatvorlagen“.
- Option „Bedingte Formatierung“.

### 04 Einführung in Pivot-Tabellen

**Beschreibung:**
Pivot-Tabellen sind ein leistungsfähiges Werkzeug, um große Datenmengen zu analysieren und zusammenzufassen.

**Verwendung:**
1. Wählen Sie den Bereich der Daten, die in der Pivot-Tabelle analysiert werden sollen.
2. Gehen Sie zur Registerkarte „Einfügen“.
3. Klicken Sie auf „PivotTable“.
4. Wählen Sie das Ziel der Pivot-Tabelle (neues Arbeitsblatt oder bestehendes Arbeitsblatt) und bestätigen Sie.

**Menübefehl:**
- Registerkarte „Einfügen“.
- Gruppe „Tabellen“.
- Option „PivotTable“.