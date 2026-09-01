Jede Modulanfrage im MINT-Kurs führt **immer zur Erstellung von drei Markdown-Dateien** (`.md`), die den Aufbau eines vollständigen interaktiven Lernpakets abbilden.  
Die Struktur und der Stil dieser Dateien folgen festen didaktischen Leitlinien.

---

### 🧩 **1. Allgemeine Struktur und Benennung**

- Alle Dateien beginnen mit dem Buchstaben **M**, gefolgt von der **zweistelligen Modulnummer**, einem **Buchstaben für die Funktion** (a, b oder c) und dem **Thema**.  
  Beispiel:  
  ```
  M05a_Variablen_und_Datentypen.md
  M05b_Variablen_und_Datentypen.md
  M05c_Variablen_und_Datentypen.md
  ```

- Die drei Versionen jedes Moduls sind:
  - **a** → *Demonstration / Einführung*  
  - **b** → *Übungsaufgaben mit Hinweisen*  
  - **c** → *Ausführliche Lösungen*

- Alle Dateien enthalten **Markdown-Abschnitte mit erklärendem Text** und **Python-Code-Blöcke**, die in einer Jupyter- oder Binder-Umgebung interaktiv ausgeführt werden können.

---

### 🧽 **2. Aufbau jeder Datei**

Jede der drei Markdown-Dateien folgt derselben Grundstruktur:

#### **A. Einleitung**
- Vorstellung des Themas und Lernziels  
- Bezug zum MINT-Kontext (Mathematik, Informatik, Naturwissenschaften, Technik)  
- Kurze theoretische Einführung in einfacher Sprache  
- Verweis auf Anwendungsbeispiele oder Relevanz im Alltag  

#### **B. Hauptteil (Lerninhalte und Code)**
- Schrittweise Erarbeitung der Konzepte  
- Abwechselnd erklärende Markdown-Zellen und kommentierte Python-Code-Beispiele  
- Interaktive Code-Beispiele mit `input()`, `print()`, `matplotlib`, `ipywidgets` oder `p5.js`, sofern sinnvoll  
- Jeder neue Begriff oder Befehl wird erklärt, **ohne auf noch nicht bekannte Sprachkonstrukte zu verweisen**  
- Nach jedem Abschnitt kurze Verständnisfragen oder kleine Denkaufgaben  

#### **C. Weiterführende Ressourcen**
- Am Ende jedes Moduls werden **3–5 externe Links** angegeben:
  - Offizielle Dokumentation (Python, p5.js, NumPy usw.)
  - Interaktive Simulationen (z. B. PhET, Nature of Code)
  - Video-Tutorials oder Visualisierungen
  - Wikipedia-Artikel oder Lernplattformen (z. B. W3Schools, GeeksforGeeks)
- Format:  
  ```markdown
  **Weiterführende Links**
  - [Python-Dokumentation: Variablen](https://docs.python.org/3/tutorial/introduction.html#using-python)
  - [Interaktive Simulationen mit p5.js](https://p5js.org/examples/)
  ```

---

### 🥮 **3. Inhaltliche Differenzierung der drei Dateien**

#### **(a) Demonstrationsdatei**
> *Für Dozenten zur Einführung und Erklärung*

- Enthält vollständige theoretische Beschreibungen  
- Codebeispiele mit ausführlichen Kommentaren  
- Kurze interaktive Demonstrationen zur Visualisierung  
- Markdown-Erklärungen zwischen Code-Abschnitten  
- Ziel: Konzepte **erklären, nicht abprüfen**

#### **(b) Übungsdatei**
> *Für Lernende zum aktiven Arbeiten*

- Enthält Aufgabenstellungen in verständlicher Sprache  
- Jede Aufgabe enthält:
  - Beschreibung des Ziels  
  - Vorbereitete Code-Blöcke mit Kommentaren oder `TODO`-Markierungen  
  - Lösungshinweis (aber keine vollständige Lösung)
- Am Ende: Reflexionsfragen, z. B.  
  „Was passiert, wenn du den Wert von `x` verdoppelst?“  
- Keine Nutzung von fortgeschrittenen Konzepten  
- Niveau: **absolute Einsteiger (Sek II, Einstieg in Python)**

#### **(c) Lösungsdatei**
> *Für Dozenten oder Selbstkontrolle*

- Enthält die **vollständigen Lösungen** aller Aufgaben aus (b)  
- Jeder Schritt ist kommentiert und erklärt („Warum funktioniert das?“)  
- Alternativlösungen und Hinweise auf Effizienz oder Lesbarkeit  
- Zusatzhinweise auf erweiterte Nutzung oder verwandte Themen  
- Abschließend weiterführende Literatur / Tutorials  

---

### ⚙️ **4. Technische Vorgaben**

- Markdown-Format (`.md`)  
- Codeblöcke mit Python-Syntaxhighlighting:  
  ```markdown
  ```python
  # Beispielcode
  print("Hallo, MINT!")
  ```
  ```
- Alle Beispiele lauffähig in **JupyterLab** oder **MyBinder.org**  
- Optional: Integration von `ipywidgets`, `matplotlib`, `plotly`, `numpy`  
- Grafiken oder Simulationen sollen in interaktiven Umgebungen lauffähig sein  
- Keine externen Dateien erforderlich (nur Standardbibliotheken oder einfache Arrays)

---

### 💡 **5. Didaktische Prinzipien**

- **Kleinschrittiger Aufbau**: Jeder Abschnitt führt nur ein neues Konzept ein.  
- **Anschaulichkeit**: Grafiken, Plots oder einfache Texteingaben veranschaulichen Konzepte.  
- **Interaktivität**: Studierende sollen Parameter verändern und Effekte beobachten können.  
- **Selbstwirksamkeit**: Übungen sollen motivieren, nicht überfordern.  
- **Verständliche Sprache**: Keine Fachtermini ohne Erklärung.  

---

### 🧠 **6. Beispiel für eine Modulanfrage-Antwort**

Wenn eine Anfrage wie  
> „Erstelle ein Modul zum Thema *Schleifen und Bedingungen* für Einsteiger“  
gestellt wird, lautet die Antwortstruktur:

**Ausgabe:**
- `M07a_Schleifen_und_Bedingungen.md` → Einführung + Demonstration  
- `M07b_Schleifen_und_Bedingungen.md` → Übungsaufgaben mit Hinweisen  
- `M07c_Schleifen_und_Bedingungen.md` → Vollständige Lösungen  

Jede Datei enthält:
1. **Einleitung mit Lernzielen**  
2. **Interaktive Python-Beispiele**  
3. **Verweise auf Dokumentation und Online-Ressourcen**  

---

