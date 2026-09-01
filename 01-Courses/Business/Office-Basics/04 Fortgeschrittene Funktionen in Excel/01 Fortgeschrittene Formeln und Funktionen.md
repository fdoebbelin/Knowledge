## Ausgangsdaten

Erstellen Sie eine Tabelle mit den folgenden Daten:

| Name  | Abteilung | Gehalt | Eintrittsdatum |
| ----- | --------- | ------ | -------------- |
| Anna  | Vertrieb  | 50000  | 01.01.2018     |
| Bernd | HR        | 45000  | 15.05.2019     |
| Clara | Vertrieb  | 55000  | 10.08.2017     |
| David | IT        | 60000  | 01.07.2020     |
| Erika | HR        | 47000  | 23.03.2018     |
| Felix | IT        | 52000  | 12.12.2019     |

## 1. WENN-DANN-Logik (IF-Logik)

**Beschreibung:**

Die WENN-Funktion führt eine logische Prüfung durch und gibt einen Wert zurück, wenn die Bedingung wahr ist, und einen anderen Wert, wenn sie falsch ist.

**Syntax:**

```
=WENN(Prüfung; Dann_Wert; Sonst_Wert)
```

### Übung

1. **Geben Sie in Zelle E1 die Überschrift „Bonus“ ein.**
2. **Geben Sie in Zelle E2 die folgende Formel ein:**
   ```
   =WENN(C2>50000; "Ja"; "Nein")
   ```
   - Diese Formel prüft, ob das Gehalt in Zelle C2 größer als 50000 ist. Wenn ja, wird „Ja“ zurückgegeben, ansonsten „Nein“.
3. **Verwenden Sie die Autofill-Funktion, um die Formel auf die Zellen E3 bis E7 zu kopieren.**

## 2. SUMMEWENN (SUMIF)

**Beschreibung:**

Die SUMMEWENN-Funktion summiert die Werte in einem Bereich, die einem angegebenen Kriterium entsprechen.

**Syntax:**

```
=SUMMEWENN(Bereich; Kriterium; [Summe_Bereich])
```

### Übung
1. **Geben Sie in Zelle G1 die Überschrift „Summe Vertrieb“ ein.**
2. **Geben Sie in Zelle G2 die folgende Formel ein:**
   ```
   =SUMMEWENN(B2:B7; "Vertrieb"; C2:C7)
   ```
   - Diese Formel summiert die Gehälter in Spalte C, wenn der Wert in Spalte B „Vertrieb“ ist.

## 3. SVERWEIS (VLOOKUP)

**Beschreibung:**

Die SVERWEIS-Funktion durchsucht die erste Spalte einer Tabelle und gibt einen Wert in derselben Zeile aus einer anderen Spalte zurück.

**Syntax**:

```
=SVERWEIS(Suchkriterium; Matrix; Spaltenindex; [Bereich_Verweis])
```

- **Suchkriterium**: Der Wert, nach dem gesucht werden soll.
- **Matrix**: Der Bereich, der durchsucht werden soll.
- **Spaltenindex**: Die Spaltennummer in der Matrix, aus der der Wert zurückgegeben werden soll.
- **Bereich_Verweis**: 
	- **WAHR (TRUE)**: Sucht nach der nächstkleineren Übereinstimmung und setzt voraus, dass die erste Spalte der Matrix sortiert ist.
	- **FALSCH (FALSE)**: Sucht nach einer exakten Übereinstimmung und gibt den Fehlerwert #NV zurück, wenn keine exakte Übereinstimmung gefunden wird.

### Übung 1: Exakte Übereinstimmung

Angenommen, wir haben folgende Tabelle:

| Name  | Abteilung | Gehalt | Eintrittsdatum |
| ----- | --------- | ------ | -------------- |
| Anna  | Vertrieb  | 50000  | 01.01.2018     |
| Bernd | HR        | 45000  | 15.05.2019     |
| Clara | Vertrieb  | 55000  | 10.08.2017     |
| David | IT        | 60000  | 01.07.2020     |
| Erika | HR        | 47000  | 23.03.2018     |
| Felix | IT        | 52000  | 12.12.2019     |

**Ziel**: Finden Sie die Abteilung von Clara.

**Formel**:
```
=SVERWEIS("Clara"; A2:D7; 2; FALSCH)
```

- **Suchkriterium**: "Clara"
- **Matrix**: A2:D7
- **Spaltenindex**: 2 (die Spalte "Abteilung")
- **Bereich_Verweis**: FALSCH (exakte Übereinstimmung)

**Ergebnis**: "Vertrieb"

### Übung 2: Ungefähre Übereinstimmung

Angenommen, wir haben folgende Tabelle, in der die Gehälter aufsteigend sortiert sind:

| Gehalt | Name    |
|--------|---------|
| 45000  | Bernd   |
| 47000  | Erika   |
| 50000  | Anna    |
| 52000  | Felix   |
| 55000  | Clara   |
| 60000  | David   |

**Ziel**: Finden Sie den Namen der Person, deren Gehalt am nächsten zu 53000 liegt.

**Formel**:

```
=SVERWEIS(53000; A2:B7; 2; WAHR)
```

- **Suchkriterium**: 53000
- **Matrix**: A2:B7
- **Spaltenindex**: 2 (die Spalte "Name")
- **Bereich_Verweis**: WAHR (ungefähre Übereinstimmung)

**Ergebnis**: "Felix"

