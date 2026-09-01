## Import des `datetime`-Moduls

Um das Modul zu verwenden, müssen wir es zuerst importieren:

```python
import datetime
```
## 1. Das aktuelle Datum und die Uhrzeit

Mit `datetime.datetime.now()` das aktuelle Datum und die aktuelle Uhrzeit abrufen:

```python
import datetime

# Aktuelles Datum und Uhrzeit
jetzt = datetime.datetime.now()
print("Jetzt:", jetzt)

# Nur das aktuelle Datum
heute = datetime.date.today()
print("Heutiges Datum:", heute)
```
## 2. Erstellen eines Datums oder einer Uhrzeit

Ein Datum oder eine Uhrzeit manuell erstellen:

```python
# Datum erstellen: Jahr, Monat, Tag
datum = datetime.date(2025, 1, 1)
print("Manuell erstelltes Datum:", datum)

# Datum und Uhrzeit erstellen: Jahr, Monat, Tag, Stunde, Minute, Sekunde
datum_zeit = datetime.datetime(2025, 1, 1, 12, 30, 45)
print("Manuell erstelltes Datum und Uhrzeit:", datum_zeit)
```
## 3. Zugriff auf einzelne Komponenten

Einzelne Teile des Datums oder der Uhrzeit abrufen:

```python
jetzt = datetime.datetime.now()

print("Jahr:", jetzt.year)
print("Monat:", jetzt.month)
print("Tag:", jetzt.day)
print("Stunde:", jetzt.hour)
print("Minute:", jetzt.minute)
print("Sekunde:", jetzt.second)
```
## 4. Zeitdifferenzen (Timedelta)

Mit `datetime.timedelta` können Zeitspannen berecht werden:

```python
# Ein timedelta von 7 Tagen
delta = datetime.timedelta(days=7)

heute = datetime.date.today()
in_sieben_tagen = heute + delta
vor_sieben_tagen = heute - delta

print("Heute:", heute)
print("In 7 Tagen:", in_sieben_tagen)
print("Vor 7 Tagen:", vor_sieben_tagen)
```
## 5. Formatierung von Datum und Zeit

Mit der Methode `.strftime()` können Datum und Uhrzeit formatiert werden:

```python
jetzt = datetime.datetime.now()

# Beispiele für Formatierung
print("Standardformat:", jetzt)
print("Formatiert:", jetzt.strftime("%d.%m.%Y %H:%M:%S"))

# Einige häufige Platzhalter:
# %Y - Jahr (vierstellig)
# %m - Monat (zweistellig)
# %d - Tag (zweistellig)
# %H - Stunde (24-Stunden-Format)
# %M - Minute
# %S - Sekunde
```
## 6. Konvertierung von Strings zu Datum/Zeit

Mit `datetime.datetime.strptime()` können Strings in Datum/Zeit umwandelt werden

```python
datum_string = "09.01.2025 14:30:00"
format = "%d.%m.%Y %H:%M:%S"

# String zu datetime
datum_zeit = datetime.datetime.strptime(datum_string, format)
print("Konvertiertes Datum und Zeit:", datum_zeit)
```
## 7. Zeitzonen (Optional, mit `pytz`)

Für Zeitzonenunterstützung kann die Bibliothek `pytz` verwendet werden:

```python
import pytz

# Zeitzonen abrufen
utc = datetime.datetime.now(pytz.UTC)
berlin = utc.astimezone(pytz.timezone('Europe/Berlin'))

print("UTC:", utc)
print("Berlin:", berlin)
```