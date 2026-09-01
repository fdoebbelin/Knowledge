**Wichtiger Hinweis für JupySQL:**
- Bei Fehlern mit `%%sql` versuchen Sie: `%%sql --no-execute` zum Testen
- Oder verwenden Sie pandas als Alternative:

```python
# Robuste Alternative zu %%sql bei Problemen
df_kategorien = pd.read_sql_query("""
    SELECT 
        kategorie,
        COUNT(*) as anzahl,
        AVG(seitenzahl) as durchschnitt_seiten
    FROM buecher 
    GROUP BY kategorie
    ORDER BY anzahl DESC
""", conn)
display(df_kategorien)
```# SQL in JupyterLab - Bibliothekssystem

## Übungsziel
In diesem Notebook erstellen wir eine vollständige Datenbank für ein **Bibliothekssystem** und lernen verschiedene Wege kennen, SQL in JupyterLab zu verwenden.

## Setup-Optionen
Wir zeigen drei verschiedene Methoden:
1. **Python sqlite3** (Standard-Bibliothek)
2. **JupySQL Magic Commands** (moderne, stabile SQL-Integration)
3. **pandas Integration** (für Datenanalyse)

---

## 📦 Setup und Installation

**Moderne Lösung mit JupySQL** - die stabile, performante Alternative:

```python
# JupySQL Installation (moderne Alternative zu ipython-sql)
!pip install jupysql duckdb-engine pandas matplotlib seaborn

# Imports
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime, timedelta

print("✅ Setup erfolgreich!")
```

---
# Methode 1: Python sqlite3 (Standard)

Dies ist der traditionelle Weg, SQL in Python zu verwenden.

```python
# Verbindung zur SQLite-Datenbank erstellen
conn = sqlite3.connect('bibliothek.db')
cursor = conn.cursor()

print("📚 Verbindung zur Bibliotheks-Datenbank hergestellt!")
```

## 🏗️ Datenbankschema erstellen

```python
# Tabellen löschen falls sie existieren (für Neustart)
tables_to_drop = ['ausleihen', 'buecher', 'mitglieder', 'autoren']
for table in tables_to_drop:
    cursor.execute(f"DROP TABLE IF EXISTS {table}")

# Tabelle "autoren" erstellen
cursor.execute("""
    CREATE TABLE autoren (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vorname TEXT NOT NULL,
        nachname TEXT NOT NULL,
        geburtsjahr INTEGER,
        nationalitaet TEXT DEFAULT 'Deutschland'
    )
""")

# Tabelle "buecher" erstellen
cursor.execute("""
    CREATE TABLE buecher (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titel TEXT NOT NULL,
        isbn TEXT UNIQUE,
        erscheinungsjahr INTEGER,
        seitenzahl INTEGER,
        kategorie TEXT DEFAULT 'Roman',
        autor_id INTEGER NOT NULL,
        verfuegbar INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (autor_id) REFERENCES autoren (id)
    )
""")

# Tabelle "mitglieder" erstellen
cursor.execute("""
    CREATE TABLE mitglieder (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vorname TEXT NOT NULL,
        nachname TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        telefon TEXT,
        anmeldedatum TEXT NOT NULL,
        aktiv INTEGER NOT NULL DEFAULT 1
    )
""")

# Tabelle "ausleihen" erstellen
cursor.execute("""
    CREATE TABLE ausleihen (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        buch_id INTEGER NOT NULL,
        mitglied_id INTEGER NOT NULL,
        ausleihdatum TEXT NOT NULL,
        rueckgabedatum TEXT,
        zurueckgegeben INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (buch_id) REFERENCES buecher (id),
        FOREIGN KEY (mitglied_id) REFERENCES mitglieder (id)
    )
""")

conn.commit()
print("✅ Alle Tabellen erfolgreich erstellt!")
```

## 📝 Testdaten einfügen

