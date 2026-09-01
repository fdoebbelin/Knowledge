# M01 – FreeCAD Grundlagen

> [!info] Modulinfo
> **Dauer:** 45 min | **Abhängigkeit:** – | **Nächstes Modul:** [[M02 – Sketcher Grundlagen]]
> Kurs: [[M00 FreeCAD Intensivkurs – Kursstruktur]]

**Lernziel:** Benutzeroberfläche sicher bedienen, 3D-Navigation beherrschen, erstes Dokument anlegen und speichern.

---

## 1 · Einführung & Demonstration

### 1.1 Die FreeCAD-Oberfläche

FreeCAD startet mit einer leeren Arbeitsfläche. Die Oberfläche besteht aus fünf festen Bereichen:

| Bereich | Position | Funktion |
|---|---|---|
| **Menüleiste** | oben | Zugriff auf alle Befehle |
| **Symbolleisten** | oben / seitlich | Schnellzugriff auf häufige Befehle der aktiven Workbench |
| **Modellbaum** | links | Hierarchische Liste aller Objekte und Features des Dokuments |
| **3D-Ansicht** | Mitte | Interaktive Darstellung des Modells |
| **Aufgabenbereich** | links (kontextuell) | Eingabefelder und Optionen des aktiven Befehls |

> [!tip]
> Der **Modellbaum** (auch *Model Tree*) ist das Herzstück des parametrischen Arbeitens: Er zeigt die Entstehungsgeschichte eines Modells und erlaubt das nachträgliche Bearbeiten jedes Schritts.

---

### 1.2 Workbench-Konzept

Eine **Workbench** (Arbeitsumgebung) bündelt alle Werkzeuge für einen bestimmten Aufgabenbereich. Symbolleisten und Menüs passen sich beim Wechsel automatisch an.

Wechsel über das **Workbench-Auswahlmenü** oben links (Dropdown mit Arbeitsumgebungsname).

Im Kurs relevante Workbenches:

| Workbench | Zweck |
|---|---|
| *Sketcher* | 2D-Skizzen erstellen |
| *Part Design* | Parametrische 3D-Volumenkörper |
| *Assembly* | Baugruppen aus Einzelteilen |
| *TechDraw* | Technische Zeichnungen ableiten |

> [!info]
> Ohne geöffnetes Dokument sind die meisten Workbenches inaktiv. Erst nach `Datei → Neues Dokument` werden alle Werkzeuge verfügbar.

---

### 1.3 3D-Navigation

- FreeCAD verwendet standardmäßig den **CAD-Navigationsstil**. 
- Die **Blender-Navigation** ist in FreeCAD die ergonomischste Option, weil Pan mit `Shift + Mitteltaste` oder mit `beiden Maustasten` funktioniert statt dem unintuitiven Mittel-+Rechtstaste-Kombination der Standardsteuerung.
- Alle Aktionen erfolgen mit der Maus direkt in der 3D-Ansicht.

#### Maussteuerung

| Aktion                | Eingabe                                      |
| --------------------- | -------------------------------------------- |
| **Drehen**            | `Mitteltaste` gedrückt halten + bewegen      |
| **Zoomen**            | `Scrollrad`                                  |
| **Verschieben (Pan)** | `beide Maustasten` gedrückt halten + Bewegen |
| **Objekt auswählen**  | `Linksklick`                                 |
| **Mehrfachauswahl**   | `Strg` + Linksklick                          |

#### Standardansichten (Numpad)

| Kürzel | Ansicht |
|---|---|
| `Num 1` | Vorderansicht |
| `Num 3` | Rechte Seitenansicht |
| `Num 7` | Draufsicht |
| `Num 9` | Rückansicht |
| `Num 5` | Perspektive ↔ Orthogonal umschalten |
| `V`, `F` | Ansicht auf Auswahl einpassen |
| `V`, `A` | Alle Objekte einpassen |

> [!tip]
> `Num 5` umschalten lohnt sich: **Orthogonale Projektion** (kein Fluchtpunkt) ist für technische Arbeit präziser; **Perspektive** wirkt räumlicher und hilft beim Orientieren.

---

### 1.4 Dokument anlegen, speichern, öffnen

FreeCAD speichert im proprietären Format `.FCStd` (ein ZIP-Archiv mit XML und Ressourcen).

**Neues Dokument anlegen:**
```
Datei → Neues Dokument        (Strg+N)
```

**Dokument speichern:**
```
Datei → Speichern             (Strg+S)
Datei → Speichern unter …     (Strg+Shift+S)
```

**Dokument öffnen:**
```
Datei → Öffnen …              (Strg+O)
```

---

### 1.5 Einheiten und Voreinstellungen

FreeCAD arbeitet standardmäßig in **Millimetern**. Für den Kurs bleibt diese Einstellung unverändert.

Voreinstellungen öffnen:
```
Bearbeiten → Einstellungen …
```

Relevante Einstellungen für den Kursstart:

- `Allgemein → Einheiten` → Einheitenschema: **Standard (mm/kg/s/°)**
- `Anzeige → 3D-Ansicht` → Navigationsstil: **CAD**

