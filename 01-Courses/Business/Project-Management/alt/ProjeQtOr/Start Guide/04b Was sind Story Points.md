### **Definition:**

- Story Points sind eine **relative Schätzeinheit** zur Bewertung des Aufwands, der Komplexität und des Risikos einer User Story. 
- Sie sind **NICHT** gleich Zeit (Stunden/Tage), sondern eine dimensionslose Zahl.

### **Was wird geschätzt:**

```
✅ Aufwand (Wie viel Arbeit?)
✅ Komplexität (Wie schwierig?)
✅ Risiko/Unsicherheit (Wie unbekannt?)
❌ NICHT Zeit (Stunden/Tage)
❌ NICHT Personen-spezifisch
```

## **Story Points Skala - Fibonacci-Reihe:**

### **Typische Skala:**

```
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 100

Bedeutung:
1-2:   Sehr einfach, gut verstanden
3-5:   Einfach bis mittel, wenig Risiko  
8-13:  Komplex, einige Unbekannte
21-34: Sehr komplex, hohes Risiko
55+:   Epic - muss aufgeteilt werden!
```

### **Warum Fibonacci-Reihe?**

```
✅ Größere Zahlen = größere Unsicherheit
✅ Verhindert falsche Präzision (kein Unterschied zwischen 14 und 15)
✅ Natürliche Abstufung der Komplexität
✅ Zwingt zur Entscheidung zwischen klar abgegrenzten Größen
```

## **Story Points am Backend-Beispiel:**

### **Story Point 1-2 (Sehr einfach):**

```
User Story: "Als Entwickler möchte ich Unit Tests für die User Entity, 
            damit die Datenstruktur validiert ist."

Story Points: 2
Warum: 
- Standard-CRUD-Tests
- Bekannte Technologie (JUnit)
- Klare Anforderungen
- Geringes Risiko
```

### **Story Point 3-5 (Einfach-Mittel):**

```
User Story: "Als Kunde möchte ich mich anmelden können,
            damit ich auf mein Konto zugreifen kann."

Story Points: 5  
Warum:
- Standard-Login-Logik
- JWT-Token (bekannte Technologie)
- Wenige Abhängigkeiten
- Gut verstanden, aber mehrere Komponenten
```

### **Story Point 8 (Komplex):**

```
User Story: "Als neuer Kunde möchte ich mich registrieren können,
            damit ich ein Konto erstellen kann."

Story Points: 8
Warum:
- E-Mail-Validierung und -Versand
- Passwort-Hashing
- Datenbank-Constraints
- Mehrere API-Endpoints
- Integration mit E-Mail-Service
```

### **Story Point 13 (Sehr komplex):**

```
User Story: "Als Kunde möchte ich Produkte durchsuchen können,
            damit ich finde was ich brauche."

Story Points: 13
Warum:
- Elasticsearch-Integration (neue Technologie)
- Complex Search-Algorithmus
- Filter- und Sortier-Logik
- Performance-Optimierung erforderlich
- Unbekannte: Suchrelevanz-Tuning
```

### **Story Point 21+ (Epic-Größe):**

```
User Story: "Als Kunde möchte ich den kompletten Checkout-Prozess 
            durchlaufen können."

Story Points: 21
Warum: ZU GROSS! Muss aufgeteilt werden:
- Adresse eingeben (5 SP)
- Versandoptionen wählen (3 SP)  
- Steuerberechnung (8 SP)
- Bestellübersicht (3 SP)
- Bestellung bestätigen (5 SP)
= Total: 24 SP aufgeteilt
```

## **Planning Poker - Story Points schätzen:**

### **Ablauf einer Schätzung:**

```
1. Product Owner liest User Story vor
2. Team stellt Verständnisfragen
3. Alle wählen Story Point Karte (verdeckt)
4. Gleichzeitig aufdecken
5. Bei Abweichungen: Diskussion
6. Neue Runde bis Konsens
```

### **Planning Poker Beispiel:**

**User Story:** "Passwort-Reset implementieren"

**Runde 1:**

```
Anna (Senior Dev): 5 SP
Tom (Junior Dev): 13 SP  
Lisa (DevOps): 8 SP
```

**Diskussion:**

```
Tom: "Ich kenne E-Mail-Templates nicht gut, das ist für mich komplex"
Anna: "Das ist Standard-Funktionalität, haben wir schon mal gemacht"
Lisa: "Token-Management könnte Security-Review brauchen"
```

**Runde 2:**

```
Anna: 8 SP  (revidiert nach Security-Überlegung)
Tom: 8 SP   (nach Erklärung)
Lisa: 8 SP  (bleibt dabei)
```

