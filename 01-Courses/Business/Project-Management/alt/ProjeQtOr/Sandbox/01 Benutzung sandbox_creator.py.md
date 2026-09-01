Der erstellte Benutzer kann sich **sofort** in der Sandbox anmelden! Das Script erstellt einen vollständig funktionsfähigen Benutzer mit allen notwendigen Einstellungen.

## Was automatisch konfiguriert wird:

✅ **Login-fähiger Benutzer** mit Benutzername und Passwort  
✅ **Zugewiesenes Profil** mit Berechtigungen  
✅ **Projektzuordnung** (Assignment) zur Sandbox  
✅ **Vollzugriff** auf das erstellte Sandbox-Projekt

## Sofortiger Login möglich:

```
🔗 Login-URL: https://projeqtor.metarow.com
👤 Benutzername: sandbox_user_20250606_143022
🔐 Passwort: K3mP9x@nF2qL
```

## Was der Benutzer nach dem Login sieht:

- **Nur sein Sandbox-Projekt** (Isolation von anderen Projekten)
- **Vollständige Berechtigungen** innerhalb der Sandbox:
    - Unterprojekte erstellen/bearbeiten/löschen
    - Aufgaben und Tickets verwalten
    - Dokumente hochladen
    - Berichte generieren
    - Weitere Benutzer zur Sandbox hinzufügen (je nach Profil-Konfiguration)

## Mögliche Zusatz-Konfiguration (optional):

Wenn Sie noch spezifischere Berechtigungen benötigen, können Sie das Script erweitern:## Erweiterte Konfiguration (config.json):

```json
{
  "server": {
    "url": "https://ihre-projeqtor-url.com",
    "username": "api_user", 
    "password": "ihr_api_passwort"
  },
  "project": {
    "project_type": "Development",
    "color": "#4CAF50",
    "parent_project_id": null
  },
  "user": {
    "profile_id": "3",
    "make_project_manager": true,
    "default_permissions": {
      "create_subprojects": true,
      "manage_users": false,
      "view_reports": true
    }
  }
}
```

## Wichtige Punkte für sofortigen Login:

1. **Kein E-Mail-Versand nötig** - Passwort wird direkt gesetzt
2. **Keine Aktivierung erforderlich** - Benutzer ist sofort aktiv
3. **Automatische Session-Berechtigung** - Zugriff auf zugewiesene Projekte
4. **Profil-Vererbung** - Alle Rechte des zugewiesenen Profils sind aktiv

## Test des Logins:

Sie können den Login direkt nach der Erstellung testen:

```bash
# Sandbox erstellen
python sandbox_creator.py --create "TestSandbox"

# Login-Daten werden ausgegeben:
# 👤 Benutzer: sandbox_user_20250606_143022  
# 🔐 Passwort: K3mP9x@nF2qL
# 🔗 Login: https://ihre-projeqtor-url.com

# Sofort im Browser testen!
```

**Der Benutzer kann sich also ohne weitere Schritte sofort anmelden und hat vollen Zugriff auf seine Sandbox!** 🎉

Die einzige potenzielle Einschränkung könnte von der **Profil-Konfiguration** abhängen - stellen Sie sicher, dass das verwendete Profil (profile_id in der config.json) die gewünschten Berechtigungen hat.