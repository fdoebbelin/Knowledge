##  Erfassung von Clients, Contacts, Resources und Users

### 1. **CLIENTS (Kunden/Auftraggeber)**

**Begriff:** Der Client ist die Entität, für die das Projekt durchgeführt wird. Es handelt sich um den Projektinhaber und meist auch Auftraggeber/Zahler.

**Menüpfad:** `Environment` > `Clients` > `New Element` (+)

#### 1.1 Erforderliche Felder:

```
ID: Eindeutige Kunden-ID (automatisch)
Client Name: Kurzer Name des Kunden
Client Code: Kundencode/Kürzel
Type of Client: Kundentyp (aus vordefinierter Liste)
Payment Deadline: Zahlungsfrist (in Tagen)
Tax: Steuersatz für Rechnungen
Tax Number: Steuernummer
Description: Vollständige Beschreibung
```

#### 1.2 Adressbereich:

```
Address: Vollständige Adresse des Kunden
Country, ZIP, City, etc.
```

#### 1.3 Verknüpfte Bereiche:

- **Projects Section:** Liste aller Projekte dieses Kunden
- **Contacts Section:** Ansprechpartner des Kunden
- **Financial Monitoring:** Angebote, Bestellungen, Rechnungen

**Praktisches Beispiel:**

```
Client Name: TechCorp Solutions GmbH
Client Code: TECH001
Type: Customer
Payment Deadline: 30 Tage
Tax: 19%
Tax Number: DE123456789
```

---

### 2. **CONTACTS (Kontakte/Ansprechpartner)**

**Begriff:** Ein Contact ist eine Person in geschäftlicher Beziehung zum Unternehmen. Kontakte können Personen in der Kundenorganisation oder andere Geschäftspartner sein.

**Menüpfad:** `Environment` > `Contacts` > `New Element` (+)

#### 2.1 Grunddaten:

```
Contact Name: Vor- und Nachname
Email: E-Mail-Adresse
Phone: Telefonnummer
Function: Position/Funktion
Client: Zugehörige Organisation
```

#### 2.2 Spezielle Felder:

```
Is a Resource: ☑ Contact wird auch als Ressource verwendet
Is a User: ☑ Contact kann sich in die Anwendung einloggen
```

**Wenn "Is a User" aktiviert:**

```
User Name: Login-Name (Pflichtfeld)
Profile: Benutzerprofil (Rechte-Gruppe)
```

**Wenn "Is a Resource" aktiviert:**

```
Erscheint automatisch in der Ressourcenliste
Kann Projekten zugewiesen werden
```

#### 2.3 Projektallokation:

```
Section "Allocations to project":
- Kontakt bestimmten Projekten zuweisen
- Rolle im Projekt definieren
- Berechtigung festlegen
```

**Praktisches Beispiel:**

```
Contact Name: Maria Schmidt
Email: m.schmidt@techcorp.de
Function: Projektleiterin
Client: TechCorp Solutions GmbH
Is a User: ☑ (kann sich einloggen)
User Name: mschmidt
Profile: Project Guest
```

---

### 3. **RESOURCES (Ressourcen/Mitarbeiter)**

**Begriff:** Resources sind Personen oder Teams, die Arbeit in Projekten leisten können. Sie können in der Projektplanung eingeteilt und ihnen Aufgaben zugewiesen werden.

**Menüpfad:** `Environment` > `Resources` > `New Element` (+)

#### 3.1 Grunddaten:

```
Resource Name: Name der Ressource
Initials: Kürzel/Initialen
Email: E-Mail-Adresse
Function: Hauptfunktion/Rolle
Organization: Zugehörige Organisation
```

#### 3.2 Kapazitäts-Einstellungen:

```
Full Time Equivalent (FTE): 
- 1.0 = Vollzeit (100%)
- 0.5 = Teilzeit (50%)
- >1.0 = Team-Ressource (z.B. 4.0 = 4-Personen-Team)

Max Work:
- Maximale Stunden pro Tag (z.B. 12h)
- Maximale Stunden pro Woche (z.B. 50h)
```

#### 3.3 Kostensätze:

```
Daily Cost: Tagessatz pro Funktion
Hourly Cost: Stundensatz
Valid from/to: Gültigkeitszeitraum
```

#### 3.4 Verknüpfungen:

```
Is a Contact: ☑ Erscheint auch in Kontaktliste
Is a User: ☑ Kann sich einloggen
Is an Employee: ☑ Für HR-Modul
```

**Praktisches Beispiel:**

```
Resource Name: Max Mustermann
Initials: MM
Function: Software Developer
FTE: 1.0 (Vollzeit)
Daily Cost: 800€
Is a User: ☑
User Name: mmustermann
Profile: Project Member
```

---

### 4. **USERS (Benutzer)**

**Begriff:** Users sind Personen, die sich in ProjeQtor einloggen können. Jeder User hat ein Profil, das seine Berechtigung definiert.

**Menüpfad:** `Environment` > `Users` > `New Element` (+)

#### 4.1 Authentifizierungsdaten:

```
User Name: Login-Name (eindeutig!)
Real Name: Echter Name
Email Address: E-Mail-Adresse
Profile: Berechtigungsprofil
Password: Initial-Passwort
```

#### 4.2 Vordefinierte Profile:

```
Administrator: Vollzugriff auf alle Funktionen
Supervisor: Überblick über alle Projekte
Project Leader: Vollzugriff auf eigene Projekte
Project Member: Mitarbeit in zugewiesenen Projekten
Project Guest: Eingeschränkte Sicht auf Projekte
```

#### 4.3 Verknüpfungen:

```
Is a Contact: ☑ Erscheint auch als Kontakt
Is a Resource: ☑ Kann Projekten zugewiesen werden
```

#### 4.4 Zusätzliche Einstellungen:

```
Locked: ☑ Benutzer gesperrt
Don't receive team mails: ☑ Keine Team-E-Mails
API Key: Für Webservice-Zugriff
```

**Praktisches Beispiel:**

```
User Name: pmustermann
Real Name: Peter Mustermann
Email: p.mustermann@firma.de
Profile: Project Leader
Is a Resource: ☑
Is a Contact: ☑
```

---

### **Ablauf der Einrichtung (Best Practice):**

#### **Schritt 1: Clients erstellen**

```
1. Kunden/Auftraggeber definieren
2. Adressen und Stammdaten erfassen
3. Zahlungskonditionen festlegen
```

#### **Schritt 2: Contacts anlegen**

```
1. Ansprechpartner bei Kunden erstellen
2. Interne Mitarbeiter als Contacts
3. Externe Partner und Dienstleister
```

#### **Schritt 3: Resources definieren**

```
1. Interne Mitarbeiter als Ressourcen
2. Kapazitäten und Kostensätze
3. Funktionen und Qualifikationen
```

#### **Schritt 4: Users konfigurieren**

```
1. Login-Berechtigungen vergeben
2. Profile entsprechend Rolle zuweisen
3. Passwort-Richtlinien beachten
```

#### **Schritt 5: Verknüpfungen herstellen**

```
1. Users ↔ Resources ↔ Contacts verknüpfen
2. Projekt-Allokationen vornehmen
3. Rollen und Berechtigungen prüfen
```

**Wichtiger Hinweis:** Ein Stakeholder kann gleichzeitig User, Resource und Contact sein. Die Daten werden geteilt, sodass Änderungen in einem Bereich automatisch in den anderen übernommen werden.