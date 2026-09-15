## 1. **Benutzer (User)**

**Menü:** Environmental parameters → Users

### Definition:

- Eine Person, die sich in ProjeQtOr **anmelden kann**
- Hat Login-Daten (Benutzername + Passwort)
- Besitzt ein **Profil mit Zugriffsrechten**

### Eigenschaften:

- **User name:** Login-ID für Anmeldung
- **Profile:** Bestimmt Zugriffsrechte (Administrator, Project Leader, Project Member, etc.)
- **Password:** Für Authentifizierung
- **Locked:** Kann gesperrt werden
- **API key:** Für Web-Service-Zugriff

### Verwendung:

- Alle Personen, die mit ProjeQtOr arbeiten sollen
- Bestimmt **WER** sich anmelden darf
- Regelt **WAS** die Person sehen/bearbeiten darf

## 2. **Ressource (Resource)**

**Menü:** Environmental parameters → Resource

### Definition:

- Eine Person oder Material, die **Arbeit an Projekten leisten kann**
- Kann Projekten zugewiesen und in der Planung verwendet werden
- Hat **Kapazität (FTE)** und **Verfügbarkeit**

### Eigenschaften:

- **Capacity (FTE):** Arbeitskapazität (z.B. 1.0 = Vollzeit, 0.5 = Teilzeit)
- **Calendar:** Arbeitszeiten und freie Tage
- **Functions & Costs:** Rollen und Tagessätze
- **Max daily/weekly work:** Arbeitszeitbegrenzungen
- **Team:** Zugehörigkeit zu einem Team
- **Organization:** Zugehörigkeit zu einer Organisation

### Verwendung:

- Für **Projektplanung** und **Arbeitsverteilung**
- **Timesheet-Eingabe** (Stundenzettel)
- **Gantt-Chart** Darstellung
- **Kapazitätsplanung**

## 3. **Team**

**Menü:** Environmental parameters → Teams

### Definition:

- Eine **Gruppe von Ressourcen**
- Organisatorische Einheit zur besseren Verwaltung
- Zur **Filterung** und **Berichterstattung**

### Eigenschaften:

- **Team members:** Liste der zugehörigen Ressourcen
- Eine Ressource kann nur **einem Team** angehören
- **Team allocation:** Ganzes Team einem Projekt zuweisen

### Verwendung:

- **Gruppenweise Zuweisung** zu Projekten
- **Filterung** in Reports und Ansichten
- **E-Mail-Verteilung** an Teamgruppen
- **Sichtbarkeitssteuerung** (Team-interne Notizen)

---

## Kombinationsmöglichkeiten:

### **Checkbox-Optionen bei der Erstellung:**

#### Bei **Benutzer-Erstellung:**

- ☑️ **"Is a resource"** → Wird auch als Ressource angelegt
- ☑️ **"Is a contact"** → Wird auch als Kontakt angelegt

#### Bei **Ressourcen-Erstellung:**

- ☑️ **"Is a user"** → Kann sich anmelden (benötigt dann Username + Profile)
- ☑️ **"Is a contact"** → Wird auch als Kontakt angelegt
- ☑️ **"Is an employee"** → Für HR-Modul

#### Bei **Kontakt-Erstellung:**

- ☑️ **"Is a user"** → Kann sich anmelden
- ☑️ **"Is a resource"** → Kann in Projekten arbeiten

---

## Praktisches Beispiel - Sarah M.:

### **Option A: Nur als Benutzer anlegen**

```
Environmental parameters → Users → New
- User name: sarah.m
- Real name: Sarah M.
- Profile: Project Leader
- ☑️ Is a resource
- ☑️ Is a contact
```

→ Erstellt automatisch User + Resource + Contact

### **Option B: Als Ressource anlegen**

```
Environmental parameters → Resource → New  
- Real name: Sarah M.
- Capacity (FTE): 1.0
- Team: Team Alpha
- ☑️ Is a user (dann Username + Profile erforderlich)
- ☑️ Is a contact
```

→ Erstellt Resource + User + Contact

### **Option C: Alle getrennt anlegen** (nicht empfohlen)

- Erst User anlegen
- Dann Resource anlegen
- Dann manuell verknüpfen

---

## Empfohlenes Vorgehen für Ihr Firmenjubiläum:

### **Team-Mitglieder (arbeiten aktiv am Projekt):**

```
Environmental parameters → Resource → New
```

**Für Sarah M., Michael K., Anna L., Tom R., Lisa P.:**

- Als **Ressource** anlegen
- ☑️ **"Is a user"** aktivieren
- **Team:** "Team Alpha" zuweisen
- **Profile:** "Project Member" (Sarah M. = "Project Leader")

### **Stakeholder (nur Informationen erhalten):**

```
Environmental parameters → Users → New
```

**Für Geschäftsführung, HR-Abteilung:**

- Als **Benutzer** anlegen
- **Profile:** "Project Guest"
- **NICHT** als Ressource (arbeiten nicht aktiv mit)

### **Externe Dienstleister:**

```
Environmental parameters → Contacts → New
```

**Für Caterer, Location-Anbieter, etc.:**

- Als **Kontakt** anlegen
- Können Dokumente/E-Mails erhalten
- Arbeiten nicht in ProjeQtOr

---

## Zusammenfassung der Rollen:

|Rolle|Kann sich anmelden|Erscheint in Planung|Kann Stunden erfassen|Erhält E-Mails|
|---|---|---|---|---|
|**Nur User**|✅|❌|❌|✅|
|**Nur Resource**|❌|✅|❌|❌|
|**User + Resource**|✅|✅|✅|✅|
|**Nur Contact**|❌|❌|❌|✅|
|**Team**|(Gruppe)|(Gruppe)|(Gruppe)|✅|

**Empfehlung:** Für aktive Projektmitarbeiter immer **"User + Resource"** verwenden!