## 1. ProjeQtOr API-Einrichtung

### Server-seitige Vorbereitung

**API aktivieren:** ProjeQtOr bietet eine REST API, die standardmäßig aus Sicherheitsgründen deaktiviert ist:

1. **`.htpasswd` Datei erstellen:**

```bash
# Im ProjeQtOr /api/ Verzeichnis
htpasswd -c .htpasswd api_user
# Passwort eingeben wenn aufgefordert
```

2. **`.htaccess` Datei konfigurieren:**

```apache
# In /api/.htaccess
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ index.php?uri=$1
</IfModule>

AuthUserFile "/vollständiger/pfad/zu/projeqtor/api/.htpasswd"
AuthName "ProjeQtOr API"
AuthType Basic
require valid-user
```

3. **API-Benutzer in ProjeQtOr erstellen:**

- Der in .htpasswd definierte Benutzer muss als Benutzer in der Datenbank existieren
- Profil mit entsprechenden Rechten zuweisen (Projekte erstellen, Benutzer verwalten)
- API Key wird automatisch für den Benutzer generiert und für PUT/POST/DELETE-Methoden zur Verschlüsselung verwendet

## 2. Python-Environment Setup

**Abhängigkeiten installieren:**

```bash
pip install requests pycryptodome
```

## 3. Konfigurationsdatei erstellen

```bash
python sandbox_creator.py --sample-config
```

**Dann `config.json` anpassen:**

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
    "profile_id": "3"
  }
}
```

## 4. API-Zugriff testen

```bash
# Verbindung und Berechtigungen testen
python sandbox_creator.py --test
```

**Erwartete Ausgabe:**

```
🔍 Teste API-Zugriff...
✅ API-Verbindung erfolgreich getestet
📋 Verfügbare Profile: Admin, Project Manager, Developer, ...
✅ Konfiguriertes Profil (ID: 3) gefunden
```

## 5. Sandbox erstellen

```bash
# Automatische Sandbox erstellen
python sandbox_creator.py --create

# Oder mit benutzerdefiniertem Namen
python sandbox_creator.py --create "MeinTest_Sandbox"
```

**Erfolgreiche Ausgabe:**

```
🚀 Erstelle Sandbox: Sandbox_20250606_143022
✅ Projekt erstellt: Sandbox_20250606_143022
✅ Benutzer erstellt: sandbox_user_20250606_143022
✅ Zuordnung erstellt
🎉 Sandbox erfolgreich erstellt!
   📁 Projekt: Sandbox_20250606_143022 (ID: 42)
   👤 Benutzer: sandbox_user_20250606_143022
   🔐 Passwort: K3mP9x@nF2qL
💾 Details gespeichert in: sandbox_20250606_143022.json
```

## 6. Bestehende Sandboxes auflisten

```bash
python sandbox_creator.py --list
```

## 7. Automatisierung mit Cron

**Für regelmäßige Sandbox-Erstellung:**

```bash
# Crontab bearbeiten
crontab -e

# Täglich um 9:00 Uhr neue Sandbox erstellen
0 9 * * * /usr/bin/python3 /pfad/zu/sandbox_creator.py --create >> /var/log/sandbox_creation.log 2>&1
```

## Wichtige Funktionen des Scripts

**🔐 Verschlüsselung:** Das Script implementiert die AES-CTR Verschlüsselung, die ProjeQtOr für PUT/POST/DELETE Methoden erfordert

**✅ Fehlerbehandlung:** Vollständige Validierung und aussagekräftige Fehlermeldungen

**📊 Logging:** Detaillierte Protokollierung aller Aktionen

**🔄 Automatisierung:** Kann in CI/CD-Pipelines oder Cron-Jobs integriert werden

**💾 Persistierung:** Speichert alle erstellten Sandbox-Details in JSON-Dateien

## Problembehandlung

**Häufige Fehler:**

1. **"404 Not Found":** Rewrite-Regel in .htaccess prüfen, eventuell direkt index.php?uri= verwenden
    
2. **"user unknown in database":** API-Benutzer muss in ProjeQtOr existieren
    
3. **Verschlüsselungsfehler:** API Key des Benutzers prüfen und sicherstellen, dass der Benutzer korrekte Berechtigungen hat
    

**Debug-Modus aktivieren:**

```python
# Logging auf DEBUG setzen für detaillierte Ausgaben
logging.basicConfig(level=logging.DEBUG)
```

Die Lösung bietet eine vollständige, produktionstaugliche Automatisierung für ProjeQtOr Sandbox-Umgebungen mit sicherer API-Authentifizierung und robuster Fehlerbehandlung.