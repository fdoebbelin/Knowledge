Um die Tabellen aus **Obsidian** in **Excel** zu importieren, gibt es mehrere Methoden. Hier sind die besten Vorgehensweisen:

---

## **1. Markdown-Tabelle direkt in Excel umwandeln**

### **Schritte:**

1. Kopiere die Tabelle aus Obsidian.
2. Öffne **Excel** und wähle eine leere Tabelle.
3. Gehe zu **Daten → Text in Spalten**.
4. Wähle das **Trennzeichen-basiertes Format** und verwende das `|`-Symbol als Trennzeichen.
5. Entferne überflüssige Spalten und säubere die Formatierung.

---

## **2. Umwandlung über ein Text-Editor (Notepad++ oder VS Code)**

Falls Excel das `|`-Symbol nicht richtig erkennt:

1. Öffne die Markdown-Tabelle in **Notepad++** oder **VS Code**.
2. Ersetze `|` durch **Tabstopp (`\t`)** oder **Semikolon (`;`)**.
    - In VS Code: `Strg + H` → Suchen nach `|` → Ersetzen durch `\t`
    - In Notepad++: **Ersetzen** mit **Tabstopp**
3. Speichere als `.csv` oder `.tsv`.
4. Öffne das File in Excel.

---

## **3. Direkt in CSV umwandeln**

Falls du häufiger Daten exportierst:

1. Kopiere die Markdown-Tabelle.
2. Nutze einen Online-Konverter wie **[Convert Markdown Table to CSV](https://www.convertcsv.com/markdown-table-to-csv.htm)**.
3. Lade das CSV in **Excel**.

---

## **4. Excel Power Query nutzen (Für viele Tabellen)**

1. Speichere die Datei als `.md` oder `.txt` in einem Ordner.
2. Öffne **Excel → Daten → Abrufen und Transformieren (Power Query)**.
3. Wähle **"Aus Text/CSV"** und lade die Datei.
4. Setze das `|`-Symbol als Trennzeichen.

---

### **Empfohlene Methode:**

📌 **Für einzelne Tabellen:** **Methode 1** oder **Methode 2**  
📌 **Für viele Tabellen und automatisierte Prozesse:** **Power Query (Methode 4)**

Möchtest du, dass ich die Tabelle für dich als `.csv` oder `.xlsx` exportiere? 😊