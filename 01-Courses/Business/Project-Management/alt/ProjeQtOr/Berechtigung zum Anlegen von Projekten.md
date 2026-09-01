Die Berechtigung zum Anlegen von Projekten in Projeqtor wird über das **CRUD-Rechtesystem** (Create, Read, Update, Delete) gesteuert und hängt von den **Access Modes** ab, die den verschiedenen Profilen zugewiesen sind.

### **CRUD-Rechte für Projekte**

Das System unterscheidet zwischen **project dependant** und **not project dependant** Elementen. Projekte sind dabei ein **not project dependant** Element, da sie die Grundlage für alle anderen Projektelemente bilden.

### **Verfügbare Access Modes für das Anlegen**

Für not project dependant Elemente wie Projekte bietet Projeqtor **5 verschiedene Access Modes**:

1. **Yes** - Allows the right to...
2. **No** - Does not allow the right to...
3. **Own elements** - Only the elements created by the user
4. **Elements he is responsible for** - Only the elements the user is responsible for
5. **[Weitere Modi je nach Elementtyp]**

### **Konfiguration der Projektanlage-Berechtigung**

Die Berechtigung wird konfiguriert unter: **Menüpfad:** `Settings` > `Access rights` > `Access to data` > `Not project dependant`

Hier kann für jedes Profile festgelegt werden, welche **Create-Rights** für Projects gewährt werden.

### **Typische Berechtigungen nach Profile**

**Administrator:**

- **Create-Right:** Yes (kann alle Projekte anlegen)
- Vollständige Berechtigung ohne Einschränkungen

**Supervisor:**

- **Create-Right:** Meist Yes (kann Projekte anlegen)
- Hat Visibility über alle Projekte

**Project Leader:**

- **Create-Right:** Meist Yes oder Own elements
- Kann eigene Projekte oder alle Projekte anlegen (je nach Konfiguration)

**Project Member:**

- **Create-Right:** Meist No oder Own elements
- Eingeschränkte oder keine Berechtigung

**Project Guest:**

- **Create-Right:** No
- Keine Berechtigung zum Anlegen von Projekten

### **Wichtige Hinweise**

1. **Individuelle Konfiguration:** Die tatsächlichen Berechtigungen können von der Standardkonfiguration abweichen, da sie vollständig anpassbar sind.
    
2. **Sort Order beachten:** Die **Sort Order** der Profile ist wichtig - ein Benutzer kann nur Profile zuweisen, die in der Hierarchie unter seinem eigenen stehen.
    
3. **Read Rights:** Grundsätzlich wird bei not project dependant Elementen die **Read-Berechtigung** als Basis gewährt.
    

### **Überprüfung der aktuellen Einstellungen**

Um zu sehen, wer in Ihrer Projeqtor-Installation Projekte anlegen darf, prüfen Sie:

- `Settings` > `Access rights` > `Access to data` > `Not project dependant`
- Dort die Spalte für "Create"-Rights bei "Project"

### **Zusätzliche Einschränkungen**

Über die **Restriction zone** können weitere Einschränkungen definiert werden:

- By type based on ProjeQtOr elements
- By product versions

Die Berechtigung zum Projektanlegen ist somit **nicht fix an bestimmte Profile gebunden**, sondern **vollständig konfigurierbar** über das Access Rights System und kann je nach Organisationsanforderungen angepasst werden.