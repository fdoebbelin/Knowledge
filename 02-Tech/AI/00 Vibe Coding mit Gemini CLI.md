**Programmieren ohne Code zu schreiben – genau das verspricht Vibe Coding mit Googles Gemini CLI.** Dieses Tutorial zeigt Schritt für Schritt, wie man auf einem Windows-10/11-Rechner die gesamte Toolchain einrichtet und mit natürlicher Sprache funktionierende Python-Programme erzeugt. Die Kombination aus dem Paketmanager Scoop, Node.js und Googles kostenlosem KI-Agenten im Terminal macht den Einstieg so niedrigschwellig wie nie: Wer tippen und beschreiben kann, kann „programmieren". Im Folgenden werden alle Installationsschritte, Befehle und fünf konkrete Anfängerprojekte detailliert erklärt.

---

## Was Vibe Coding ist und warum es alles verändert

Der Begriff **Vibe Coding** wurde am **6. Februar 2025** von **Andrej Karpathy** geprägt – Mitgründer von OpenAI und ehemaliger KI-Chef bei Tesla. In einem vielbeachteten Post auf X schrieb er:

> *„There's a new kind of coding I call 'vibe coding', where you fully give in to the vibes, embrace exponentials, and forget that the code even exists."*

Die Idee ist radikal einfach: Man beschreibt in natürlicher Sprache, was ein Programm tun soll, und eine KI generiert den vollständigen Code. Man testet das Ergebnis, gibt Feedback, und die KI verbessert den Code – ein iterativer Kreislauf aus **Beschreiben → Generieren → Testen → Verfeinern**. Collins Dictionary wählte „Vibe Coding" zum **Wort des Jahres 2025**.

Der entscheidende Unterschied zum klassischen Programmieren: Statt Syntax, Datentypen und Algorithmen zu lernen, formuliert man seine Wünsche als Prompt. Die Rolle wechselt vom Code-Schreiber zum **Code-Dirigenten**. Das bedeutet nicht, dass Programmierkenntnisse wertlos werden – im Gegenteil: Wer versteht, was der generierte Code tut, kann ihn besser steuern und Fehler schneller erkennen. Für Anfänger senkt Vibe Coding die Einstiegshürde jedoch dramatisch.

**Der typische Vibe-Coding-Workflow mit Gemini CLI sieht so aus:**