```python
# Autoren einfügen
autoren_daten = [
    ('Hermann', 'Hesse', 1877, 'Deutschland'),
    ('Agatha', 'Christie', 1890, 'England'),
    ('George', 'Orwell', 1903, 'England'),
    ('Paulo', 'Coelho', 1947, 'Brasilien'),
    ('Jane', 'Austen', 1775, 'England')
]

cursor.executemany("""
    INSERT INTO autoren (vorname, nachname, geburtsjahr, nationalitaet) 
    VALUES (?, ?, ?, ?)
""", autoren_daten)

print(f"✅ {len(autoren_daten)} Autoren eingefügt!")
```

```python
# Bücher einfügen
buecher_daten = [
    ('Der Steppenwolf', '978-3-518-36675-8', 1927, 288, 'Roman', 1, 1),
    ('Mord im Orient-Express', '978-3-596-21200-4', 1934, 256, 'Krimi', 2, 1),
    ('1984', '978-3-548-23414-9', 1949, 416, 'Dystopie', 3, 1),
    ('Der Alchimist', '978-3-257-23045-1', 1988, 176, 'Roman', 4, 1),
    ('Stolz und Vorurteil', '978-3-15-000001-1', 1813, 432, 'Roman', 5, 1),
    ('Animal Farm', '978-0-452-28424-1', 1945, 128, 'Fabel', 3, 1)
]

cursor.executemany("""
    INSERT INTO buecher (titel, isbn, erscheinungsjahr, seitenzahl, kategorie, autor_id, verfuegbar) 
    VALUES (?, ?, ?, ?, ?, ?, ?)
""", buecher_daten)

print(f"✅ {len(buecher_daten)} Bücher eingefügt!")
```

```python
# Mitglieder einfügen
mitglieder_daten = [
    ('Max', 'Mustermann', 'max.mustermann@email.com', '0151-12345678', '2024-01-15', 1),
    ('Anna', 'Schmidt', 'anna.schmidt@email.com', None, '2024-02-20', 1),
    ('Tom', 'Weber', 'tom.weber@email.com', '0176-98765432', '2024-03-10', 1),
    ('Lisa', 'Müller', 'lisa.mueller@email.com', '0172-55555555', '2024-04-05', 1)
]

cursor.executemany("""
    INSERT INTO mitglieder (vorname, nachname, email, telefon, anmeldedatum, aktiv) 
    VALUES (?, ?, ?, ?, ?, ?)
""", mitglieder_daten)

print(f"✅ {len(mitglieder_daten)} Mitglieder eingefügt!")
```

```python
# Ausleihen einfügen
ausleihen_daten = [
    (1, 1, '2024-07-01', None, 0),  # Max hat "Der Steppenwolf" ausgeliehen
    (2, 2, '2024-07-10', '2024-07-20', 1),  # Anna hat "Mord im Orient-Express" zurückgegeben
    (3, 3, '2024-07-15', None, 0),  # Tom hat "1984" ausgeliehen
    (4, 4, '2024-07-18', '2024-07-25', 1)  # Lisa hat "Der Alchimist" zurückgegeben
]

cursor.executemany("""
    INSERT INTO ausleihen (buch_id, mitglied_id, ausleihdatum, rueckgabedatum, zurueckgegeben) 
    VALUES (?, ?, ?, ?, ?)
""", ausleihen_daten)

# Verfügbarkeit der ausgeliehenen Bücher aktualisieren
cursor.execute("UPDATE buecher SET verfuegbar = 0 WHERE id IN (1, 3)")

conn.commit()
print(f"✅ {len(ausleihen_daten)} Ausleihen eingefügt!")
print("🎉 Alle Testdaten erfolgreich eingefügt!")
```

## 🔍 SQL-Abfragen mit Python

```python
# Einfache Abfragen
print("📖 Alle Autoren:")
cursor.execute("SELECT * FROM autoren")
for row in cursor.fetchall():
    print(f"  {row[1]} {row[2]} ({row[3]}) - {row[4]}")

print("\n📚 Verfügbare Bücher:")
cursor.execute("""
    SELECT b.titel, a.nachname, b.kategorie 
    FROM buecher b 
    JOIN autoren a ON b.autor_id = a.id 
    WHERE b.verfuegbar = 1
""")
for row in cursor.fetchall():
    print(f"  '{row[0]}' von {row[1]} ({row[2]})")
```