> [!warning]
> Einheitenschema **vor** dem ersten Modellieren prüfen. Eine nachträgliche Änderung skaliert keine bestehenden Maße um – es ändern sich nur die angezeigten Einheitenbezeichnungen.

---

### 1.6 Demonstration: Erstes Dokument

**Ziel:** Neues Dokument anlegen, Ansichten erkunden, speichern.

1. FreeCAD starten → Startseite schließen (× im Tab)
2. `Datei → Neues Dokument` → Im Modellbaum erscheint `Unnamed`
3. Workbench *Part Design* wählen → Symbolleisten wechseln
4. Numpad-Tasten `Num 1`, `Num 3`, `Num 7` drücken → Ansicht wechselt
5. `Num 5` drücken → Perspektive ↔ Orthogonal
6. `Strg+S` → Speicherdialog → Dateinamen `kurs_m01` vergeben → Speichern
7. Titelleiste zeigt jetzt `kurs_m01.FCStd`

---

## 2 · Übungen

### Übung 1 – Oberfläche erkunden *(ca. 10 min)*

**Ziel:** Alle fünf UI-Bereiche identifizieren und die Workbench wechseln.

**Schritte:**
1. FreeCAD starten, neues Dokument anlegen (`Strg+N`)
2. Zeige auf jeden der fünf UI-Bereiche und benenne ihn laut (oder schriftlich): Menüleiste, Symbolleisten, Modellbaum, 3D-Ansicht, Aufgabenbereich
3. Wechsle nacheinander die Workbench zu *Sketcher*, *Part Design*, *TechDraw* – beobachte, wie sich die Symbolleisten verändern
4. Wechsle zurück zu *Part Design*

**Erwartetes Ergebnis:** Du kannst die Bereiche benennen und weißt, wo das Workbench-Auswahlmenü sitzt.

---

### Übung 2 – Navigation beherrschen *(ca. 10 min)*

**Ziel:** Alle Navigationsaktionen flüssig ausführen.

**Vorbereitung:** Öffne die mitgelieferte Beispieldatei `beispiel_wuerfel.FCStd` (oder erstelle über `Part Design → Additiver Quader` einen einfachen Quader).

**Schritte:**
1. Drehe das Modell mit der Mitteltaste in alle Richtungen
2. Zoome mit dem Scrollrad rein und raus
3. Verschiebe die Ansicht (Mitteltaste + Rechtstaste)
4. Drücke nacheinander `Num 1`, `Num 3`, `Num 7`, `Num 9` → merke dir die Ansichten
5. Klicke eine Fläche des Quaders an → drücke `V`, `F` → Ansicht passt sich an
6. Drücke `V`, `A` → alle Objekte eingepasst
7. Wechsle mit `Num 5` zwischen Perspektive und Orthogonal

**Erwartetes Ergebnis:** Du navigierst ohne Zögern durch die 3D-Ansicht und erreichst jede Standardansicht per Numpad.

---

### Übung 3 – Dokument anlegen und konfigurieren *(ca. 10 min)*

**Ziel:** Einheiten prüfen, Dokument korrekt speichern.

**Schritte:**
1. Öffne `Bearbeiten → Einstellungen → Allgemein → Einheiten`
2. Prüfe: Einheitenschema ist **Standard (mm/kg/s/°)** – falls nicht, ändern und bestätigen
3. Prüfe: `Anzeige → 3D-Ansicht → Navigationsstil` ist **CAD**
4. Schließe die Einstellungen
5. Lege ein neues Dokument an (`Strg+N`)
6. Speichere es unter dem Namen `mein_erstes_modell` (`Strg+Shift+S`)
7. Schließe FreeCAD (`Strg+Q`) und öffne die Datei wieder (`Strg+O`)

**Erwartetes Ergebnis:** Die Datei `mein_erstes_modell.FCStd` öffnet sich korrekt, Einheiten sind auf mm gesetzt.

> [!example] Kontrollfrage
> Was ist der Unterschied zwischen orthogonaler und perspektivischer Projektion, und wann ist welche sinnvoller?
>
> *Antwort: Orthogonal hat keine Fluchtpunkte – parallele Kanten bleiben parallel, Maße sind direkt ablesbar → besser für technische Arbeit. Perspektive simuliert das menschliche Sehen → bessere räumliche Orientierung beim Erkunden.*

---

## Zusammenfassung

| Konzept | Kern |
|---|---|
| Workbench | Kontextabhängige Werkzeugsammlung – je nach Aufgabe wechseln |
| Modellbaum | Parametrische Geschichte des Modells – jeder Schritt nachträglich editierbar |
| Navigation | Mitteltaste = Drehen, Scroll = Zoom, Num-Pad = Standardansichten |
| Dateiformat | `.FCStd` – immer mit `Strg+S` regelmäßig speichern |

---

## Querverweise

- [[M02 – Sketcher Grundlagen]] – nächstes Modul
- [[Glossar FreeCAD#Workbench (Arbeitsumgebung)]]
- [[Glossar FreeCAD#Modellbaum (Model Tree)]]
- [[Cheat Sheet – Tastenkürzel]]
