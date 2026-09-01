### Vorgeschlagene Modulstruktur

```
personalprojekt/
├── main.py                          # Haupt-Einstiegspunkt
├── config/
│   ├── __init__.py
│   └── paths.py                     # Pfad-Konfiguration, UI-File-Finder
├── data/
│   ├── __init__.py
│   ├── constants.py                 # Header-Definitionen, Konstanten
│   ├── csv_handler.py              # CSV-Lese-/Schreiboperationen
│   └── models.py                    # TableModels für Qt
├── business/
│   ├── __init__.py
│   └── attendance.py               # Anwesenheits-Geschäftslogik
├── gui/
│   ├── __init__.py
│   ├── delegates.py                # ComboBox- und Regex-Delegates
│   ├── ui_loader.py               # UI-File Loading & Button wiring
│   └── dialogs/
│       ├── __init__.py
│       ├── add_person.py          # AddPersonDialog
│       ├── list_editor.py         # SingleListEditor
│       ├── employee_editor.py     # MitarbeiterEditor
│       └── attendance_editor.py   # AttendanceEditor
├── ui/                            # UI-Dateien (.ui)
└── data/                          # CSV-Dateien
```

## Detaillierte Modulbeschreibung

### config/paths.py
**Verantwortlichkeit:** Zentrale Pfadverwaltung und UI-File-Discovery
**Inhalt:**
- `SCRIPT_DIR`, `UI_DIR`, `DATA_DIR` Konstanten
- `find_ui_file()` Funktion
- Pfad-Konfiguration für CSV-Dateien

### data/constants.py
**Verantwortlichkeit:** Datenschema-Definitionen
**Inhalt:**
- `MITARBEITER_HEADERS`, `ANWESENHEIT_HEADERS`
- Validierungsregeln und Konstanten

### data/csv_handler.py
**Verantwortlichkeit:** CSV-Dateizugriff und -manipulation
**Inhalt:**
- `ensure_file_with_header()`
- `read_csv_rows()`, `write_csv_rows()`
- `read_single_column_values()`, `write_single_column_values()`
- `ensure_all_csvs()`

### data/models.py
**Verantwortlichkeit:** Qt TableModel-Implementierungen
**Inhalt:**
- `MitarbeiterTableModel`
- `AttendanceTableModel`
- `_SingleListModel`

### business/attendance.py
**Verantwortlichkeit:** Anwesenheits-Geschäftslogik
**Inhalt:**
- `generate_attendance_for_person()`
- `remove_attendance_for_person()`
- Weitere Anwesenheits-Validierungen

### gui/delegates.py
**Verantwortlichkeit:** Custom Qt-Delegates
**Inhalt:**
- `ComboBoxDelegate`
- `RegexDelegate`

### gui/dialogs/*.py
**Verantwortlichkeit:** Dialog-Implementierungen (getrennt nach Funktionalität)
- Jede Dialog-Klasse in eigener Datei
- Bessere Wartbarkeit und Testbarkeit

### gui/ui_loader.py
**Verantwortlichkeit:** UI-Loading und Event-Verdrahtung
**Inhalt:**
- `load_ui_mainwindow()`
- `wire_main_buttons()`

### main.py (neu)
**Verantwortlichkeit:** Anwendungs-Einstiegspunkt
**Inhalt:**
```python
import sys
from PySide6.QtWidgets import QApplication

from config.paths import ensure_all_csvs
from gui.ui_loader import load_ui_mainwindow, wire_main_buttons

def main():
    ensure_all_csvs()
    app = QApplication(sys.argv)
    
    win = load_ui_mainwindow()
    wire_main_buttons(win)
    
    win.show()
    return app.exec()

if __name__ == "__main__":
    sys.exit(main())
```

## Modulimporte in der neuen Struktur

### Hauptimport-Abhängigkeiten:

```python
# main.py
from config.paths import ensure_all_csvs
from gui.ui_loader import load_ui_mainwindow, wire_main_buttons

# gui/ui_loader.py
from gui.dialogs.employee_editor import MitarbeiterEditor
from gui.dialogs.attendance_editor import AttendanceEditor
from gui.dialogs.list_editor import SingleListEditor

# gui/dialogs/employee_editor.py
from data.models import MitarbeiterTableModel
from data.csv_handler import read_single_column_values
from gui.delegates import ComboBoxDelegate, RegexDelegate
from gui.dialogs.add_person import AddPersonDialog
from business.attendance import remove_attendance_for_person

# gui/dialogs/add_person.py
from data.csv_handler import read_csv_rows, write_csv_rows, read_single_column_values
from data.constants import MITARBEITER_HEADERS
from business.attendance import generate_attendance_for_person

# data/models.py
from PySide6.QtCore import QAbstractTableModel
from data.csv_handler import read_csv_rows, write_csv_rows
from data.constants import MITARBEITER_HEADERS, ANWESENHEIT_HEADERS

# business/attendance.py
from data.csv_handler import read_csv_rows, write_csv_rows
from data.constants import ANWESENHEIT_HEADERS
from config.paths import ANWESENHEIT_CSV
```

## Vorteile der Modularisierung

1. **Separation of Concerns:** Jedes Modul hat eine klar definierte Verantwortlichkeit
2. **Bessere Testbarkeit:** Einzelne Module können isoliert getestet werden
3. **Wartbarkeit:** Änderungen sind lokal begrenzt und beeinflussen nicht das gesamte System
4. **Wiederverwendbarkeit:** Module können in anderen Projekten wiederverwendet werden
5. **Entwicklerfreundlichkeit:** Kleinere Dateien sind einfacher zu verstehen und zu bearbeiten
6. **Erweiterbarkeit:** Neue Features können einfacher hinzugefügt werden

## Migrationsplan

1. **Schritt 1:** Verzeichnisstruktur erstellen und `__init__.py` Dateien hinzufügen
2. **Schritt 2:** `config/paths.py` extrahieren und testen
3. **Schritt 3:** `data/constants.py` und `data/csv_handler.py` extrahieren
4. **Schritt 4:** TableModels in `data/models.py` verschieben
5. **Schritt 5:** Delegates in `gui/delegates.py` extrahieren
6. **Schritt 6:** Dialoge einzeln in separate Dateien aufteilen
7. **Schritt 7:** UI-Loader extrahieren und `main.py` vereinfachen
8. **Schritt 8:** Imports anpassen und vollständig testen