```python
# Komplexere Abfrage mit JOIN
print("🏃‍♂️ Aktuelle Ausleihen:")
cursor.execute("""
    SELECT 
        m.vorname || ' ' || m.nachname AS mitglied,
        b.titel,
        a.nachname AS autor,
        au.ausleihdatum,
        CASE 
            WHEN au.zurueckgegeben = 1 THEN 'Zurückgegeben am ' || au.rueckgabedatum
            ELSE 'Noch ausgeliehen'
        END AS status
    FROM ausleihen au
    JOIN mitglieder m ON au.mitglied_id = m.id
    JOIN buecher b ON au.buch_id = b.id
    JOIN autoren a ON b.autor_id = a.id
    ORDER BY au.ausleihdatum DESC
""")

for row in cursor.fetchall():
    print(f"  {row[0]}: '{row[1]}' von {row[2]} (seit {row[3]}) - {row[4]}")
```

---
# Methode 2: JupySQL Magic Commands (Modern & Stabil)

**JupySQL** ist die moderne, stabile Alternative mit erweiterten Features und besserer Performance.

```python
# JupySQL Extension laden
%load_ext sql

# Verbindung zur SQLite-Datenbank herstellen
%sql sqlite:///bibliothek.db

print("🔗 JupySQL-Verbindung hergestellt!")
```

```python
# Einzelne SQL-Abfrage mit %sql
%sql SELECT COUNT(*) as anzahl_buecher FROM buecher;
```

```sql
-- Mehrzeilige SQL-Abfrage mit %%sql
%%sql
SELECT 
    kategorie,
    COUNT(*) as anzahl,
    AVG(seitenzahl) as durchschnitt_seiten
FROM buecher 
GROUP BY kategorie
ORDER BY anzahl DESC;
```

```python
# Ergebnis in Variable speichern (JupySQL-Syntax)
result = %sql SELECT * FROM autoren WHERE nationalitaet = 'England'

print(f"Gefundene englische Autoren: {len(result)}")
for i, row in enumerate(result):
    print(f"  {row[1]} {row[2]} ({row[3]})")
```

### **JupySQL Erweiterte Features:**

```sql
-- Query-Performance analysieren
%%sql --explain
SELECT b.titel, a.nachname 
FROM buecher b 
JOIN autoren a ON b.autor_id = a.id;
```

```python
# Automatische DataFrame-Konvertierung
%%sql --save df_buecher_kategorien
SELECT 
    kategorie,
    COUNT(*) as anzahl,
    AVG(seitenzahl) as avg_seiten,
    MIN(erscheinungsjahr) as aeltestes_jahr,
    MAX(erscheinungsjahr) as neuestes_jahr
FROM buecher 
GROUP BY kategorie;
```

```python
# Gespeicherten DataFrame verwenden
print("📊 Kategorien-Analyse:")
display(df_buecher_kategorien)
```

```sql
-- Datenvalidierung mit JupySQL
%%sql
SELECT 
    'Bücher ohne Autor' as check_name,
    COUNT(*) as fehler_anzahl
FROM buecher 
WHERE autor_id NOT IN (SELECT id FROM autoren)
UNION ALL
SELECT 
    'Ausleihen ohne gültiges Buch' as check_name,
    COUNT(*) as fehler_anzahl
FROM ausleihen 
WHERE buch_id NOT IN (SELECT id FROM buecher);
```

---
# Methode 3: pandas Integration

Perfekt für Datenanalyse und Visualisierung!

```python
# SQL-Abfrage direkt in DataFrame
df_autoren = pd.read_sql_query("""
    SELECT 
        a.*,
        COUNT(b.id) as anzahl_buecher
    FROM autoren a
    LEFT JOIN buecher b ON a.id = b.autor_id
    GROUP BY a.id, a.vorname, a.nachname, a.geburtsjahr, a.nationalitaet
    ORDER BY anzahl_buecher DESC
""", conn)

print("👥 Autoren mit Buchanzahl:")
display(df_autoren)
```