1. Man öffnet das Terminal und startet Gemini CLI im Projektordner
2. Man beschreibt das gewünschte Programm in natürlicher Sprache
3. Gemini analysiert die Anfrage, erstellt einen Plan und generiert die Dateien
4. Man testet das Ergebnis und gibt Feedback („Das funktioniert, aber füge bitte noch Fehlerbehandlung hinzu")
5. Gemini überarbeitet den Code – dieser Zyklus wiederholt sich, bis das Ergebnis stimmt

---

## Scoop installieren: Der Paketmanager für Windows

Bevor Gemini CLI läuft, braucht man **Node.js** – und der sauberste Weg, Entwicklerwerkzeuge unter Windows zu installieren, ist der Paketmanager **Scoop**. Scoop installiert Software portabel im Benutzerverzeichnis (`C:\Users\<Name>\scoop`), benötigt **keine Administratorrechte**, erzeugt keine UAC-Popups und verwaltet PATH-Einträge automatisch.

### Scoop in zwei Schritten installieren

PowerShell öffnen (als **normaler Benutzer**, nicht als Administrator) und diese beiden Befehle ausführen:

```powershell
# Schritt 1: Execution Policy setzen (einmalig)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Bei der Sicherheitsabfrage mit **Y** bestätigen. Dann:

```powershell
# Schritt 2: Scoop installieren
irm get.scoop.sh | iex
```

Nach wenigen Sekunden ist Scoop einsatzbereit. Falls der Windows-Benutzername Umlaute enthält, empfiehlt sich ein benutzerdefinierter Pfad:

```powershell
$env:SCOOP='C:\Scoop'
irm get.scoop.sh | iex
```

### Die drei wichtigsten Pakete installieren

Für das Gemini-CLI-Setup braucht man **Git**, **Node.js** und **Python**. Alle drei lassen sich in einem einzigen Befehl installieren:

```powershell
scoop install git nodejs python
```

Scoop installiert automatisch die jeweils neueste stabile Version. Nach der Installation lässt sich alles sofort prüfen:

```powershell
node --version    # Erwartet: v20.x oder höher
npm --version     # npm wird mit Node.js mitgeliefert
python --version  # Erwartet: Python 3.x
git --version     # Erwartet: git 2.x
```

### Die wichtigsten Scoop-Befehle im Überblick

| Befehl | Funktion |
|--------|----------|
| `scoop search <name>` | Nach Paketen suchen |
| `scoop install <paket>` | Paket installieren |
| `scoop update *` | Alle Pakete aktualisieren |
| `scoop list` | Installierte Pakete anzeigen |
| `scoop uninstall <paket>` | Paket deinstallieren |
| `scoop bucket add extras` | Extras-Bucket hinzufügen (für Desktop-Apps) |
| `scoop info <paket>` | Details zu einem Paket anzeigen |
| `scoop checkup` | System auf Probleme prüfen |

Falls PowerShell nach der Installation meldet, dass `scoop` nicht erkannt wird: PowerShell-Fenster schließen und neu öffnen – der PATH wird erst in neuen Sitzungen wirksam.

---

## Gemini CLI installieren und einrichten

**Gemini CLI** ist ein von Google entwickelter, **quelloffener KI-Agent** (Apache-2.0-Lizenz), der die Gemini-Modelle direkt ins Terminal bringt. Seit dem **Launch am 25. Juni 2025** hat das Projekt auf GitHub über **96.000 Sterne** gesammelt. Die aktuelle stabile Version ist **0.32.0** (Stand März 2026). Gemini CLI nutzt einen sogenannten ReAct-Loop (Reason and Act) mit eingebauten Werkzeugen: Es kann Dateien lesen und schreiben, Shell-Befehle ausführen, im Web suchen und über das Model Context Protocol (MCP) beliebig erweitert werden.

### Installation über npm

Nachdem Node.js via Scoop installiert ist, genügt ein einziger Befehl:

```powershell
npm install -g @google/gemini-cli
```

Alternativ kann man Gemini CLI **ohne dauerhafte Installation** direkt ausführen:

```powershell
npx @google/gemini-cli
```

**Systemvoraussetzungen:** Node.js **20.0.0 oder neuer**, Windows 11 24H2+ (auf Windows 10 funktioniert es in der Praxis ebenfalls), PowerShell, mindestens **4 GB RAM** (16 GB empfohlen für komplexe Aufgaben).

**Wichtiger Hinweis:** Gemini CLI ist **nicht offiziell über Scoop** verfügbar. Einige inoffizielle Websites behaupten, `scoop install gemini-cli` funktioniere – dies konnte über offizielle Google-Quellen nicht bestätigt werden. Der empfohlene Weg unter Windows ist die Installation über npm, nachdem Node.js per Scoop installiert wurde.

### Authentifizierung und API-Zugang

Beim ersten Start öffnet sich automatisch der Browser zur Anmeldung mit dem **persönlichen Google-Konto**. Damit erhält man Zugang zum **kostenlosen Kontingent**: **60 Anfragen pro Minute**, **1.000 Anfragen pro Tag** und Zugriff auf Gemini 2.5 Pro mit einem Kontextfenster von einer Million Tokens.

Alternativ lässt sich ein **API-Key** setzen:

```powershell
# Temporär (nur aktuelle Sitzung)
$env:GEMINI_API_KEY="DEIN_API_KEY"

# Permanent (überlebt Neustarts)
setx GEMINI_API_KEY "DEIN_API_KEY"
```

Einen API-Key erzeugt man kostenlos unter [aistudio.google.com](https://aistudio.google.com). Man kann den Key auch in einer `.env`-Datei hinterlegen:

```
# Datei: ~/.gemini/.env (global) oder ./.gemini/.env (projektbezogen)
GEMINI_API_KEY="DEIN_API_KEY"
```

### Gemini CLI starten und verwenden

```powershell
gemini
```

Damit öffnet sich der **interaktive Modus** – eine REPL-Sitzung, in der man Prompts direkt eintippen kann. Die Eingabeaufforderung `>` wartet auf natürlichsprachige Anweisungen.

**Einzelnen Prompt ohne interaktiven Modus ausführen:**

```powershell
gemini "Erkläre die Architektur dieses Projekts"
```

**Eingabe per Pipe weiterleiten:**

```powershell
cat error.log | gemini "Was bedeutet dieser Fehler und wie behebe ich ihn?"
git diff | gemini "Schreibe eine Commit-Nachricht für diese Änderungen"
```

**Wichtige Startoptionen:**

| Flag | Beschreibung |
|------|-------------|
| `-m gemini-2.5-flash` | Bestimmtes Modell wählen |
| `-y` | YOLO-Modus: Alle Bestätigungen automatisch annehmen |
| `-d` | Debug-Modus |
| `-s` | Sandbox-Modus (Docker/Podman-Isolation) |
| `--version` | Versionsnummer anzeigen |

---

## Den interaktiven Modus meistern

Im interaktiven Modus stehen zahlreiche **Slash-Befehle** zur Verfügung, die man mit `/help` auflisten kann. Die wichtigsten für Einsteiger:

| Befehl | Funktion |
|--------|----------|
| `/help` | Alle verfügbaren Befehle anzeigen |
| `/model` | Modell wechseln (z. B. zu Gemini 3 Flash) |
| `/chat save` | Aktuelle Sitzung speichern |
| `/chat resume` | Gespeicherte Sitzung fortsetzen |
| `/stats` | Token-Verbrauch und Sitzungsstatistiken |
| `/clear` | Bildschirm leeren |
| `/copy` | Letzte Antwort in die Zwischenablage kopieren |
| `/init` | GEMINI.md für das aktuelle Projekt generieren |
| `/compress` | Chat-Kontext zusammenfassen, um Tokens zu sparen |
| `/quit` | Gemini CLI beenden |

Drei besonders nützliche **Eingabe-Tricks** sollte man kennen: Mit **`@pfad/zur/datei`** lässt sich der Inhalt einer Datei direkt in den Prompt einbinden – das funktioniert auch mit Bildern, PDFs und Audio. Mit **`!befehl`** führt man Shell-Befehle aus, ohne Gemini zu verlassen (z. B. `!python rechner.py`). Und **Strg+J** erzeugt einen Zeilenumbruch, ohne den Prompt abzusenden – ideal für mehrzeilige Beschreibungen.

**Berechtigungssystem:** Gemini CLI fragt vor jeder potenziell kritischen Aktion nach Erlaubnis – etwa bevor es Dateien schreibt oder Shell-Befehle ausführt. Man kann einzelne Aktionen bestätigen oder mit **Shift+Y** den YOLO-Modus für die aktuelle Sitzung aktivieren, der alle Aktionen automatisch genehmigt.

---

## Fünf Python-Projekte zum Sofort-Loslegen

Die folgenden Projekte sind speziell für absolute Anfänger ohne Programmiererfahrung konzipiert. Für jedes Projekt wird der exakte Prompt angegeben, den man in Gemini CLI eintippen kann. Der Ablauf ist immer gleich:

```powershell
mkdir mein-projekt
cd mein-projekt
gemini
```

Dann den Prompt eingeben, Gemini die Dateien erstellen lassen, und mit `!python dateiname.py` direkt testen.

### Projekt 1: Der Taschenrechner

**Prompt für Gemini CLI:**

> *Erstelle ein einfaches Python-Taschenrechner-Programm für das Terminal. Das Programm soll den Benutzer nach einer ersten Zahl fragen, dann eine Rechenart auswählen lassen (Addition, Subtraktion, Multiplikation, Division), und dann eine zweite Zahl eingeben lassen. Das Ergebnis soll angezeigt werden. Bei Division durch Null soll eine freundliche Fehlermeldung erscheinen. Nach dem Ergebnis soll gefragt werden, ob eine weitere Berechnung durchgeführt werden soll. Füge klare Kommentare in den Code ein, die erklären, was jeder Teil tut. Die Benutzeroberfläche soll auf Deutsch sein.*

**Was man dabei lernt:** Variablen, Benutzereingabe, if/else-Bedingungen, Schleifen und grundlegende Fehlerbehandlung. Das Ergebnis lässt sich sofort manuell überprüfen – wenn der Rechner 5 + 3 = 8 ausgibt, weiß man, dass der Code funktioniert.

### Projekt 2: Die To-Do-Liste

**Prompt für Gemini CLI:**

> *Erstelle eine Python-To-Do-Listen-Anwendung für das Terminal. Der Benutzer soll ein Menü sehen mit: 1) Alle Aufgaben anzeigen, 2) Neue Aufgabe hinzufügen, 3) Aufgabe als erledigt markieren, 4) Aufgabe löschen, 5) Beenden. Die Aufgaben sollen nummeriert angezeigt werden. Erledigte Aufgaben werden mit [X] markiert, offene mit [ ]. Speichere die Aufgaben in einer Datei namens 'aufgaben.txt', damit sie beim Neustart des Programms erhalten bleiben. Halte den Code einfach und füge Kommentare hinzu. Die Oberfläche soll auf Deutsch sein.*

**Was man dabei lernt:** Dateien lesen und schreiben (eine der wichtigsten Fähigkeiten überhaupt), Listen verwalten, Programmablauf mit Menüs strukturieren. Das Ergebnis ist ein Programm, das man tatsächlich im Alltag nutzen kann.

### Projekt 3: Das Zahlenratespiel

**Prompt für Gemini CLI:**

> *Erstelle ein Zahlenratespiel in Python für das Terminal. Der Computer wählt eine zufällige Zahl zwischen 1 und 100. Der Spieler muss die Zahl erraten. Nach jedem Versuch sagt das Programm, ob die Zahl zu hoch, zu niedrig oder richtig ist. Zähle die Versuche und zeige die Anzahl am Ende an. Bei weniger als 7 Versuchen: 'Ausgezeichnet!', bei weniger als 10: 'Gut gemacht!', sonst: 'Weiter üben!'. Frage nach dem Spiel, ob der Spieler nochmal spielen möchte. Fange den Fall ab, dass der Spieler einen Buchstaben statt einer Zahl eingibt. Füge Kommentare hinzu. Alles auf Deutsch.*

**Was man dabei lernt:** Das `random`-Modul importieren (erster Kontakt mit Bibliotheken), while-Schleifen, Vergleichsoperatoren und Typumwandlung. Das Spiel macht Spaß und liefert sofortiges Feedback.

### Projekt 4: Das Textabenteuer

**Prompt für Gemini CLI:**

> *Erstelle ein einfaches Textabenteuer-Spiel in Python für das Terminal. Der Spieler wacht in einem geheimnisvollen Wald auf und muss den Weg hinaus finden. Erstelle mindestens 5 verschiedene Orte (z. B. Lichtung, dunkle Höhle, Flussufer, alte Brücke, Dorf). An jedem Ort soll beschrieben werden, was der Spieler sieht, und es sollen 2-3 Auswahlmöglichkeiten angeboten werden (z. B. 'nach Norden gehen', 'Höhle betreten', 'Schlüssel aufheben'). Es soll mindestens einen Gegenstand geben, den der Spieler einsammeln und später benutzen kann. Das Spiel soll ein Gewinner-Ende (Dorf erreichen) und mindestens eine Möglichkeit zu verlieren haben (z. B. in eine Falle tappen). Mache die Beschreibungen atmosphärisch und auf Deutsch. Füge Kommentare ein.*

**Was man dabei lernt:** Dictionaries (Raumdaten), verschachtelte Bedingungen, Zustandsverwaltung (Inventar, Spielerposition) und kreatives Denken über Programmlogik. Dieses Projekt ist besonders motivierend, weil es sich wie ein echtes Spiel anfühlt.

### Projekt 5: Der Einheitenumrechner

**Prompt für Gemini CLI:**

> *Erstelle einen Python-Einheitenumrechner für das Terminal. Er soll ein Menü bieten mit: 1) Kilometer ↔ Meilen, 2) Celsius ↔ Fahrenheit, 3) Kilogramm ↔ Pfund, 4) Beenden. Nach der Kategoriewahl soll die Umrechnungsrichtung gewählt werden können (z. B. 'km zu Meilen' oder 'Meilen zu km'), dann den Wert eingeben. Das Ergebnis soll auf 2 Nachkommastellen gerundet werden. Nach jeder Umrechnung zurück zum Hauptmenü. Ungültige Eingaben mit freundlicher Meldung abfangen. Die Umrechnungsformeln sollen in Kommentaren erklärt werden. Alles auf Deutsch.*

**Was man dabei lernt:** Funktionen (jede Umrechnung als eigene Funktion), mathematische Formeln anwenden, Runden von Zahlen und saubere Programmstruktur. Das Ergebnis ist im Alltag nützlich und leicht auf weitere Einheiten erweiterbar.

---

## Tipps für bessere Prompts beim Vibe Coding

Der Unterschied zwischen einem frustrierenden und einem großartigen Vibe-Coding-Erlebnis liegt in der **Qualität der Prompts**. Fünf Prinzipien machen den Unterschied:

**Sei spezifisch statt vage.** „Schreibe ein Programm" ist zu wenig. „Erstelle ein Python-Programm für das Terminal, das den Benutzer nach seinem Namen fragt und ihn dann mit ‚Hallo, [Name]!' begrüßt" gibt Gemini genug Kontext. Je präziser die Beschreibung, desto besser das Ergebnis beim ersten Versuch.

**Zerlege komplexe Aufgaben in kleine Schritte.** Statt „Erstelle eine komplette Buchhaltungssoftware" lieber erst die Grundstruktur beschreiben, dann Feature für Feature ergänzen. Gemini CLI merkt sich den Kontext der Sitzung – man baut iterativ auf dem Bisherigen auf.

**Beschreibe das gewünschte Verhalten, nicht die Implementierung.** Statt „Verwende eine while-Schleife mit einem Counter" besser „Das Programm soll den Benutzer so lange fragen, bis er die richtige Antwort gibt, und am Ende die Anzahl der Versuche anzeigen." Die KI wählt dann selbst die passende Umsetzung.

**Nutze Fehlermeldungen als Prompts.** Wenn ein generiertes Programm einen Fehler produziert, kopiert man die Fehlermeldung direkt in Gemini CLI: „Ich bekomme diesen Fehler: [Fehlermeldung]. Bitte behebe das." Das ist einer der mächtigsten Workflows beim Vibe Coding.

**Erstelle eine GEMINI.md-Datei für wiederkehrende Anweisungen.** Im Projektordner kann man eine Datei `.gemini/GEMINI.md` anlegen, die Gemini CLI bei jedem Start automatisch liest:

```markdown
# Projektregeln
- Verwende Python 3
- Schreibe anfängerfreundlichen Code mit klaren deutschen Kommentaren
- Füge immer Fehlerbehandlung für Benutzereingaben hinzu
- Halte den Code so einfach wie möglich
```

---

## Der komplette Workflow von Null zum ersten Programm

Hier die gesamte Einrichtung und das erste Projekt als durchgehende Befehlsfolge für ein frisch installiertes Windows 10/11:

```powershell
# 1. Scoop installieren
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# 2. Entwicklerwerkzeuge installieren
scoop install git nodejs python

# 3. Gemini CLI installieren
npm install -g @google/gemini-cli

# 4. Installation prüfen
gemini --version

# 5. Projektordner anlegen und Gemini starten
mkdir C:\Projekte\mein-erstes-projekt
cd C:\Projekte\mein-erstes-projekt
gemini
```

Beim ersten Start öffnet sich der Browser zur Google-Anmeldung. Danach erscheint die Eingabeaufforderung `>`, und man kann sofort den ersten Prompt eingeben – etwa den Taschenrechner von oben. Gemini plant die Umsetzung, fragt nach Erlaubnis zum Erstellen der Datei, und wenige Sekunden später liegt ein funktionierendes Python-Skript im Projektordner. Mit `!python rechner.py` testet man es direkt in Gemini CLI.

## Fazit

Gemini CLI demokratisiert das Programmieren auf eine Weise, die vor zwei Jahren noch undenkbar war. Die Kombination aus Scoop für die saubere Windows-Einrichtung, Node.js als Laufzeitumgebung und Googles kostenlosem KI-Agenten im Terminal schafft eine Toolchain, die in **unter fünf Minuten** installiert ist. Vibe Coding ersetzt nicht das Verständnis von Programmlogik – aber es verschiebt den Einstiegspunkt radikal: Statt monatelang Syntax zu pauken, produziert man vom ersten Tag an lauffähige Programme. Die fünf vorgestellten Projekte – vom Taschenrechner bis zum Textabenteuer – sind bewusst so gewählt, dass sie fundamentale Konzepte abdecken und gleichzeitig Erfolgserlebnisse liefern. Der wichtigste Ratschlag zum Schluss: **Einfach anfangen.** Den ersten Prompt eintippen, das Ergebnis testen, iterieren. So lernt man Vibe Coding am schnellsten.