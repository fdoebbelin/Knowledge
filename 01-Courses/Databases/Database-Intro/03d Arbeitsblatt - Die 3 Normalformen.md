## Lernziele:

- Verstehen der drei Normalformen (1NF, 2NF, 3NF)
- Anwenden der Normalisierung auf eine gegebene Tabelle
- Identifizieren und Entfernen von Redundanzen und Anomalien
## Aufgabe 1: Theoriefragen

Beantworte die folgenden Fragen schriftlich:

1. Was ist das Ziel der Normalisierung in relationalen Datenbanken?
2. Welche Probleme können in einer unnormalisierten Datenbank auftreten?
3. Was sind die Bedingungen für die erste Normalform (1NF)?
4. Wie unterscheiden sich die zweite (2NF) und dritte Normalform (3NF)?
5. Warum sollte eine Tabelle in der dritten Normalform (3NF) vorliegen?
## Aufgabe 2: Normalisierung einer Tabelle

Gegeben ist die folgende **nicht normalisierte Tabelle (UNF)** einer Musikbibliothek:

| Album-ID | Album-Name | Künstler        | Veröffentlichungsjahr | Song-ID | Song-Name               | Genre |
| -------- | ---------- | --------------- | --------------------- | ------- | ----------------------- | ----- |
| 1        | Thriller   | Michael Jackson | 1982                  | 101     | Billie Jean             | Pop   |
| 1        | Thriller   | Michael Jackson | 1982                  | 102     | Beat It                 | Pop   |
| 2        | Nevermind  | Nirvana         | 1991                  | 201     | Smells Like Teen Spirit | Rock  |
| 2        | Nevermind  | Nirvana         | 1991                  | 202     | Come as You Are         | Rock  |

**Schritt 1: Überführung in die 1. Normalform (1NF)**

- Verstöße gegen die 1NF (z. B. Wiederholungsgruppen oder nicht-atomare Werte) erkennen.
- Die Tabelle so überarbeiten, dass jede Zelle nur einen einzelnen Wert enthält.

**Schritt 2: Überführung in die 2. Normalform (2NF)**

- Partielle Abhängigkeiten (Felder, die nur von einem Teil des Primärschlüssels abhängen).
- Die Tabelle in mehrere Tabelle zerlegen, sodass alle Nicht-Schlüsselattribute von einem vollständigen Primärschlüssel abhängen.

**Schritt 3: Überführung in die 3. Normalform (3NF)**

- Transitive Abhängigkeiten erkennen (Attribute, die nicht direkt vom Primärschlüssel abhängen).
- Die betroffenen Attribute in eine eigene Tabelle überführen.
## Aufgabe 3: Reflexion

6. Welche Vorteile hat die Normalisierung für die Datenbankverwaltung?
7. Gibt es Situationen, in denen eine vollständige Normalisierung (bis zur 3NF) nicht ideal ist?
8. Welche möglichen Nachteile können durch zu starke Normalisierung entstehen?