```python
# Bücher-Statistiken
df_buecher = pd.read_sql_query("""
    SELECT 
        b.*,
        a.nachname as autor_nachname,
        a.nationalitaet
    FROM buecher b
    JOIN autoren a ON b.autor_id = a.id
""", conn)

print("📊 Bücher-Übersicht:")
display(df_buecher[['titel', 'autor_nachname', 'kategorie', 'erscheinungsjahr', 'seitenzahl', 'verfuegbar']])
```

## 📈 Datenvisualisierung

```python
# Visualisierungen erstellen
fig, axes = plt.subplots(2, 2, figsize=(15, 10))
fig.suptitle('📚 Bibliotheks-Statistiken', fontsize=16, fontweight='bold')

# 1. Bücher pro Kategorie
kategorie_counts = df_buecher['kategorie'].value_counts()
axes[0,0].pie(kategorie_counts.values, labels=kategorie_counts.index, autopct='%1.1f%%')
axes[0,0].set_title('Bücher pro Kategorie')

# 2. Seitenzahl pro Buch
axes[0,1].bar(range(len(df_buecher)), df_buecher['seitenzahl'], 
              color=['red' if not x else 'green' for x in df_buecher['verfuegbar']])
axes[0,1].set_title('Seitenzahl pro Buch\n(Rot = ausgeliehen, Grün = verfügbar)')
axes[0,1].set_xticks(range(len(df_buecher)))
axes[0,1].set_xticklabels([t[:15] + '...' if len(t) > 15 else t for t in df_buecher['titel']], rotation=45)

# 3. Autoren nach Nationalität
nationalitaet_counts = df_autoren['nationalitaet'].value_counts()
axes[1,0].bar(nationalitaet_counts.index, nationalitaet_counts.values)
axes[1,0].set_title('Autoren nach Nationalität')
axes[1,0].tick_params(axis='x', rotation=45)

# 4. Erscheinungsjahre
axes[1,1].hist(df_buecher['erscheinungsjahr'], bins=10, alpha=0.7, color='skyblue')
axes[1,1].set_title('Verteilung der Erscheinungsjahre')
axes[1,1].set_xlabel('Jahr')
axes[1,1].set_ylabel('Anzahl Bücher')

plt.tight_layout()
plt.show()
```

---
# 🎯 Interaktiver Bereich - Eigene Abfragen

Probieren Sie eigene SQL-Abfragen aus!

```sql
-- Hier können Sie Ihre eigenen SQL-Abfragen schreiben!
-- Beispiel: Finden Sie alle Bücher von deutschen Autoren
%%sql
SELECT b.titel, a.vorname, a.nachname
FROM buecher b
JOIN autoren a ON b.autor_id = a.id
WHERE a.nationalitaet = 'Deutschland';
```

```python
# Oder mit pandas für weitere Analyse
user_query = """
    SELECT 
        m.vorname || ' ' || m.nachname as mitglied_name,
        COUNT(au.id) as anzahl_ausleihen,
        SUM(CASE WHEN au.zurueckgegeben = 0 THEN 1 ELSE 0 END) as aktuell_ausgeliehen
    FROM mitglieder m
    LEFT JOIN ausleihen au ON m.id = au.mitglied_id
    GROUP BY m.id, m.vorname, m.nachname
    ORDER BY anzahl_ausleihen DESC
"""

df_mitglieder_stats = pd.read_sql_query(user_query, conn)
print("👤 Mitglieder-Statistiken:")
display(df_mitglieder_stats)
```

---
# 💪 Übungsaufgaben

Lösen Sie diese Aufgaben mit SQL!

## Aufgabe 1: Neue Daten hinzufügen
Fügen Sie einen neuen Autor und ein neues Buch hinzu:

```python
# Lösung hier:
# 1. Neuen Autor hinzufügen (z.B. J.K. Rowling)
# 2. Neues Buch von diesem Autor hinzufügen

cursor.execute("""
    INSERT INTO autoren (vorname, nachname, geburtsjahr, nationalitaet) 
    VALUES ('J.K.', 'Rowling', 1965, 'England')
""")

# ID des neuen Autors abrufen
autor_id = cursor.lastrowid

cursor.execute("""
    INSERT INTO buecher (titel, isbn, erscheinungsjahr, seitenzahl, kategorie, autor_id, verfuegbar) 
    VALUES ('Harry Potter und der Stein der Weisen', '978-3-551-55167-2', 1997, 335, 'Fantasy', ?, 1)
""", (autor_id,))

conn.commit()
print("✅ Neuer Autor und Buch hinzugefügt!")
```

