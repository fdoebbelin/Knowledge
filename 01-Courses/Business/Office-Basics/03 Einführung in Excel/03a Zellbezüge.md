Die Bildung von Zellbezügen in Microsoft Excel ist eine essenzielle Fähigkeit, die es ermöglicht, Daten effizient zu verwalten und zu manipulieren. 

#### 1. **Relative Zellbezüge**
- Ein relativer Bezug in Excel ändert sich, wenn die Formel, die ihn enthält, verschoben oder kopiert wird.
- **Beispiel**: Wenn Sie eine Formel wie `=A1+B1` in Zelle C1 haben und sie nach unten nach C2 kopieren, ändert sich die Formel automatisch zu `=A2+B2`.

#### 2. **Absolute Zellbezüge**
- Ein absoluter Bezug bleibt konstant, egal wo im Arbeitsblatt die Formel kopiert wird. Er wird durch das Dollarzeichen ($) vor der Spaltenbuchstaben und/oder der Zeilennummer gekennzeichnet.
- **Beispiel**: `=$A$1` bleibt immer auf Zelle A1 bezogen, unabhängig davon, wo die Formel kopiert wird.

#### 3. **Gemischte Zellbezüge**
- Ein gemischter Bezug kombiniert die Eigenschaften relativer und absoluter Bezüge. Nur ein Teil des Bezugs wird fixiert (entweder die Spalte oder die Zeile).
- **Beispiel**: `=A$1` fixiert die Zeile 1, während die Spalte A relativ bleibt und sich ändert, wenn die Formel kopiert wird.

#### 4. **3D-Bezüge**
- Ein 3D-Bezug in Excel bezieht sich auf dieselbe Zelle oder denselben Zellbereich in mehreren Arbeitsblättern. Dies ist nützlich, um dieselbe Art von Daten aus verschiedenen Arbeitsblättern zu aggregieren.
- **Beispiel**: `=SUM(Tabelle1:Tabelle3!A1)` summiert die Werte in Zelle A1 der Arbeitsblätter Tabelle1, Tabelle2 und Tabelle3.

#### 5. **Bezüge über Arbeitsmappen hinweg**
- Sie können auch Bezüge auf Zellen oder Bereiche in anderen Arbeitsmappen erstellen. Diese Bezüge müssen den Pfad zur anderen Arbeitsmappe sowie den Dateinamen und das Arbeitsblatt enthalten.
- **Beispiel**: `=[Budget.xlsx]Jahreszahlen!B5` bezieht sich auf Zelle B5 im Arbeitsblatt „Jahreszahlen“ der Arbeitsmappe „Budget.xlsx“.