**Erläuterung**: Da 53000 nicht exakt in der Tabelle vorhanden ist und der Parameter WAHR verwendet wird, sucht die Funktion nach der nächstkleineren Zahl, die 53000 am nächsten kommt, was 52000 ist, und gibt den entsprechenden Namen "Felix" zurück.

## 4. INDEX und VERGLEICH

**Beschreibung:**
Die INDEX-Funktion gibt den Wert einer bestimmten Zelle in einem Bereich zurück, basierend auf den angegebenen Zeilen- und Spaltennummern. Die VERGLEICH-Funktion sucht nach einem Wert in einem Bereich und gibt die relative Position dieses Wertes zurück.

**Syntax:**
```
=INDEX(Matrix; Zeile; [Spalte])
=VERGLEICH(Suchkriterium; Suchmatrix; [Vergleichstyp])
```

### A) Finden Sie den Namen basierend auf dem Gehalt

#### Verwenden der Funktion VERGLEICH

Die VERGLEICH-Funktion wird verwendet, um die Position eines Wertes in einem Bereich zu finden. In diesem Beispiel suchen wir die Position des Gehalts in der Gehaltsspalte.

1. **Geben Sie in Zelle F1 die Überschrift „Suchgehalt“ ein.**
2. **Geben Sie in Zelle F2 das Gehalt ein, nach dem Sie suchen möchten, z.B. 55000.**
3. **Geben Sie in Zelle G1 die Überschrift „Position“ ein.**
4. **Geben Sie in Zelle G2 die folgende Formel ein:**
   ```
   =VERGLEICH(F2; C2:C7; 0)
   ```
   - Diese Formel gibt die Position des Wertes in F2 (55000) in der Spalte C zurück.

#### Verwenden der Funktion INDEX
Die INDEX-Funktion gibt den Wert einer Zelle in einem bestimmten Bereich zurück, basierend auf der Zeilen- und Spaltennummer.

1. **Geben Sie in Zelle H1 die Überschrift „Name“ ein.**
2. **Geben Sie in Zelle H2 die folgende Formel ein:**
   ```
   =INDEX(A2:A7; G2)
   ```
   - Diese Formel verwendet die Position aus Zelle G2, um den entsprechenden Namen in der Spalte A zu finden.

#### Zusammenführen von INDEX und VERGLEICH

Um die Suche effizienter zu gestalten, können Sie die Funktionen INDEX und VERGLEICH in einer einzigen Formel kombinieren.

1. **Geben Sie in Zelle J1 die Überschrift „Name für Suchgehalt“ ein.**
2. **Geben Sie in Zelle J2 die folgende Formel ein:**
   ```
   =INDEX(A2:A7; VERGLEICH(F2; C2:C7; 0))
   ```
   - Diese Formel sucht nach dem Gehalt in Zelle F2 in der Spalte C, findet die Position und verwendet diese Position, um den Namen in Spalte A zu finden.

### B) Finden Sie die Abteilung basierend auf dem Eintrittsdatum

1. **Geben Sie in Zelle K1 die Überschrift „Suchdatum“ ein.**
2. **Geben Sie in Zelle K2 das Eintrittsdatum ein, nach dem Sie suchen möchten, z.B. 01.07.2020.**
3. **Geben Sie in Zelle L1 die Überschrift „Abteilung“ ein.**
4. **Geben Sie in Zelle L2 die folgende Formel ein:**
   ```
   =INDEX(B2:B7; VERGLEICH(K2; D2:D7; 0))
   ```
   - Diese Formel sucht nach dem Datum in Zelle K2 in der Spalte D, findet die Position und verwendet diese Position, um die Abteilung in Spalte B zu finden.

### Zusammenfassung
Die Kombination der Funktionen INDEX und VERGLEICH bietet eine flexible Methode, um Werte in Excel zu suchen und zurückzugeben, unabhängig davon, in welcher Spalte die Suchkriterien sich befinden. Dies ermöglicht komplexere und dynamischere Datenabfragen, die mit SVERWEIS allein nicht möglich wären.

### 5. TEXT-Funktionen (VERKETTEN, TEXT)

**Beschreibung:**
Die VERKETTEN-Funktion verbindet mehrere Textstrings zu einem einzigen Textstring. Die TEXT-Funktion formatiert eine Zahl und gibt sie als Text zurück.

**Syntax:**
```
=VERKETTEN(Text1; Text2; ...)
=TEXT(Wert; Textformat)
```

**Beispiel:**
1. **Geben Sie in Zelle M1 die Überschrift „Name und Abteilung“ ein.**
2. **Geben Sie in Zelle M2 die folgende Formel ein:**
   ```
   =VERKETTEN(A2; " - "; B2)
   ```
   - Diese Formel verbindet den Namen und die Abteilung in Spalte A und B.

### Übung 5: Namen und Abteilung verbinden
- Geben Sie die Formel in Zelle M2 ein.
- Verwenden Sie Autofill, um die Formel auf die Zellen M3 bis M7 zu kopieren.

### Zusammenfassung
Dieses Arbeitsblatt bietet eine umfassende Anleitung zur Verwendung fortgeschrittener Formeln und Funktionen in Excel, einschließlich der WENN-Funktion, SUMMEWENN, SVERWEIS, INDEX und VERGLEICH sowie Textfunktionen. Durch die praktischen Übungen werden Sie in der Lage sein, diese Konzepte effektiv anzuwenden, um komplexe Berechnungen und Datenanalysen durchzuführen.

---