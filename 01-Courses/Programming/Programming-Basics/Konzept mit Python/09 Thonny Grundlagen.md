## 1. Installation von Thonny

```sh
pip install thonny
```
## 2. Benutzeroberfläche von Thonny

Nach dem Start von Thonny sehen Sie die folgende Benutzeroberfläche:

- **Editor-Fenster**: Hier schreiben Sie Ihren Code.
- **Shell-Fenster**: Hier können Sie Python-Befehle direkt eingeben und ausführen. Es zeigt auch die Ausgabe Ihres Codes.
- **Werkzeugleiste**: Hier befinden sich Tasten für häufig genutzte Funktionen (z. B. Start, Debuggen, Datei speichern).
- **Variablen-Fenster (optional)**: Zeigt die aktuell im Code verwendeten Variablen an.
## 3. Ein einfaches Python-Programm ausführen

1. Öffnen Sie eine neue Datei: `Datei > Neu` oder verwenden Sie die Tastenkombination `Strg+N`.
2. Schreiben Sie ein einfaches Programm:
    
    ```python
    print("Hallo, Welt!")
    ```
    
3. Speichern Sie die Datei: `Datei > Speichern unter` und geben Sie einen Namen mit der Endung `.py` an, z. B. `hallo.py`.
4. Führen Sie den Code aus: Klicken Sie auf den grünen „Start“-Button oder drücken Sie `F5`.
5. Sehen Sie sich die Ausgabe im Shell-Fenster an.
## 4. Debugging und Fehlerbehebung

Thonny bietet integrierte Debugging-Tools:

1. **Breakpoints setzen**: Klicken Sie auf die Zeilennummer im Editor, um einen Breakpoint zu setzen.
2. **Schrittweises Debuggen**: Klicken Sie auf die Debug-Schaltfläche (Käfer-Symbol) oder verwenden Sie `F6` für den nächsten Schritt.
3. **Variablen verfolgen**: Im Variablen-Fenster sehen Sie, wie sich die Werte der Variablen während der Ausführung ändern.
## 5. Arbeiten mit Paketen
Wenn Sie externe Python-Bibliotheken installieren möchten, können Sie dies direkt in Thonny tun:

1. Öffnen Sie das Menü: `Werkzeuge > Pakete verwalten`.
2. Geben Sie den Namen des gewünschten Pakets ein, z. B. `numpy`.
3. Klicken Sie auf `Installieren`, und Thonny kümmert sich um den Rest.
## 6. Autovervollständigung und Syntax-Hervorhebung
- Thonny bietet Autovervollständigung: Wenn Sie z. B. `pri` schreiben und die `Tab`-Taste drücken, wird `print` automatisch vervollständigt.
- Syntax-Hervorhebung hilft Ihnen, Fehler schneller zu erkennen, da Keywords, Variablen und Strings farblich hervorgehoben werden.
## 7. Erweiterte Funktionen für Anfänger
1. **Python-Interpreter wechseln**: 
	- Thonny unterstützt verschiedene Python-Versionen. 
	  Sie können den Interpreter unter `Werkzeuge > Einstellungen > Interpreter` ändern.
2. **Schrittweise Variablenverfolgung**: 
	- Mit `Ansicht > Variablen` können Sie den Wert von Variablen in Echtzeit überwachen.
3. **Einfache Darstellung von Ausdrücken**: 
	- Thonny zeigt Ihnen bei der Ausführung eines Programms, wie Python intern arbeitet, was besonders für Anfänger nützlich ist.
## 8. Zusammenfassung der wichtigsten Tastenkombinationen

|Aktion|Tastenkombination|
|---|---|
|Neues Skript erstellen|`Strg+N`|
|Skript öffnen|`Strg+O`|
|Skript speichern|`Strg+S`|
|Skript ausführen|`F5`|
|Debuggen starten|`F6`|

## 9. Häufige Anfängerfehler
- **Speichern vergessen**: 
	- Stellen Sie sicher, dass Sie Ihr Skript speichern, bevor Sie es ausführen.
- **Falscher Interpreter**: 
	- Achten Sie darauf, dass der richtige Python-Interpreter ausgewählt ist.
- **IndentationError**: 
	- Python benötigt korrekte Einrückungen. 
	  Achten Sie darauf, Leerzeichen oder Tabs konsistent zu verwenden.