**Alternative mit JupySQL:**
```sql
%%sql
INSERT INTO autoren (vorname, nachname, geburtsjahr, nationalitaet) 
VALUES ('Terry', 'Pratchett', 1948, 'England');

INSERT INTO buecher (titel, isbn, erscheinungsjahr, seitenzahl, kategorie, autor_id, verfuegbar) 
VALUES ('Die Farben der Magie', '978-3-492-28352-4', 1983, 285, 'Fantasy', 
        (SELECT id FROM autoren WHERE nachname = 'Pratchett'), 1);
```

## Aufgabe 2: Komplexe Abfrage
Erstellen Sie eine Abfrage, die zeigt:
- Welche Bücher sind am längsten ausgeliehen?
- Wer hat sie ausgeliehen?

```sql
-- Lösung: Bücher sortiert nach Ausleihdauer (JupySQL)
%%sql
SELECT 
    b.titel,
    m.vorname || ' ' || m.nachname as mitglied,
    au.ausleihdatum,
    CAST(julianday('now') - julianday(au.ausleihdatum) AS INTEGER) as tage_ausgeliehen
FROM ausleihen au
JOIN buecher b ON au.buch_id = b.id
JOIN mitglieder m ON au.mitglied_id = m.id
WHERE au.zurueckgegeben = 0
ORDER BY tage_ausgeliehen DESC;
```

## Aufgabe 3: Datenanalyse mit pandas
Erstellen Sie eine Visualisierung der Bücher nach Jahrzehnten:

```python
# Lösung: Bücher nach Jahrzehnten gruppieren und visualisieren
df_jahrzehnte = pd.read_sql_query("""
    SELECT 
        (erscheinungsjahr / 10) * 10 as jahrzehnt,
        COUNT(*) as anzahl_buecher,
        GROUP_CONCAT(titel, ', ') as buchtitel
    FROM buecher 
    GROUP BY jahrzehnt
    ORDER BY jahrzehnt
""", conn)

# Visualisierung
plt.figure(figsize=(12, 6))
bars = plt.bar(df_jahrzehnte['jahrzehnt'].astype(str) + 'er', 
               df_jahrzehnte['anzahl_buecher'],
               color='lightcoral')

plt.title('📚 Bücher nach Jahrzehnten', fontsize=14, fontweight='bold')
plt.xlabel('Jahrzehnt')
plt.ylabel('Anzahl Bücher')
plt.xticks(rotation=45)

# Werte auf den Balken anzeigen
for bar, count in zip(bars, df_jahrzehnte['anzahl_buecher']):
    plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.05, 
             str(count), ha='center', va='bottom')

plt.tight_layout()
plt.show()

print("📊 Details zu den Jahrzehnten:")
for _, row in df_jahrzehnte.iterrows():
    print(f"{int(row['jahrzehnt'])}er Jahre: {row['anzahl_buecher']} Bücher")
    print(f"  Titel: {row['buchtitel']}\n")
```

**Alternative mit JupySQL + Visualization:**
```sql
%%sql --save df_jahrzehnte_sql
SELECT 
    (erscheinungsjahr / 10) * 10 as jahrzehnt,
    COUNT(*) as anzahl_buecher
FROM buecher 
GROUP BY jahrzehnt
ORDER BY jahrzehnt;
```

```python
# JupySQL-Ergebnis visualisieren
plt.figure(figsize=(10, 6))
plt.bar(df_jahrzehnte_sql['jahrzehnt'].astype(str) + 'er', 
        df_jahrzehnte_sql['anzahl_buecher'], 
        color='steelblue')
plt.title('📚 Bücher nach Jahrzehnten (JupySQL)', fontweight='bold')
plt.show()
```

---
# 🚀 Erweiterte Funktionen

