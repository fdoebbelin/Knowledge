# 👑 PersonalPrinz

[[8262143846de13a055bc76fecd00266a_MD5.svg|Open: 52d7c8a8c47838a1a4fd65212f48bacb_MD5.svg]]
![](_resources/8262143846de13a055bc76fecd00266a_MD5.svg)](https://www.python.org)
[[2208f165df32d363d52e54eadde00457_MD5.svg|Open: 0d356e72fcfaae41be0d7adf6fad1c69_MD5.svg]]
![](_resources/2208f165df32d363d52e54eadde00457_MD5.svg)](https://opensource.org/licenses/MIT)
[![Tests](https://github.com/username/personalprinz/workflows/tests/badge.svg)](https://github.com/username/personalprinz/actions)

**PersonalPrinz** ist ein portables Python-Tool zur Verwaltung von Mitarbeiterdaten, Urlaubsansprüchen und Arbeitszeitkonten.  
Es bietet eine einfache GUI (tkinter), speichert Daten lokal in CSV und kann optional an SharePoint angebunden werden.

---

## 📑 Inhaltsverzeichnis

- [Installation](#installation)
- [Verwendung](#verwendung)
- [Beispiele](#beispiele)
- [API-Dokumentation](#api-dokumentation)
- [Mitwirken](#mitwirken)
- [Tests](#tests)
- [Roadmap](#roadmap)
- [FAQ](#häufig-gestellte-fragen-faq)
- [Lizenz](#lizenz)
- [Danksagungen](#danksagungen)
- [Kontakt](#kontakt)

---

## ⚙️ Installation

### Voraussetzungen

- Python 3.8 oder höher  
- Module: `tkinter`, `csv` oder `pandas`  
- Optional: `office365-rest-python-client` für SharePoint

### Via pip installieren

```bash
pip install personalprinz
```

### Aus den Quellen installieren

```bash
git clone https://github.com/username/personalprinz.git
cd personalprinz
pip install -r requirements.txt
pip install -e .
```

---

## 🚀 Verwendung

### Grundlegende Verwendung

```python
from personalprinz.model import Mitarbeiter, Personalverwaltung

m = Mitarbeiter("1001", "Müller", "Hans", "Vollzeit")
m.urlaub_buchen(5)
print(m.resturlaub())  # 25
```

### GUI starten

```bash
cd personalprinz
python main.py
```

### Kommandozeile

```bash
python -m personalprinz --help
python -m personalprinz --user 1001
```

---

## 💡 Beispiele

### Beispiel 1: Mitarbeiter anlegen und buchen

```python
from personalprinz.model import Mitarbeiter

m = Mitarbeiter("1002", "Schmidt", "Lisa", "Teilzeit")
m.stunden_buchen(3.5)
print(f"{m.vorname} hat {m.stundenkonto} Stunden im Konto.")
```

### Beispiel 2: Daten aus CSV laden

```python
from personalprinz.model import Personalverwaltung

v = Personalverwaltung()
v.lade_aus_csv("users.csv")
print(v.suche_mitarbeiter("1001"))
```

---

## 📚 API-Dokumentation

### Klassen

#### `Mitarbeiter`

- Attribute: `personalnummer`, `name`, `vorname`, `arbeitsmodell`, `urlaub_total`, `urlaub_genommen`, `stundenkonto`  
- Methoden:  
  - `urlaub_buchen(tage)` → bool  
  - `stunden_buchen(stunden)` → None  
  - `resturlaub()` → int  

#### `Personalverwaltung`

- Attribute: `mitarbeitende` (Liste von `Mitarbeiter`)  
- Methoden:  
  - `add_mitarbeiter(mitarbeiter)`  
  - `suche_mitarbeiter(personalnummer)`  
  - `lade_aus_csv(dateiname)`  

---

## 🤝 Mitwirken

Beiträge sind willkommen! Bitte lies unsere [CONTRIBUTING.md](../../02-Tech/Terminal/Nushell/nu-scripts/CONTRIBUTING.md).

### Entwicklung

```bash
git clone https://github.com/username/personalprinz.git
cd personalprinz
python -m venv venv
source venv/bin/activate   # Linux/Mac
# venv\Scripts\activate    # Windows

pip install -r requirements-dev.txt
pip install -e .
pre-commit install
```

Code-Stil: Black, isort, flake8, mypy

---

## 🧪 Tests

```bash
pytest
pytest --cov=personalprinz
pytest tests/test_model.py::TestMitarbeiter::test_urlaub_buchen
```

---

## 🛣️ Roadmap

- [ ] Erweiterte Arbeitszeitmodelle (Schicht, Sabbatical)  
- [ ] Abwesenheits- und Krankmeldungsverwaltung  
- [ ] Rollen & Rechte (Admin, Mitarbeiter)  
- [ ] Import/Export zu HR-Systemen  
- [ ] Mobile/Web-Oberfläche  
- [ ] Automatisierte Auswertungen  
- [ ] ML-Analysen für Zeitreihen  

---

## ❓ Häufig gestellte Fragen (FAQ)

**Welche Python-Version wird unterstützt?**  
→ Python 3.8 und höher.  

**Wie speichere ich Daten zentral?**  
→ Optional über SharePoint-Integration.  

---

## 📜 Lizenz

Dieses Projekt steht unter der MIT-Lizenz – siehe [LICENSE](../../02-Tech/Terminal/Nushell/nu-scripts/LICENSE.md).

---

## 🙏 Danksagungen

- Inspiration: interne Projektidee „AfuZ“  
- Klassenkonzept: Projektunterlagen  

---

## 📬 Kontakt

**Autor:** Christopher  
**E-Mail:** deine.email@example.com  
**GitHub:** [@dein-username](https://github.com/dein-username)  

---

⭐ Starte das Repository, wenn es dir gefällt!