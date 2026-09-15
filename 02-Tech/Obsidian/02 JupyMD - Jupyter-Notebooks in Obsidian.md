JupyMD ist ein Obsidian-Plugin, das gewöhnliche Markdown-Notizen in ausführbare
Jupyter-Notebooks verwandelt. Code-Blöcke werden direkt in Obsidian ausgeführt,
Ausgaben und Plots erscheinen unterhalb der Zelle und bleiben auch nach einem
Neustart erhalten. Die Synchronisation zwischen der `.md`-Notiz und der
zugehörigen `.ipynb`-Datei erfolgt automatisch beim Speichern.

Nushell und `uv` sind bereits installiert. Python wird über eine `uv`-verwaltete
Umgebung namens `.jupymd` bereitgestellt, die direkt im Vault-Stammverzeichnis
liegt – genau dort, wo JupyMD sie erwartet.

---

## 1. Plugin installieren

In Obsidian: *Einstellungen → Community-Plugins → Durchsuchen* → nach **JupyMD**
suchen → installieren → aktivieren.

Den „Run Quick Setup"-Button auf der Plugin-Einstellungsseite **nicht** drücken –
dieser setzt pyenv voraus, das hier nicht verwendet wird.

---

## 2. Python-Umgebung einrichten

Die Umgebung wird einmalig im Vault-Stammverzeichnis angelegt. Der Name `.jupymd`
entspricht exakt dem, den JupyMD intern erwartet.

```nu
# In den Vault-Ordner wechseln
cd pfad\zum\obsidian-vault

# Vorhandenes .jupymd entfernen, falls fehlerhaft angelegt
rm --recursive --force .jupymd

# Neue uv-Umgebung mit diesem Namen anlegen
uv venv .jupymd --python 3.13

# Alle benötigten Pakete installieren
uv pip install jupytext matplotlib jupyter ipykernel --python (
    if $nu.os-info.name == "windows" { '.jupymd\Scripts\python.exe' } else { '.jupymd/bin/python' }
)
```

Den Interpreter-Pfad für den nächsten Schritt direkt ausgeben lassen:

```nu
uv run --python (if $nu.os-info.name == "windows" { '.jupymd\Scripts\python.exe' } else { '.jupymd/bin/python' }) python -c "import sys; print(sys.executable)"
```

---

## 3. Interpreter in JupyMD eintragen

In Obsidian: *Einstellungen → JupyMD → Python Interpreter Path* – dort eintragen:

```
pfad\zum\obsidian-vault\.jupymd\Scripts\python.exe
```

Obsidian anschließend neu starten. Den „Install Libraries"-Button weiterhin
**nicht** drücken – alle Pakete sind bereits installiert.

---

## 4. Neue Notiz als Notebook nutzen

Eine neue Notiz in Obsidian anlegen und Python-Code in normalen Code-Blöcken
schreiben:

````markdown
## Mein erstes Notebook

```python
x = 10
y = 20
print(x + y)
```

```python
import matplotlib.pyplot as plt
plt.plot([1, 2, 3], [4, 5, 6])
plt.show()
```
````

Dann über die Obsidian-Befehlspalette (`Strg+P`) den Befehl ausführen:

```
JupyMD: Convert note to Jupyter Notebook
```

JupyMD legt daraufhin eine gleichnamige `.ipynb`-Datei im selben Ordner an und
verwandelt die Code-Blöcke in ausführbare Zellen. Ab diesem Moment sind die
`.md`-Notiz und die `.ipynb`-Datei bidirektional synchronisiert – Änderungen in
einer Datei werden beim Speichern automatisch in die andere übertragen.

---

## 5. Code ausführen

Einen Code-Block in der Obsidian-Notiz anklicken und ausführen über:

- den **Play-Button**, der oberhalb des Code-Blocks erscheint, oder
- die Befehlspalette (`Strg+P`): `JupyMD: Run Code Block`

Die Ausgabe erscheint direkt unterhalb des Blocks. Plots aus `matplotlib` werden
als Bild gerendert. Variablen und Imports aus einem Block sind in allen
nachfolgenden Blöcken der Notiz weiterhin bekannt – genau wie in einem
klassischen Jupyter-Notebook.

---

## 6. Vorhandenes `.ipynb`-Notebook importieren

Ein bestehendes Notebook in den Vault-Ordner verschieben, dann in der
Befehlspalette:

```
JupyMD: Convert Jupyter Notebook to note
```

JupyMD zeigt eine Liste aller `.ipynb`-Dateien im Vault. Nach der Auswahl wird
eine gleichnamige `.md`-Notiz erstellt und die bidirektionale Synchronisation
automatisch eingerichtet.

In Nushell lassen sich alle Notebooks im Vault schnell auflisten:

```nu
ls **/*.ipynb
```

---

## 7. Gleichzeitig in JupyterLab arbeiten

JupyMD und JupyterLab können parallel genutzt werden. JupyterLab wird direkt
aus dem Vault-Ordner gestartet, damit es die `.jupymd`-Umgebung und alle
Notebooks findet:

```nu
cd pfad\zum\obsidian-vault
uv run --python .jupymd\Scripts\python.exe jupyter lab
```

Da beide Werkzeuge über Jupytext auf dieselbe `.ipynb`-Datei schreiben, bleiben
Obsidian und JupyterLab automatisch synchron. Es empfiehlt sich, eine Datei
nicht gleichzeitig in beiden Umgebungen offen zu haben, um Schreibkonflikte
zu vermeiden.

---

## 8. Weitere Pakete nachinstallieren

Neue Python-Pakete werden direkt in die `.jupymd`-Umgebung installiert und
stehen anschließend sofort in allen Notizen zur Verfügung:

```nu
uv pip install --python .jupymd\Scripts\python.exe paketname
```

Beispiel für `numpy` und `pandas`:

```nu
uv pip install --python .jupymd\Scripts\python.exe numpy pandas
```

---

## 9. Übersicht: Obsidian-Befehle von JupyMD

Alle Befehle sind über die Befehlspalette (`Strg+P`) erreichbar:

| Befehl | Was passiert |
|---|---|
| `JupyMD: Convert note to Jupyter Notebook` | Erstellt eine `.ipynb`-Datei und aktiviert die Synchronisation |
| `JupyMD: Convert Jupyter Notebook to note` | Importiert ein `.ipynb` als Markdown-Notiz |
| `JupyMD: Run Code Block` | Führt den aktuellen Code-Block aus |
| `JupyMD: Run All Code Blocks` | Führt alle Blöcke der Notiz der Reihe nach aus |
| `JupyMD: Clear Outputs` | Entfernt alle Ausgaben aus der Notiz |
| `JupyMD: Open in JupyterLab` | Öffnet die verknüpfte `.ipynb`-Datei in JupyterLab |

---

## 10. Dateistruktur im Vault

Nach der Einrichtung sieht die Ordnerstruktur im Vault typischerweise so aus:

```
obsidian-vault\
├── .jupymd\               ← uv-verwaltete Python-Umgebung
│   └── Scripts\
│       └── python.exe     ← Interpreter-Pfad für JupyMD
├── .obsidian\             ← Obsidian-Konfiguration
├── meine-notiz.md         ← Markdown-Notiz (wird in Obsidian bearbeitet)
└── meine-notiz.ipynb      ← verknüpftes Notebook (automatisch synchronisiert)
```

Die `.ipynb`-Dateien können ignoriert oder in einem Unterordner abgelegt werden –
die Notizen in Obsidian bleiben in jedem Fall die führende Quelle.