## Views erstellen

```python
# View für verfügbare Bücher erstellen
cursor.execute("""
    CREATE VIEW IF NOT EXISTS verfuegbare_buecher AS
    SELECT 
        b.id,
        b.titel,
        a.vorname || ' ' || a.nachname as autor,
        b.kategorie,
        b.erscheinungsjahr,
        b.seitenzahl
    FROM buecher b
    JOIN autoren a ON b.autor_id = a.id
    WHERE b.verfuegbar = 1
""")

conn.commit()
print("✅ View 'verfuegbare_buecher' erstellt!")
```

```sql
-- View verwenden mit JupySQL
%%sql
SELECT * FROM verfuegbare_buecher
ORDER BY erscheinungsjahr DESC;
```

## JupySQL Advanced Features

```sql
-- Tabellen-Schema analysieren
%%sql
SELECT 
    name,
    type,
    sql
FROM sqlite_master 
WHERE type IN ('table', 'view')
ORDER BY name;
```

```python
# Query-Performance Monitoring mit JupySQL
%%sql --time
SELECT 
    a.nationalitaet,
    COUNT(b.id) as anzahl_buecher,
    AVG(b.seitenzahl) as durchschnitt_seiten,
    MIN(b.erscheinungsjahr) as aeltestes_buch,
    MAX(b.erscheinungsjahr) as neuestes_buch
FROM autoren a
LEFT JOIN buecher b ON a.id = b.autor_id
GROUP BY a.nationalitaet
ORDER BY anzahl_buecher DESC;
```

## Python-Funktionen für häufige Abfragen

```python
def suche_buch(suchbegriff):
    """Sucht Bücher nach Titel oder Autor"""
    query = """
        SELECT 
            b.titel,
            a.vorname || ' ' || a.nachname as autor,
            b.kategorie,
            CASE WHEN b.verfuegbar = 1 THEN '✅ Verfügbar' ELSE '❌ Ausgeliehen' END as status
        FROM buecher b
        JOIN autoren a ON b.autor_id = a.id
        WHERE b.titel LIKE ? OR a.nachname LIKE ?
    """
    
    cursor.execute(query, (f'%{suchbegriff}%', f'%{suchbegriff}%'))
    ergebnisse = cursor.fetchall()
    
    if ergebnisse:
        print(f"🔍 Suchergebnisse für '{suchbegriff}':")
        for titel, autor, kategorie, status in ergebnisse:
            print(f"  '{titel}' von {autor} ({kategorie}) - {status}")
    else:
        print(f"❌ Keine Bücher gefunden für '{suchbegriff}'")

def buch_ausleihen(buch_id, mitglied_id):
    """Leiht ein Buch aus"""
    # Prüfen ob Buch verfügbar ist
    cursor.execute("SELECT verfuegbar, titel FROM buecher WHERE id = ?", (buch_id,))
    result = cursor.fetchone()
    
    if not result:
        print("❌ Buch nicht gefunden!")
        return
    
    verfuegbar, titel = result
    if not verfuegbar:
        print(f"❌ '{titel}' ist bereits ausgeliehen!")
        return
    
    # Ausleihe eintragen
    heute = datetime.now().strftime('%Y-%m-%d')
    cursor.execute("""
        INSERT INTO ausleihen (buch_id, mitglied_id, ausleihdatum, zurueckgegeben)
        VALUES (?, ?, ?, 0)
    """, (buch_id, mitglied_id, heute))
    
    # Buch als nicht verfügbar markieren
    cursor.execute("UPDATE buecher SET verfuegbar = 0 WHERE id = ?", (buch_id,))
    
    conn.commit()
    print(f"✅ '{titel}' erfolgreich ausgeliehen!")

# Beispiel-Verwendung
suche_buch("Hesse")
print()
suche_buch("1984")
```

## Daten exportieren

