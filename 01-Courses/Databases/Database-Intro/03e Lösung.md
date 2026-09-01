## Aufgabe 1: Theoriefragen - Lösungen

1. **Was ist das Ziel der Normalisierung in relationalen Datenbanken?**
    - Die Normalisierung reduziert Redundanzen und verhindert Anomalien bei Einfüge-, Änderungs- und Löschoperationen. 
    - Dadurch wird die Konsistenz der Daten gewährleistet und der Speicherbedarf optimiert.
2. **Welche Probleme können in einer unnormalisierten Datenbank auftreten?**
    - **Einfügeanomalien:** 
	    - Neue Daten können nur eingefügt werden, wenn alle abhängigen Informationen bereits vorhanden sind.
    - **Änderungsanomalien:** 
	    - Eine Änderung an einer mehrfach gespeicherten Information muss überall vorgenommen werden.
    - **Löschanomalien:** 
	    - Beim Löschen eines Datensatzes können unbeabsichtigt andere wichtige Informationen verloren gehen.
3. **Was sind die Bedingungen für die erste Normalform (1NF)?**
    - Alle Attribute enthalten nur atomare (unteilbare) Werte.
    - Es gibt keine wiederholenden Gruppen oder Mehrfachwerte in einer Spalte.
    - Jede Zeile ist eindeutig identifizierbar (z. B. durch einen Primärschlüssel).
4. **Wie unterscheiden sich die zweite (2NF) und dritte Normalform (3NF)?**
    - **2NF:** Alle Nicht-Schlüsselattribute müssen von **einem vollständigen Primärschlüssel** abhängen (keine partiellen Abhängigkeiten).
    - **3NF:** Alle Nicht-Schlüsselattribute müssen direkt vom Primärschlüssel abhängen (keine transitiven Abhängigkeiten).
5. **Warum sollte eine Tabelle in der dritten Normalform (3NF) vorliegen?**
    - Dadurch werden doppelte Daten weiter reduziert und mögliche Abhängigkeitsprobleme vermieden.
    - Daten sind einfacher zu verwalten, Änderungen müssen nur an einer Stelle vorgenommen werden.
## Aufgabe 2: Normalisierung einer Tabelle

### Gegebene unnormalisierte Tabelle (UNF):

| Album-ID | Album-Name | Künstler        | Veröffentlichungsjahr | Song-Namen                               | Genre |
| -------- | ---------- | --------------- | --------------------- | ---------------------------------------- | ----- |
| 1        | Thriller   | Michael Jackson | 1982                  | Billie Jean, Beat It                     | Pop   |
| 2        | Nevermind  | Nirvana         | 1991                  | Smells Like Teen Spirit, Come as You Are | Rock  |

### Schritt 1: Überführung in die 1. Normalform (1NF)

**Problem:**
- Mehrfache Songs pro Album → wiederholte Daten.

**Lösung:**
- Hinzufügen einer `Song-ID`.
- **Jede Zeile stellt nur einen einzigen Song dar**.

| Album-ID | Album-Name | Künstler        | Veröffentlichungsjahr | Song-ID | Song-Name               | Genre |
| -------- | ---------- | --------------- | --------------------- | ------- | ----------------------- | ----- |
| 1        | Thriller   | Michael Jackson | 1982                  | 101     | Billie Jean             | Pop   |
| 1        | Thriller   | Michael Jackson | 1982                  | 102     | Beat It                 | Pop   |
| 2        | Nevermind  | Nirvana         | 1991                  | 201     | Smells Like Teen Spirit | Rock  |
| 2        | Nevermind  | Nirvana         | 1991                  | 202     | Come as You Are         | Rock  |

✅ Jetzt ist die Tabelle in **1NF**:

- Keine Mehrfachwerte oder nicht-atomaren Spalten mehr.
- **Primärschlüssel**: (Album-ID, Song-ID)
### Schritt 2: Überführung in die 2. Normalform (2NF)

**Problem:**
- Der Primärschlüssel ist (`Album-ID, Song-ID`).
- Album-Name, Künstler und Veröffentlichungsjahr hängen **nur von Album-ID** ab (nicht von Song-ID).
- **Partielle Abhängigkeiten** sind vorhanden.

**Lösung:**
- Trennung in zwei Tabellen:
    - **Tabelle 1: Alben** (Album-bezogene Daten)
    - **Tabelle 2: Songs** (Song-bezogene Daten)

#### Neue Tabellen in 2NF:

##### Tabelle: Alben

|Album-ID|Album-Name|Künstler|Veröffentlichungsjahr|
|---|---|---|---|
|1|Thriller|Michael Jackson|1982|
|2|Nevermind|Nirvana|1991|

##### Tabelle: Songs

|Song-ID|Album-ID|Song-Name|Genre|
|---|---|---|---|
|101|1|Billie Jean|Pop|
|102|1|Beat It|Pop|
|201|2|Smells Like Teen Spirit|Rock|
|202|2|Come as You Are|Rock|

✅ Jetzt ist die Tabelle in **2NF**:

- **Alle Nicht-Schlüsselattribute hängen vom gesamten Primärschlüssel ab**.
- Keine **partiellen Abhängigkeiten** mehr.

### Schritt 3: Überführung in die 3. Normalform (3NF)

**Problem:**
- Das **Genre** ist eine **transitive Abhängigkeit**, da es sich eigentlich auf den Song-Namen bezieht, nicht direkt auf die Song-ID oder das Album.
- **Genre hängt nicht direkt vom Primärschlüssel ab**, sondern von Song-Name.

**Lösung:**
- Eine separate **Genre-Tabelle** erstellen.

#### Neue Tabellen in 3NF:

##### Tabelle: Alben 
> bleibt unverändert

|Album-ID|Album-Name|Künstler|Veröffentlichungsjahr|
|---|---|---|---|
|1|Thriller|Michael Jackson|1982|
|2|Nevermind|Nirvana|1991|

##### Tabelle: Songs
> ohne Genre

|Song-ID|Album-ID|Song-Name|
|---|---|---|
|101|1|Billie Jean|
|102|1|Beat It|
|201|2|Smells Like Teen Spirit|
|202|2|Come as You Are|

##### Tabelle: Genres

|Genre-ID|Genre-Name|
|---|---|
|1|Pop|
|2|Rock|

##### Tabelle: Song-Genres 
> Verknüpfungstabelle für Songs und Genres

|Song-ID|Genre-ID|
|---|---|
|101|1|
|102|1|
|201|2|
|202|2|

✅ Jetzt ist die Tabelle in **3NF**:

- **Genre ist nun in einer separaten Tabelle**, sodass keine transitive Abhängigkeit mehr existiert.
- **Datenredundanz wurde weiter reduziert**.
## Aufgabe 3: Reflexion - Lösungen
1. **Vorteile der Normalisierung:**
    - Weniger Redundanzen
    - Vermeidung von Anomalien
    - Einfachere Wartung
2. **Wann ist eine vollständige Normalisierung nicht ideal?**
    - Wenn häufige Joins die Abfragen verlangsamen
    - Wenn Performance wichtiger ist als Speicherplatz
3. **Mögliche Nachteile:**
    - Komplexere SQL-Abfragen
    - Mehr Tabellen → Performance-Probleme bei vielen Joins

**Fazit:** 
- Die Normalisierung hilft, Daten konsistent und wartbar zu halten. 
- Allerdings sollte sie je nach Anwendungsfall sinnvoll angewendet werden!