**Ergebnis: 8 Story Points**

## **Velocity und Story Points:**

### **Team Velocity berechnen:**

```
Sprint 1: 18 SP abgeschlossen
Sprint 2: 22 SP abgeschlossen  
Sprint 3: 20 SP abgeschlossen

Durchschnittliche Velocity: 20 SP/Sprint
→ Team kann ca. 20 SP pro Sprint schaffen
```

### **Sprint Planning mit Velocity:**

```
Team Velocity: 20 SP
Verfügbare User Stories:
- Produktsuche (13 SP)
- Produktdetails (8 SP)  
- Kategorien (5 SP)
= Total: 26 SP

Entscheidung: 13 + 8 = 21 SP (leicht über Velocity, aber machbar)
```

## **Story Points vs. Stunden:**

### **NICHT zeitbasiert:**

```
❌ 1 Story Point = X Stunden
❌ "Diese Story ist 8 SP, also 8 Stunden"
❌ Direkte Umrechnung

✅ Relativ zueinander
✅ "Diese Story ist doppelt so komplex wie die andere"
✅ Team-spezifische Velocity
```

### **Warum keine Stunden?**

```
Problem mit Stunden-Schätzung:
❌ Zu präzise ("3,5 Stunden")
❌ Personen-abhängig (Junior vs Senior)
❌ Berücksichtigt keine Komplexität
❌ Ignoriert Risiken und Unbekannte
❌ Schwer zu schätzen bei neuen Technologien

Vorteile Story Points:
✅ Relative Schätzung einfacher
✅ Team-Konsens erforderlich
✅ Berücksichtigt alle Faktoren
✅ Anpassung über Velocity
```

## **Reference User Story (Baseline):**

### **Story Point 5 als Referenz:**

```
Reference Story: "Als Kunde möchte ich mich anmelden können"
= 5 Story Points

Vergleich andere Stories:
- "Unit Tests schreiben" → Einfacher → 2 SP
- "Registrierung" → Komplexer → 8 SP  
- "Produktsuche" → Viel komplexer → 13 SP
```

## **Story Points in verschiedenen Teams:**

### **Team A (Backend-Erfahren):**

```
"JWT-Authentication implementieren"
Team A: 3 SP (kennen JWT gut)
```

### **Team B (Backend-Anfänger):**

```
"JWT-Authentication implementieren"  
Team B: 8 SP (JWT ist neu für sie)
```

**Beide richtig!** Story Points sind **team-spezifisch**.

## **Burndown Chart mit Story Points:**

### **Sprint Burndown:**

```
Sprint 3 (20 SP geplant):

Tag 1: 20 SP remaining
Tag 3: 18 SP remaining (Anmeldung fertig: -2 SP)
Tag 5: 13 SP remaining (Registrierung fertig: -5 SP)
Tag 7: 8 SP remaining (Unit Tests fertig: -5 SP)
Tag 10: 0 SP remaining (Passwort-Reset fertig: -8 SP)

→ Sprint erfolgreich abgeschlossen
```

## **Epic Story Points:**

### **Epic-Schätzung:**

```
Epic: "Benutzer-Management-System"
Geschätzte User Stories:
- Registrierung: 8 SP
- Anmeldung: 5 SP
- Passwort-Reset: 8 SP
- Profil-Management: 13 SP
- Benutzer-Rollen: 21 SP
= Epic Total: 55 SP

Bei 20 SP Velocity: ~3 Sprints für Epic
```

## **Häufige Fehler bei Story Points:**

### **❌ Falsche Anwendung:**

```
1. "1 SP = 1 Tag" (Zeitumrechnung)
2. Einzelperson schätzt (kein Team-Konsens)  
3. Zu präzise Schätzung (14 SP statt 13 SP)
4. Story Points nachträglich ändern
5. Velocity als Performance-Metrik verwenden
```

### **✅ Richtige Anwendung:**

```
1. Relative Schätzung im Team
2. Fibonacci-Skala verwenden
3. Planning Poker für Konsens
4. Velocity für Sprint Planning nutzen
5. Story Points als Planungshilfe sehen
```

## **Story Points Refinement:**

### **Backlog Refinement Session:**

```
Ziel: User Stories "Ready" machen

Activities:
1. User Stories aufteilen (wenn >13 SP)
2. Story Points schätzen  
3. Akzeptanzkriterien klären
4. Abhängigkeiten identifizieren
5. Technical Tasks grob umreißen

Output: "Ready" User Stories für Sprint Planning
```

**Story Points sind somit ein Werkzeug für relative Schätzung und Planung, nicht für Zeit-Tracking oder Performance-Messung!**