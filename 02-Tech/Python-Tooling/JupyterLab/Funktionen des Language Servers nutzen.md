Um die Funktionen des Language Servers in **JupyterLab** zu nutzen, folge diesen Schritten:

### **1. Überprüfen, ob LSP aktiv ist:**

- **Einstellungen in JupyterLab:**
    - Gehe zu **Settings** → **Advanced Settings Editor** → **Language Servers**, um zu sehen, welche LSP-Server aktiv sind und welche Sprachen unterstützt werden.
    - Alternativ: **Help** → **About** zeigt eine Übersicht der installierten Erweiterungen.

### **2. Nutzung der LSP-Funktionen:**

#### **Automatische Codevervollständigung:**

- **Trigger:** Während du im Editor tippst, erscheint eine Vervollständigungsliste automatisch oder durch das Drücken von `Tab` oder `Ctrl + Space`.
- **Beispiel:**
    
    ```python
    im # Vervollständigung zu 'import'
    ```
    

#### **Hover-Informationen:**

- **Funktion:** Zeigt Dokumentationen und Typinformationen zu Funktionen, Klassen oder Variablen.
- **Trigger:** Fahre mit der Maus über einen Code-Abschnitt oder wähle ihn aus.

#### **Fehlerhervorhebung und Warnungen:**

- **Funktion:** Syntaxfehler, Typfehler und Warnungen werden inline im Editor angezeigt.
- **Trigger:** Automatisch beim Schreiben oder nach dem Speichern des Notebooks.

#### **Codeformatierung:**

- **Funktion:** Formatiert den Code automatisch nach den Regeln des aktiven LSP-Servers.
- **Trigger:**
    - Über das Menü: **Edit** → **Format Code**.
    - Tastenkombination: `Shift + Alt + F`.

#### **Definitionen und Verweise:**

- **Gehe zu Definition:** Springe zur Definition einer Funktion, Klasse oder Variablen.
    - **Trigger:** Rechtsklick → **Go to Definition** oder `Ctrl + Klick`.
- **Finde Verweise:** Zeigt alle Stellen im Projekt, an denen ein Symbol verwendet wird.
    - **Trigger:** Rechtsklick → **Find References**.

#### **Refactoring-Unterstützung:**

- **Funktion:** Erlaubt das Umbenennen von Variablen oder Funktionen.
- **Trigger:** Rechtsklick → **Rename Symbol** oder durch `F2`.

### **3. Konfiguration der LSP-Funktionalitäten:**

Du kannst die LSP-Funktionen über das Menü **Settings** → **Advanced Settings Editor** → **Language Server** weiter anpassen. Zum Beispiel:

```json
{
  "documentFormatting": true,
  "hover": true,
  "completion": true
}
```

### **4. Unterstützung für zusätzliche Sprachen:**

Falls du weitere Sprachen unterstützt haben möchtest, installiere den entsprechenden LSP-Server und stelle sicher, dass er korrekt konfiguriert ist (siehe vorherige Antworten).