### **Was ist ein Epic?**

**Definition:** 
- Ein Epic ist eine **große User Story**, die zu umfangreich ist, um in einem einzigen Sprint umgesetzt zu werden. 
- Es beschreibt ein größeres Feature oder eine zusammenhängende Funktionalität aus Nutzersicht.

**Charakteristika:**

```
✅ Umfasst mehrere User Stories
✅ Springt-übergreifend (mehrere Sprints)
✅ Strategische Ebene - Business Value
✅ Grobe Schätzung (oft in Wochen/Monaten)
✅ Wird in kleinere User Stories aufgeteilt
```

### **Was ist eine User Story?**

**Definition:** 
- Eine User Story ist eine **kurze, einfache Beschreibung** einer Funktionalität aus der Perspektive des Endnutzers. 
- Sie ist klein genug, um in einem Sprint umgesetzt zu werden.

**Format:** "Als [Rolle] möchte ich [Funktionalität], damit [Nutzen]"

**Charakteristika:**

```
✅ Passt in einen Sprint (1-2 Wochen)
✅ Klar definierte Akzeptanzkriterien
✅ Schätzbar in Story Points
✅ Implementierbar und testbar
✅ Liefert Wert für den Endnutzer
```

## **Hierarchie-Beispiel: E-Commerce Backend**

### **Epic-Ebene (Strategisch):**

```
Epic: "Benutzer-Management-System"
Beschreibung:
	Als E-Commerce-Plattform möchte ich ein vollständiges 
    Benutzermanagement, damit Kunden sich registrieren, 
    anmelden und ihre Profile verwalten können.

Umfang: 3-4 Sprints
Story Points: ~50-80 SP
Business Value: Grundvoraussetzung für E-Commerce
```

### **User Story-Ebene (Operativ):**

**User Story 1:**

```
"Als neuer Kunde möchte ich mich registrieren können, 
 damit ich ein Benutzerkonto erstellen kann."

Sprint: Sprint 1
Story Points: 8
Akzeptanzkriterien:
- Registrierungsformular mit E-Mail, Passwort, Name
- E-Mail-Validierung
- Bestätigungs-E-Mail
- Doppelte E-Mails verhindern
```

**User Story 2:**

```
"Als registrierter Kunde möchte ich mich anmelden können,
 damit ich auf mein Konto zugreifen kann."

Sprint: Sprint 1  
Story Points: 5
Akzeptanzkriterien:
- Login mit E-Mail/Passwort
- JWT Token Generation
- "Remember Me" Funktion
- Fehlerbehandlung
```

**User Story 3:**

```
"Als Kunde möchte ich mein Passwort zurücksetzen können,
 wenn ich es vergessen habe."

Sprint: Sprint 2
Story Points: 8
Akzeptanzkriterien:
- "Forgot Password" Link
- Reset-Token per E-Mail
- Temporärer Link (24h)
- Neues Passwort setzen
```

## **Weitere Epic-Beispiele:**

### **Epic: "Produktkatalog-System"**

```
Umfasst User Stories wie:
- Produktsuche implementieren
- Produktdetails anzeigen
- Kategorien verwalten
- Produktbewertungen anzeigen
- Ähnliche Produkte vorschlagen

Sprints: 4-5 Sprints
Story Points: ~80-120 SP
```

### **Epic: "Warenkorb & Checkout"**

```
Umfasst User Stories wie:
- Produkte zum Warenkorb hinzufügen
- Warenkorb verwalten
- Checkout-Prozess durchlaufen
- Zahlungsabwicklung
- Bestellbestätigung

Sprints: 5-6 Sprints  
Story Points: ~100-150 SP
```

## **Praktische Anwendung im Scrum-Prozess:**

### **Product Backlog Refinement:**

```
1. Product Owner definiert Epics (strategische Ziele)
2. Team bricht Epics in User Stories herunter
3. User Stories werden geschätzt (Planning Poker)
4. Stories werden priorisiert nach Business Value
5. "Ready" Stories kommen ins Sprint Backlog
```

