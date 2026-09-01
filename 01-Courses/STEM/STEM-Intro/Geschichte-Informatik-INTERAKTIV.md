# Geschichte der Informatik: Interaktiver Abriss für das MINT-Seminar

## Einleitung

Dieses interaktive Material bietet einen Einstieg in die zentralen Stationen der Informatikgeschichte. Es enthält neben überprüften Fakten eigene Fragestellungen, Diskussionsimpulse, Coding-Challenges und Mini-Projekte für PyCharm/JupyterLab.

---

## 1. Frühe Rechenmaschinen und die Idee des Digitalen

### 1100 v. Chr. – Der Abakus
Der **Abakus (Suan Pan)** ist das Urmodell aller Rechenmaschinen. Überlegt:

> **Reflexion:** Wie funktioniert ein mechanischer Abakus? Vergleicht ihn mit heutigen Taschenrechnern – was ist ähnlich, was ist grundlegend anders?

### 1642 – Blaise Pascal: Die Pascaline
Erste mechanische Rechenmaschine für Addition und Subtraktion.

**Python-Übung:**
```python
def pascal_add(a, b):
    return a + b
print(pascal_add(12, 34))
```

**Quiz:**
Welche Innovation führt Blaise Pascal ein?
- [ ] Dezimalsystem
- [x] Mechanisches Rechnen
- [ ] Elektronische Speicher

### 1673 – Leibniz und das Binärsystem
Leibniz entwickelt eine mechanische Viergrundrechenmaschine und beschreibt das **Dualsystem**.

> **Reflexion:** Warum ist das Binärsystem so essenziell für Computer und was unterscheidet es vom Dezimalsystem?

**Python-Challenge:**
Schreibe eine Funktion, die eine Dezimalzahl ins Binärsystem umwandelt.
```python
def decimal_to_binary(n):
    return bin(n)[2:]
print(decimal_to_binary(42))
```

---

## 2. Programmieren bevor es Computer gab

### 1801 – Jacquard-Webstuhl und Lochkarten
Programmierung via Lochkarten im Textilgewerbe.

> **Mini-Projekt:** Stellt eine Lochkarte als ASCII-Art in einer Python-Funktion dar.

### 1837/1843 – Babbage & Ada Lovelace: Die Analytical Engine
Konzept für einen Universalrechner und das erste Computerprogramm.

> **Diskussion:** Ada Lovelace gilt als Erste, die erkannte, dass Maschinen mehr als nur rechnen konnten. Diskutiert: Welche Aufgaben sollte eine „Denkmaschine“ lösen können?

---

## 3. Von Theorie zu Praxis: Die ersten Computer

### 1936 – Alan Turing: Turing-Maschine
Konzept universeller Maschinen und der Turing-Test für KI.

**Python-Impuls:** Simuliere eine einfache Turing-Maschine: Erstelle ein Array und bewege einen „Lesekopf“ darüber, um Muster zu erkennen.

### 1941 – Konrad Zuse Z3
Erster frei programmierbarer Computer (Relais).

> **Gruppenaufgabe:** Findet heraus, wie viele Bits und Bytes der Z3 verwalten konnte. Sucht Quellen und teilt Ergebnisse als Markdown-Tabelle!

### 1947 – Der Transistor
Startschuss für die Miniaturisierung der Computer.

> **Exkurs:** Was ist ein Transistor und wie verändert er die Technik?

---

## 4. Programmiersprachen und ihre Revolution

Erster Compiler, FORTRAN, COBOL …

**Quiz:**
Grace Hopper war ...?
- [ ] Erste Informatikprofessorin
- [x] Entwicklerin des ersten Compilers
- [ ] Gründerin von IBM

> **Reflexion:** Weshalb sind Programmiersprachen so wichtig für die Entwicklung von Computern?

---

## 5. Hardware-Evolution im Schnellverfahren

| Generation | Technologie | Beispiele |
|------------|------------|-----------|
| 1 | Elektronenröhren, Relais | Z3, ENIAC |
| 2 | Transistor | IBM 1401 |
| 3 | IC-Chips | IBM System/360 |
| 4 | Mikroprozessor | Intel 4004, PC |

**Coding-Challenge:**
Erstelle ein Diagramm (z. B. mit matplotlib) zu den Generationen und ihrer Verbreitung über die Jahrzehnte!

```python
import matplotlib.pyplot as plt
generation = ['1. Röhren', '2. Transistor', '3. IC', '4. Mikroprozessor']
years = [1950, 1960, 1970, 1980]
plt.plot(years, [1,2,3,4])
plt.title('Meilensteine der Hardware-Entwicklung')
plt.show()
```

---

## 6. Die PC-Revolution und moderne Informatik

| Jahr | Innovation | Reflexionsfrage |
|------|------------|-----------------|
| 1981 | IBM PC & MS DOS | Was war der Durchbruch für den Heim-PC? |
| 1984 | Macintosh & GUI | Warum ist GUI so erfolgreich? |
| 1991 | Linux, Open Source | Wie verändert Open Source das Lernen? |
| 2007 | iPhone | Was bedeutet mobile Informatik für die Gesellschaft? |

> **Gruppenarbeit:** Diskutiert an Beispielen wie Google, Wikipedia, KI. Was sind Chancen und Herausforderungen der Digitalisierung?

---

## 7. Interaktive Zeitreise: Projektidee

Erstellt als Team eine Timeline in Python/Plotly: Für jede wichtige Erfindung (z. B. Ada Lovelace, Zuse, ENIAC, Apple I) eine Markierung, kurze Beschreibung und eigenen Kommentar (Wichtigkeit & Auswirkungen heute).

---

## 8. Persönlichkeiten und ihr Einfluss

| Name | Leistung | Reflexion |
|------|----------|-----------|
| Charles Babbage | Analytical Engine | Wie stellt ihr euch Babbage als Forscher vor? |
| Ada Lovelace | Erstes Programm | Was würdet ihr Ada heute fragen? |
| Alan Turing | Turing-Maschine, KI | Was ist Intelligenz? |
| Konrad Zuse | Erster Computer | Was bedeutet Erfindergeist? |
| Grace Hopper | Compiler & COBOL | Sind einzelne Köpfe für den Fortschritt entscheidend? |
| Linus Torvalds | Linux & Open Source | Welche Rolle spielt Kollaboration? |
| Tim Berners-Lee | World Wide Web | Wie verändert Vernetzung die Welt?

---

## 9. Quellen, Museen, weitere Ressourcen

- Wikipedia, Computer History Museum, Deutsches Museum, HNF Paderborn
- Tutorials und Videos zur Informatikgeschichte
- Eigene Recherchen als Gruppenaufgabe

---

## Zusammenfassung & Ausblick

Die Informatikgeschichte verdeutlicht: Fortschritt entsteht durch kreative Köpfe, Zusammenarbeit und die Lust am Weiterdenken. Nutzt die Aufgaben und Projekte für eigenes Erforschen – in JupyterLab und PyCharm!

---

*Material angepasst und erweitert für das Interactive MINT Learning Environment im Rahmen eines Obsidian/JupyterLab-Kurses (2025).*