```python
# Alle Bücher als CSV exportieren
df_export = pd.read_sql_query("""
    SELECT 
        b.titel,
        a.vorname || ' ' || a.nachname as autor,
        b.isbn,
        b.erscheinungsjahr,
        b.kategorie,
        b.seitenzahl,
        CASE WHEN b.verfuegbar = 1 THEN 'Ja' ELSE 'Nein' END as verfuegbar
    FROM buecher b
    JOIN autoren a ON b.autor_id = a.id
    ORDER BY a.nachname, b.titel
""", conn)

# Als CSV speichern
df_export.to_csv('bibliothek_buecher.csv', index=False, encoding='utf-8')
print("✅ Bücherliste als 'bibliothek_buecher.csv' exportiert!")
print(f"📄 {len(df_export)} Bücher exportiert")

# Erste 3 Zeilen anzeigen
print("\n📋 Vorschau:")
display(df_export.head(3))
```

**Export mit JupySQL:**
```sql
%%sql --save df_complete_export
SELECT 
    b.titel,
    a.vorname || ' ' || a.nachname as autor,
    b.kategorie,
    b.erscheinungsjahr,
    b.seitenzahl,
    m.vorname || ' ' || m.nachname as aktueller_ausleihender,
    au.ausleihdatum
FROM buecher b
JOIN autoren a ON b.autor_id = a.id
LEFT JOIN ausleihen au ON b.id = au.buch_id AND au.zurueckgegeben = 0
LEFT JOIN mitglieder m ON au.mitglied_id = m.id
ORDER BY b.titel;
```

```python
# JupySQL-Export als Excel
df_complete_export.to_excel('bibliothek_complete.xlsx', index=False)
print("✅ Vollständiger Export als Excel-Datei erstellt!")
```

## Datenbank-Backup erstellen

```python
# SQL-Dump erstellen
def create_sql_backup():
    backup_lines = []
    
    # Alle Tabellen abrufen
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = cursor.fetchall()
    
    for table_name, in tables:
        if table_name.startswith('sqlite_'):
            continue
            
        # Schema abrufen
        cursor.execute(f"SELECT sql FROM sqlite_master WHERE type='table' AND name='{table_name}'")
        schema = cursor.fetchone()[0]
        backup_lines.append(f"-- Tabelle {table_name}")
        backup_lines.append(f"DROP TABLE IF EXISTS {table_name};")
        backup_lines.append(f"{schema};")
        backup_lines.append("")
        
        # Daten abrufen
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()
        
        if rows:
            # Spaltennamen abrufen
            cursor.execute(f"PRAGMA table_info({table_name})")
            columns = [col[1] for col in cursor.fetchall()]
            
            backup_lines.append(f"-- Daten für {table_name}")
            for row in rows:
                values = []
                for value in row:
                    if value is None:
                        values.append('NULL')
                    elif isinstance(value, str):
                        values.append(f"'{value.replace(chr(39), chr(39)+chr(39))}'")  # Escape single quotes
                    else:
                        values.append(str(value))
                
                backup_lines.append(f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({', '.join(values)});")
            backup_lines.append("")
    
    # Backup-Datei schreiben
    with open('bibliothek_backup.sql', 'w', encoding='utf-8') as f:
        f.write('\n'.join(backup_lines))
    
    print("✅ SQL-Backup als 'bibliothek_backup.sql' erstellt!")
    print(f"📁 Backup enthält {len(tables)} Tabellen")

create_sql_backup()
```

---
# 🧹 Aufräumen und Zusammenfassung

```python
# Finale Statistiken mit JupySQL
%%sql --save final_stats
SELECT 
    'Autoren' as kategorie,
    COUNT(*) as anzahl
FROM autoren
UNION ALL
SELECT 
    'Bücher' as kategorie,
    COUNT(*) as anzahl
FROM buecher
UNION ALL
SELECT 
    'Mitglieder' as kategorie,
    COUNT(*) as anzahl
FROM mitglieder
UNION ALL
SELECT 
    'Ausleihen' as kategorie,
    COUNT(*) as anzahl
FROM ausleihen
UNION ALL
SELECT 
    'Verfügbare Bücher' as kategorie,
    COUNT(*) as anzahl
FROM buecher 
WHERE verfuegbar = 1;
```