### **Sprint Planning:**

```
❌ Epic wird NICHT direkt in Sprint genommen
✅ Nur fertig definierte User Stories aus Epic

Beispiel Sprint 1:
- US: Benutzerregistrierung (8 SP)
- US: Benutzeranmeldung (5 SP)  
- US: Database Setup (8 SP)
Total: 21 SP (Team Velocity)
```

### **Definition of Ready (DoR) für User Stories:**

```
User Story ist "Ready" wenn:
✅ INVEST-Kriterien erfüllt (Independent, Negotiable, Valuable, Estimable, Small, Testable)
✅ Akzeptanzkriterien definiert
✅ Geschätzt in Story Points
✅ Abhängigkeiten geklärt
✅ UI-Mockups vorhanden (falls nötig)
✅ Technical Tasks identifiziert
```

## **Größenvergleich:**

### **Epic vs User Story:**

```
Epic (groß):
- Mehrere Sprints
- 50-200 Story Points
- Strategisches Feature
- Business-orientiert
- Wird aufgeteilt

User Story (klein):
- Ein Sprint
- 1-13 Story Points  
- Konkrete Funktionalität
- Nutzer-orientiert
- Direkt implementierbar
```

### **Story Splitting - Epic zu User Stories:**

**Vorher (Epic):**

```
"Als E-Commerce-Plattform möchte ich Zahlungsabwicklung, 
 damit Kunden bezahlen können."
(Zu groß für einen Sprint!)
```

**Nachher (User Stories):**

```
1. "Als Kunde möchte ich per Kreditkarte bezahlen können..."
2. "Als Kunde möchte ich per PayPal bezahlen können..."  
3. "Als Kunde möchte ich per SEPA bezahlen können..."
4. "Als Kunde möchte ich Zahlungsbestätigung erhalten..."
5. "Als Administrator möchte ich Refunds verarbeiten..."
```

## **Epic-Management über mehrere Sprints:**

### **Epic Roadmap:**

```
Epic: Benutzer-Management (Q1 2025)
├── Sprint 1: Registrierung & Login
├── Sprint 2: Passwort-Reset & Validierung  
├── Sprint 3: Profil-Management
└── Sprint 4: Benutzer-Rollen & Berechtigungen

Epic Progress: 25% → 50% → 75% → 100%
```

### **Epic Burndown:**

```
Epic Story Points Remaining:
Sprint 0: 80 SP
Sprint 1: 65 SP (15 SP abgeschlossen)
Sprint 2: 45 SP (20 SP abgeschlossen)
Sprint 3: 25 SP (20 SP abgeschlossen)  
Sprint 4: 0 SP (25 SP abgeschlossen)
```

## **Kommunikation mit Stakeholdern:**

### **Epic-Ebene (für Management):**

```
"Wir entwickeln das Benutzer-Management-System.
Das ermöglicht Kundenregistrierung und -anmeldung.
Wird über 4 Sprints entwickelt (8 Wochen).
Business Value: Grundlage für alle E-Commerce-Funktionen."
```

### **User Story-Ebene (für Team):**

```
"Diese Woche implementieren wir Benutzerregistrierung.
Kunde kann sich mit E-Mail registrieren.
Bekommt Bestätigungs-E-Mail.
8 Story Points Aufwand geschätzt."
```

## **Zusammenfassung:**

**Epic** = Strategische Funktionalität (Warum?)

- Business-orientiert
- Mehrere Sprints
- Grobe Planung
- Roadmap-Ebene

**User Story** = Konkrete Implementierung (Was?)

- Nutzer-orientiert
- Ein Sprint
- Detaillierte Planung
- Sprint-Ebene

Diese Hierarchie ermöglicht es, sowohl strategisch (Epic) als auch operativ (User Story) zu planen und dabei den Nutzerfokus beizubehalten.