```python
print("📊 Finale Bibliotheks-Statistiken:")
print("=" * 40)
for _, row in final_stats.iterrows():
    print(f"{row['kategorie']:.<25} {row['anzahl']:>3}")
print("=" * 40)

# Verbindung schließen
conn.close()
print("\n✅ Datenbankverbindung geschlossen!")
print("\n🎉 Herzlichen Glückwunsch! Sie haben erfolgreich SQL in JupyterLab mit JupySQL verwendet!")
```

---
# 📝 Zusammenfassung

## Was Sie gelernt haben:

### ✅ **Drei moderne Methoden für SQL in JupyterLab:**
1. **Python sqlite3** - Standard-Bibliothek für direkte SQL-Ausführung
2. **JupySQL Magic Commands** - Moderne `%sql` und `%%sql` Alternative mit erweiterten Features
3. **pandas Integration** - SQL-Abfragen direkt in DataFrames

### ✅ **Praktische Datenbankarbeit:**
- Datenbankschema erstellen mit Foreign Keys
- Testdaten einfügen mit verschiedenen Methoden
- Komplexe Abfragen mit JOINs und Aggregationen
- Views für wiederverwendbare Abfragen
- Query-Performance-Analyse mit JupySQL

### ✅ **Datenanalyse und Visualisierung:**
- SQL-Ergebnisse visualisieren mit matplotlib
- Daten exportieren (CSV, Excel, SQL-Backup)
- Interaktive Funktionen für Datenbankoperationen
- Automatische DataFrame-Konvertierung

### ✅ **JupySQL Advanced Features:**
- `--explain` für Query-Performance
- `--save` für DataFrame-Speicherung
- `--time` für Ausführungszeit-Messung
- Nahtlose pandas-Integration
- Stabile Magic Commands ohne KeyError-Probleme

### ✅ **Best Practices:**
- Moderne Tools verwenden (JupySQL statt ipython-sql)
- Proper Error Handling
- Datenbankverbindungen ordnungsgemäß schließen
- Code-Wiederverwendung durch Funktionen
- Dokumentation mit Markdown

## 🚀 Nächste Schritte:
- Experimentieren Sie mit eigenen Datenbanken
- Probieren Sie **jupyterlab-sql-explorer** für erweiterte GUI-Features
- Erkunden Sie **JupySQL's erweiterte Features** (Profiling, Multi-DB-Connections)
- Integrieren Sie SQL in Ihre Python-Datenanalyseprojekte
- Erkunden Sie andere Datenbanken (PostgreSQL, MySQL) mit JupySQL
- Testen Sie **DuckDB** für analytische Workloads
- Verwenden Sie JupySQL für **Data Science Pipelines**

## 🔧 **JupySQL vs. ipython-sql Vorteile:**
- ✅ **Keine KeyError-Probleme** 
- ✅ **Bessere Performance** bei großen Datasets
- ✅ **Erweiterte Debugging-Tools** (--explain, --time)
- ✅ **Aktive Entwicklung** und regelmäßige Updates
- ✅ **Bessere pandas-Integration**
- ✅ **Multi-Database-Support**

## 📚 Weiterführende Ressourcen:
- [SQLite Documentation](https://sqlite.org/docs.html)
- [pandas SQL Tutorial](https://pandas.pydata.org/docs/user_guide/io.html#sql-queries)
- [JupySQL Documentation](https://jupysql.ploomber.io/en/latest/)
- [JupyterLab Extensions](https://jupyterlab.readthedocs.io/en/stable/user/extensions.html)
- [DuckDB Engine](https://duckdb.org/docs/guides/python/jupyter.html)
- [JupySQL GitHub](https://github.com/ploomber/jupysql)

## 💡 **Tipps für Ihren Python-Kurs:**
1. **Beginnen Sie mit sqlite3** für grundlegendes SQL-Verständnis
2. **Wechseln Sie zu JupySQL** für interaktive Entwicklung
3. **Verwenden Sie pandas** für Datenanalyse und Visualisierung
4. **Kombinieren Sie alle drei Methoden** je nach Anwendungsfall
5. **Nutzen Sie JupySQL's Features** für professionelle Entwicklung

---
*Erstellt für Python-Programmierkurs - SQL in JupyterLab mit JupySQL*