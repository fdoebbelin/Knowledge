Die Installation einer eigenen Nextcloud-Instanz auf dem All-Inkl.com-Webspace bietet eine praktikable Alternative zu kommerziellen Cloud-Diensten, erfordert jedoch eine sorgfältige Konfiguration, um persönliche Daten angemessen zu schützen. Diese Anleitung führt systematisch durch alle erforderlichen Schritte zur Installation und maximalen Absicherung der Nextcloud auf der Subdomain cloud.doebbelin.net.

## Voraussetzungen und Einschränkungen

Bevor mit der Installation begonnen wird, ist es wichtig, die Möglichkeiten und Limitierungen des Shared-Hosting-Umfelds bei All-Inkl.com zu verstehen. Mindestens das Paket **ALL-INKL PrivatPlus** wird benötigt, um alle erforderlichen Funktionen wie Let's Encrypt-Zertifikate und Cronjobs nutzen zu können. Der Premium-Tarif bietet zusätzlich SSH-Zugang, der für erweiterte Wartungsarbeiten und die Ausführung von `occ`-Befehlen erforderlich ist.[^1][^2][^3]

**Wichtige Einschränkungen im Shared-Hosting:**

- Ressourcenintensive Apps wie Nextcloud Talk oder OnlyOffice können nicht betrieben werden, da diese zusätzliche Serverdienste erfordern[^2][^1]
- Memory Cache (OPcache) steht nur als Filecache zur Verfügung[^2]
- Upload-Limits sind auf maximal 1 GB für Smartphone-Synchronisierung beschränkt (Browser-Uploads können größer sein)[^2]
- ClamAV-Antivirus kann nicht installiert werden, da Root-Zugriff fehlt[^4][^5]

Trotz dieser Einschränkungen bietet die Lösung eine vollwertige File-Sharing- und Synchronisationslösung mit ausreichender Sicherheit für private und kleine geschäftliche Anwendungen.

## Schritt 1: Subdomain-Einrichtung und Basis-Installation

### Subdomain anlegen

Der erste Schritt besteht darin, im KAS (Kundenauftragssystem) von All-Inkl.com eine dedizierte Subdomain anzulegen. Die Verwendung einer eigenen Subdomain (cloud.doebbelin.net) anstelle eines Unterordners ist aus Sicherheitsgründen empfehlenswert, da dies die Same-Origin-Policy optimal nutzt und potenzielle Konflikte mit anderen Webanwendungen vermeidet.[^6][^7][^1]

**Vorgehensweise:**

1. Im KAS einloggen
2. Menüpunkt "Domain" → "Neue Subdomain" wählen
3. Subdomain "`cloud`" für die Domain "`doebbelin.net`" anlegen
4. PHP-Version auf die aktuell von Nextcloud empfohlene Version einstellen (derzeit PHP 8.1 oder 8.2)[^2]

### Nextcloud über Software-Installer installieren

All-Inkl.com bietet einen automatisierten Software-Installer, der die Installation erheblich vereinfacht:[^1][^2]

1. Im KAS zu **Software-Installation → Software auswählen → Software → Cloud** navigieren
2. **Nextcloud** auswählen
3. Die zuvor erstellte Subdomain cloud.doebbelin.net als Installationsziel angeben
4. Administrator-Benutzernamen festlegen (NICHT "admin" oder "nextcloud" verwenden - siehe Sicherheitsabschnitt)[^1]
5. Starkes Administrator-Passwort erstellen (mindestens 20 Zeichen, siehe Passwort-Best-Practices)
6. E-Mail-Adresse des Administrators angeben
7. Installation starten

Der Installer erstellt automatisch eine MariaDB-Datenbank und konfiguriert die Grundeinstellungen. Nach wenigen Minuten ist die Nextcloud grundsätzlich einsatzbereit, jedoch noch nicht sicher konfiguriert.[^2]

## Schritt 2: SSL/TLS-Verschlüsselung mit Let's Encrypt

Die Transportverschlüsselung über HTTPS ist die fundamentalste Sicherheitsmaßnahme und absolut unverzichtbar. All-Inkl.com bietet eine unkomplizierte Integration von kostenlosen Let's Encrypt-Zertifikaten.[^8][^9][^10][^11]

### Let's Encrypt-Zertifikat einrichten

**Schritt-für-Schritt-Anleitung:**

1. Im KAS unter **Domain** oder **Subdomain** die Domain cloud.doebbelin.net bearbeiten
2. Unter "SSL-Schutz" den Tab **"Let's Encrypt"** auswählen
3. Haken bei **"Haftungsausschluss akzeptieren"** setzen
4. Auf **"Jetzt ein Let's Encrypt Zertifikat beziehen und einbinden"** klicken[^10][^12]
5. Das Zertifikat wird innerhalb von 10 Minuten ausgestellt und automatisch eingebunden[^9][^10]

### HSTS (HTTP Strict Transport Security) aktivieren

Nach der Zertifikatseinrichtung muss HSTS aktiviert werden, um Man-in-the-Middle-Angriffe zu verhindern:[^13][^8]

1. SSL-Schutz-Einstellungen der Domain erneut bearbeiten
2. Folgende Optionen aktivieren:
    - **SSL erzwingen: Ja** (erzwingt Umleitung von HTTP zu HTTPS)
    - **HSTS aktivieren: Ja**
    - **max-age = 15552000** Sekunden (180 Tage)[^14][^1]

Diese Einstellung instruiert Browser, für die nächsten 180 Tage ausschließlich verschlüsselte HTTPS-Verbindungen zur Domain zuzulassen. Die Zertifikate werden automatisch etwa 30 Tage vor Ablauf erneuert.[^15][^8][^9]

## Schritt 3: PHP-Konfiguration optimieren

Nextcloud benötigt für einen stabilen Betrieb angepasste PHP-Parameter, die über die Standardwerte des Hosting-Pakets hinausgehen.[^16][^17][^1]

### Memory Limit und Execution Time erhöhen

Die `.user.ini`-Datei im Nextcloud-Hauptverzeichnis (z.B. `/www/htdocs/w123456/cloud.doebbelin.net/`) muss bearbeitet werden. Der Zugriff erfolgt entweder über WebFTP im KAS oder via FTP-Client:

**Erforderliche Einträge in `.user.ini`:**

```ini
memory_limit=512M
max_execution_time=7200
upload_max_filesize=256M
post_max_size=256M
```

**Erklärung der Parameter:**

- `memory_limit`: PHP-Speicherlimit. Minimum 512 MB, bei vielen Apps oder vielen Benutzern ggf. 768 MB oder 1024 MB[^16][^2]
- `max_execution_time`: Maximale Ausführungszeit für Skripte in Sekunden (7200 = 2 Stunden)[^17][^1]
- `upload_max_filesize`: Maximale Dateigröße für Uploads (256 MB ist ein guter Kompromiss)[^17]
- `post_max_size`: Maximale POST-Daten-Größe, sollte mindestens so groß wie upload_max_filesize sein[^17]

**Maximale Limits nach Paket:**[^16]

- ALL-INKL Privat: 64 MB
- ALL-INKL PrivatPlus: 128 MB
- ALL-INKL Premium: 256 MB
- ALL-INKL Business: 512 MB

**Kritischer Hinweis:** Die `.user.ini`-Datei wird bei Nextcloud-Updates überschrieben. Nach jedem Update muss die Datei überprüft und die Einträge ggf. erneut hinzugefügt werden. Eine Automatisierung über ein Cronjob-gestütztes PHP-Skript ist möglich.[^1][^17][^2]

### Alternative: .htaccess-Methode (PHP 7.x)

Bei PHP 7.x und älter konnten die Werte auch in der `.htaccess` eingetragen werden. Ab PHP 8 funktioniert diese Methode bei All-Inkl.com nicht mehr:[^18][^2]

```apache
php_value memory_limit 512M
php_value max_execution_time 7200
```

Diese Methode sollte nicht mehr verwendet werden.

## Schritt 4: Cronjob für Hintergrund-Aufgaben konfigurieren

Nextcloud benötigt einen Mechanismus für regelmäßige Wartungsaufgaben wie das Aufräumen temporärer Dateien, das Versenden von Benachrichtigungen und das Aktualisieren von Caches. Bei All-Inkl.com erfolgt dies über Webcrons.[^1][^2]

### Webcron im KAS einrichten

1. Im KAS zu **Tools → Cronjobs** navigieren
2. "Neuer Cronjob" erstellen
3. Protokoll: **https** auswählen
4. URL: `https://cloud.doebbelin.net/cron.php` (vollständige URL zur Subdomain)
5. Ausführungsintervall: ***/5** (alle 5 Minuten - Nextcloud-Empfehlung)[^1]
6. E-Mail-Adresse: eigene E-Mail-Adresse eintragen
7. E-Mail-Filter: **success** (nur bei Fehler benachrichtigen)[^1]

### Nextcloud-Einstellung anpassen

In den Nextcloud-Administrationseinstellungen muss nun die Cronjob-Methode angepasst werden:

1. Als Administrator in Nextcloud einloggen
2. **Verwaltung → Grundeinstellungen** aufrufen
3. Bei "Hintergrund-Aufgaben" die Option **"Webcron"** auswählen[^1]

Die Fehlermeldung bezüglich der Hintergrund-Aufgaben verschwindet nach der nächsten Ausführung des Cronjobs.

## Schritt 5: Trusted Domains konfigurieren

Die `trusted_domains`-Konfiguration ist eine essenzielle Sicherheitsmaßnahme gegen Host-Header-Poisoning-Angriffe.[^19][^20][^21]

### config.php bearbeiten

Die Datei `config/config.php` im Nextcloud-Verzeichnis muss bearbeitet werden. Zugriff erfolgt über WebFTP, FTP-Client oder SSH (ab Premium-Tarif):

```php
'trusted_domains' => 
array (
  0 => 'localhost',
  1 => 'cloud.doebbelin.net',
),
```

Die Subdomain cloud.doebbelin.net muss als vertrauenswürdige Domain eingetragen werden. Nur Domains in diesem Array sind für den Zugriff auf die Nextcloud berechtigt.[^20][^6]

**Optional: WWW-Variante hinzufügen** (falls www.cloud.doebbelin.net ebenfalls verwendet werden soll):

```php
'trusted_domains' => 
array (
  0 => 'localhost',
  1 => 'cloud.doebbelin.net',
  2 => 'www.cloud.doebbelin.net',
),
```


## Schritt 6: Zwei-Faktor-Authentifizierung (2FA) implementieren

Die Zwei-Faktor-Authentifizierung ist eine der wirksamsten Maßnahmen zum Schutz vor unberechtigtem Zugriff, selbst wenn das Passwort kompromittiert wurde.[^22][^23][^24][^25]

### TOTP-Provider installieren

1. Als Administrator in Nextcloud einloggen
2. Profilbild → **Apps** (App-Store) öffnen
3. Nach **"Two-Factor TOTP Provider"** suchen
4. App **"Herunterladen und aktivieren"**[^23][^26]

### 2FA für Administrator einrichten

1. Profilbild → **Persönliche Einstellungen** → **Sicherheit**
2. Unter "Zwei-Faktor-Authentifizierung" den Abschnitt **"TOTP aktivieren"** finden
3. Haken bei "TOTP aktivieren" setzen
4. Es wird ein QR-Code und ein TOTP-Schlüssel angezeigt
5. Authenticator-App auf dem Smartphone öffnen (z.B. Google Authenticator, Authy, FreeOTP)
6. QR-Code mit der App scannen oder TOTP-Schlüssel manuell eingeben
7. Sechsstelligen Code aus der Authenticator-App im Webinterface eingeben
8. **Backup-Codes herunterladen und sicher aufbewahren** (für den Fall, dass das Smartphone verloren geht)[^24][^23]

### 2FA für alle Benutzer erzwingen (optional)

In den Administrationseinstellungen unter **Verwaltung → Sicherheit** kann 2FA für alle Benutzer oder bestimmte Gruppen verpflichtend gemacht werden.[^26][^23]

### App-Passwörter für Clients erstellen

Nach Aktivierung von 2FA funktioniert das normale Passwort nicht mehr für Desktop-Clients, mobile Apps oder WebDAV-Zugriffe. Für jeden Client muss ein separates App-Passwort erstellt werden:[^27][^28][^24]

1. **Einstellungen → Sicherheit**
2. Unter "Geräte \& Sitzungen" → "Neues App-Passwort erstellen"
3. Namen für das Gerät eingeben (z.B. "Desktop PC", "iPhone")
4. Generiertes Passwort kopieren und im Client verwenden
5. Das App-Passwort kann jederzeit widerrufen werden, ohne das Hauptpasswort zu ändern[^28][^24]

## Schritt 7: Brute-Force-Schutz verstärken

Nextcloud bietet einen integrierten Brute-Force-Schutz, der standardmäßig aktiviert ist. Dieser kann durch zusätzliche Maßnahmen verstärkt werden.[^29][^30]

### Integrierter Brute-Force-Schutz

Der eingebaute Schutz funktioniert auf IP-Basis und implementiert Rate Limiting:[^29]

- Nach mehreren fehlgeschlagenen Login-Versuchen wird die IP-Adresse für eine bestimmte Zeit gesperrt
- Die Verzögerung zwischen Login-Versuchen erhöht sich exponentiell
- In extremen Fällen kann der Zugriff für bis zu 30 Minuten blockiert werden[^30]

**Konfiguration prüfen in config.php:**

```php
'auth.bruteforce.protection.enabled' => true,
```

Dieser Wert sollte niemals auf `false` gesetzt werden.[^31][^32][^30]

### IP-Adressen ausschließen (optional)

In den Administrationseinstellungen unter **Verwaltung → Sicherheit** können vertrauenswürdige IP-Adressen vom Brute-Force-Schutz ausgenommen werden. Dies sollte sehr restriktiv gehandhabt werden, da diese IPs unbegrenzte Login-Versuche durchführen können.[^30]

**Beispiel:** Eigene statische IP-Adresse zu Hause oder feste Büro-IP.

### Fail2Ban (nur mit SSH-Zugang ab Premium-Tarif)

Fail2Ban bietet eine zusätzliche Schutzebene auf Netzwerk-Level, indem verdächtige IPs auf Firewall-Ebene blockiert werden. Die Installation ist auf Shared-Hosting-Umgebungen bei All-Inkl.com nicht möglich, da Root-Rechte erforderlich sind. Die Erwähnung dient der Vollständigkeit für Nutzer mit Managed Servern oder eigenen VPS.[^33][^34][^29]

## Schritt 8: Starke Passwort-Richtlinien durchsetzen

Passwörter sind oft das schwächste Glied in der Sicherheitskette. Durch starke Passwort-Richtlinien und die Passwort-Policy-App kann das Risiko minimiert werden.[^25][^11]

### Best Practices für das Administrator-Passwort

Das Administrator-Konto ist das wertvollste Ziel für Angreifer:[^25]

- **Mindestens 20 Zeichen** (empfohlen 24+ Zeichen)[^24][^25]
- Kombination aus Groß-/Kleinbuchstaben, Zahlen und Sonderzeichen[^22][^25]
- **Keine persönlichen Informationen** oder leicht zu erratende Begriffe
- **Niemals** Standardnamen wie "admin", "administrator", "nextcloud" verwenden[^1]
- Passwort-Manager verwenden (z.B. KeePassXC, Bitwarden, 1Password)
- Nextcloud prüft aufgrund des bcrypt-Algorithmus nur die ersten 72 Zeichen[^11][^8]


### Password Policy App aktivieren

1. Apps → "Password policy" suchen und aktivieren
2. **Verwaltung → Sicherheit → Passwörter**
3. Mindestlänge festlegen (empfohlen: 12 Zeichen)
4. Optional: Komplexitätsanforderungen aktivieren
5. Optional: Passwörter gegen Have I Been Pwned-Datenbank prüfen[^35]

### Benutzer-Passwörter verwalten

Als Administrator sollten Sie:

- Benutzer über Passwort-Best-Practices aufklären
- Regelmäßige (aber nicht zu häufige) Passwortwechsel empfehlen (z.B. jährlich)
- Bei Verdacht auf Kompromittierung sofortigen Passwortwechsel erzwingen


## Schritt 9: Datenverschlüsselung konfigurieren

Nextcloud bietet verschiedene Verschlüsselungsebenen. Für eine All-Inkl.com-Installation sind folgende Aspekte relevant:[^36][^37][^38]

### Transportverschlüsselung (TLS/HTTPS)

Bereits durch Let's Encrypt in Schritt 2 implementiert. Dies schützt Daten während der Übertragung zwischen Client und Server.[^37][^36]

### Server-Side Encryption (SSE)

Die serverseitige Verschlüsselung verschlüsselt Dateien auf dem Server:[^38][^36][^37]

**Vorteile:**

- Schutz der Daten auf der Festplatte des Hosters
- Schutz bei physischem Zugriff auf die Server von All-Inkl.com

**Nachteile:**

- **Kein Schutz** vor kompromittierten Administratoren oder Server-Hacks[^37][^38]
- Schlüssel werden auf dem Server gespeichert
- Performance-Overhead
- Erhöhte Komplexität bei Wiederherstellung

**Empfehlung für All-Inkl.com:** Server-Side Encryption ist für eine reine Nextcloud-Installation auf All-Inkl.com-Webspace **nicht notwendig** und würde hauptsächlich zusätzliche Komplexität einführen. Die Verschlüsselung ist primär für External Storage (Dropbox, Google Drive etc.) konzipiert, was im Shared-Hosting-Kontext ohnehin nicht empfehlenswert ist.[^36][^37]

Falls dennoch gewünscht:

1. Apps → "Default encryption module" aktivieren
2. **Verwaltung → Sicherheit → Verschlüsselung**
3. "Aktiviere serverseitige Verschlüsselung" auswählen

**Wichtig:** Einmal aktivierte Verschlüsselung kann nur schwer wieder deaktiviert werden.[^39]

### End-to-End Encryption (E2EE)

Die Ende-zu-Ende-Verschlüsselung bietet den höchsten Schutz, da Dateien bereits auf dem Client verschlüsselt werden, bevor sie hochgeladen werden:[^36][^37]

- Der Server hat niemals Zugriff auf unverschlüsselte Daten
- Auch Administratoren können die Dateien nicht lesen
- Erfordert Desktop-/Mobile-Clients mit E2EE-Unterstützung
- Nur für spezielle, besonders sensible Ordner aktivierbar

**Einrichtung:**

1. Desktop-Client aktualisieren (E2EE-Unterstützung seit Version 3.0)
2. Ordner erstellen und als "Ende-zu-Ende verschlüsselt" markieren
3. Verschlüsselungspasswort (Mnemonic) sicher speichern[^40][^36]

### Vollständige Festplattenverschlüsselung

Bei All-Inkl.com liegt die Verantwortung für die Verschlüsselung der physischen Server bei All-Inkl.com selbst. Kunden haben hierauf keinen Einfluss. Nach Angaben von All-Inkl.com werden alle Daten ausschließlich auf Servern in Deutschland gespeichert.[^9]

## Schritt 10: Session-Management und Auto-Logout konfigurieren

Die Sitzungsverwaltung ist ein wichtiger Sicherheitsaspekt, besonders bei Zugriff von öffentlichen oder geteilten Geräten.[^41][^42][^43]

### Session-Parameter in config.php

Die `config/config.php` kann um folgende Parameter erweitert werden:[^42][^43][^41]

```php
// Session-Lebensdauer nach Inaktivität (in Sekunden)
'session_lifetime' => 86400, // 24 Stunden (Standard)

// Session Keep-Alive aktivieren
'session_keepalive' => true,

// Automatischer Logout nach session_lifetime (auch bei Aktivität)
'auto_logout' => false,

// Remember-Login-Cookie Lebensdauer
'remember_login_cookie_lifetime' => 1296000, // 15 Tage
```

**Empfohlene Einstellungen für hohe Sicherheit:**

```php
'session_lifetime' => 3600, // 1 Stunde
'session_keepalive' => true,
'auto_logout' => true, // Erzwingt Logout nach 1 Stunde
'remember_login_cookie_lifetime' => 0, // Deaktiviert "Angemeldet bleiben"
```

Diese Einstellung sorgt dafür, dass Benutzer nach einer Stunde Inaktivität automatisch abgemeldet werden. Bei aktivem `session_keepalive` wird die Sitzung bei Aktivität verlängert, aber `auto_logout => true` erzwingt dennoch einen Logout nach der definierten Zeit.[^43][^41][^42]

**Balance zwischen Sicherheit und Benutzerfreundlichkeit:**

- Für private Nutzung: 24 Stunden (Standard) mit `auto_logout => false`
- Für geschäftliche Nutzung: 1-8 Stunden mit `auto_logout => true`
- Für hochsensible Daten: 15-30 Minuten mit `auto_logout => true`[^41]


## Schritt 11: File Access Control (Dateizugriffskontrolle)

Die File Access Control App ermöglicht granulare Zugriffsbeschränkungen basierend auf verschiedenen Kriterien.[^44][^45][^46]

### App aktivieren

1. Apps → "Files access control" suchen
2. App aktivieren (verfügbar ab Nextcloud 18)[^45][^44]

### Regelbasierte Zugriffskontrolle einrichten

**Verwaltung → Sicherheit → File Access Control**

Regelgruppen bestehen aus einer oder mehreren Regeln. Wenn alle Regeln einer Gruppe zutreffen, wird der Zugriff verweigert.[^46][^44]

**Verfügbare Regelkriterien:**[^44][^45]

- **IP-Adresse/Bereich:** Zugriff nur von bestimmten IPs erlauben/verbieten
- **Benutzergruppe:** Regeln für bestimmte Gruppen
- **Kollaborative Tags:** Dateien mit bestimmten Tags schützen
- **MIME-Typ:** Zugriff auf bestimmte Dateitypen beschränken (z.B. ausführbare Dateien)
- **Zeitfenster:** Zugriff nur zu bestimmten Zeiten erlauben
- **User-Agent:** Bestimmte Clients blockieren
- **Dateiname/Größe:** Regeln basierend auf Dateiattributen

**Beispiel-Szenarien:**

**1. Zugriff nur aus Deutschland erlauben:**

```
Regel: IP-Adresse nicht in 0.0.0.0/0
UND: IP-Adresse in [Deutsche IP-Bereiche]
→ Blockieren
```

**2. Hochladen von ausführbaren Dateien verhindern:**

```
Regel: MIME-Typ ist application/x-executable
ODER: MIME-Typ ist application/x-msdownload
→ Blockieren
```

**3. Vertrauliche Ordner für externe Zugriffe sperren:**

```
Regel: Kollaboratives Tag ist "vertraulich"
UND: IP-Adresse nicht in 192.168.0.0/16 (internes Netzwerk)
→ Blockieren
```

**Hinweis:** File Access Control sollte gezielt eingesetzt werden. Zu restriktive Regeln können die Benutzerfreundlichkeit erheblich einschränken.[^45][^44]

## Schritt 12: Datenschutz und DSGVO-Konformität

Für den Betrieb einer Nextcloud mit personenbezogenen Daten in Deutschland ist die DSGVO-Konformität relevant.[^47][^48][^49]

### Grundlegende DSGVO-Anforderungen

**Vorteile der All-Inkl.com-Lösung:**[^47]

- Server stehen in Deutschland (EU-Datenschutz)
- Auftragsverarbeitungsvertrag (AVV) mit All-Inkl.com abschließbar
- Vollständige Kontrolle über Zugriffe und Berechtigungen
- Keine automatische Datenübermittlung an Drittländer


### Datenschutz-Konfiguration

**1. Datenschutz- und Impressumslinks einrichten:**

In den Administrationseinstellungen unter **Verwaltung → Allgemein** können Links zum Impressum und zur Datenschutzerklärung hinterlegt werden, die auf der Login-Seite angezeigt werden.[^47]

**2. Terms of Service App aktivieren:**

Die "Terms of Service" App ermöglicht es, Nutzungsbedingungen anzuzeigen, die vor dem ersten Login akzeptiert werden müssen:[^47]

1. Apps → "Terms of service" installieren
2. **Verwaltung → Nutzungsbedingungen** aufrufen
3. Nutzungsbedingungen verfassen oder hochladen
4. Akzeptierung für alle Benutzer erzwingen

**3. Data Request App (für DSGVO-Auskunftsanfragen):**

Ermöglicht Benutzern das Anfordern ihrer gespeicherten Daten oder die Kontolöschung:[^47]

1. Apps → "Data request" installieren
2. Benutzer können über ihre Einstellungen Datenanfragen stellen
3. Administratoren werden benachrichtigt und können die Anfrage bearbeiten

### Datenminimierung

- **Nur notwendige Apps aktivieren:** Deaktivieren Sie Apps, die Sie nicht benötigen (z.B. Surveys, Recommendations)
- **Logging begrenzen:** Protokollierung auf notwendiges Maß reduzieren
- **Automatische Löschung:** Alte Logs und temporäre Dateien regelmäßig löschen


### Verarbeitungsverzeichnis führen

Dokumentieren Sie:

- Welche personenbezogenen Daten gespeichert werden (Namen, E-Mail-Adressen, Dateien)
- Zu welchem Zweck (File-Sharing, Kollaboration)
- Wer Zugriff hat (Administratoren, Benutzer)
- Wie lange Daten gespeichert werden
- Welche Sicherheitsmaßnahmen getroffen wurden[^49][^47]


## Schritt 13: Backup-Strategie implementieren

Ein zuverlässiges Backup ist essentiell, um Datenverlust durch technische Probleme, Fehler oder Sicherheitsvorfälle zu verhindern.[^50][^51][^52]

### Was muss gesichert werden?

**Vollständiges Backup umfasst:**[^51][^53][^50]

1. **Nextcloud-Installationsverzeichnis** (z.B. `/www/htdocs/w123456/cloud.doebbelin.net/`)
    - Enthält alle Nextcloud-Dateien, Apps, Themes
    - Größe: ca. 500 MB - 1 GB
2. **Datenverzeichnis** (data/)
    - Enthält alle Benutzerdateien, Versionen, Trash
    - Größe: variabel, je nach Nutzung
3. **Datenbank**
    - MariaDB-Datenbank mit Benutzern, Metadaten, Freigaben
    - Größe: üblicherweise 100-500 MB
4. **config.php**
    - Enthält alle Konfigurationseinstellungen, inkl. Datenbankpasswort
    - Kritisch für Wiederherstellung

### Backup-Methoden bei All-Inkl.com

**Methode 1: Manuelles Backup via SSH (ab Premium-Tarif)**[^2]

```bash
# 1. Wartungsmodus aktivieren
cd /www/htdocs/w123456/cloud.doebbelin.net
php occ maintenance:mode --on

# 2. Datenbank sichern
mysqldump -h [DB-HOST] -u [DB-USER] -p[DB-PASS] [DB-NAME] > backup.sql

# 3. Archiv erstellen
tar -czf nextcloud-backup-$(date +%Y%m%d).tar.gz \
    cloud.doebbelin.net/ backup.sql

# 4. Wartungsmodus deaktivieren
php occ maintenance:mode --off

# 5. Backup herunterladen
# Per FTP/SFTP oder mit scp
```

**Methode 2: Automatisiertes Backup mit lokalem Skript**[^2]

Bei All-Inkl.com kann ein lokales Skript (Windows/Linux/Mac) über SSH die Sicherung automatisiert durchführen und herunterladen:

**Windows (PowerShell):**

```powershell
# Mit plink.exe (PuTTY) und pscp.exe
plink.exe -batch -pw $PASSWORD $USER@$HOST "mysqldump -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_NAME > backup.sql"
plink.exe -batch -pw $PASSWORD $USER@$HOST "tar -czf backup.tar.gz cloud.doebbelin.net/ backup.sql"
pscp.exe -pw $PASSWORD $USER@$HOST:backup.tar.gz ./local-backup/backup-$(Get-Date -Format yyyyMMdd).tar.gz
```

**Methode 3: BorgBackup für inkrementelle Backups**[^51]

BorgBackup bietet Deduplizierung und Kompression, wodurch Speicherplatz gespart wird. Die Einrichtung erfordert SSH-Zugang und ist für fortgeschrittene Nutzer geeignet.[^51]

### Backup-Frequenz

**Empfohlener Zeitplan:**

- **Tägliche Backups** bei aktiver Nutzung
- **Wöchentliche Backups** bei seltener Nutzung
- **Vor jedem Update** ein manuelles Backup[^54][^2]


### Backup-Aufbewahrung

**Rotationsschema (Generationenprinzip):**

- 7 tägliche Backups behalten
- 4 wöchentliche Backups behalten
- 12 monatliche Backups behalten


### Backup-Sicherheit

- **Verschlüsselte Speicherung:** Backups mit Tools wie GPG verschlüsseln
- **Geografische Trennung:** Backups nicht nur bei All-Inkl.com lagern, sondern auch lokal und/oder bei anderem Cloud-Anbieter
- **Regelmäßige Restore-Tests:** Mindestens vierteljährlich einen Wiederherstellungstest durchführen[^52][^50]


### Backup-Verifizierung

Nach jedem Backup prüfen:

- Ist die Backup-Datei vollständig erstellt worden?
- Ist die Dateigröße plausibel?
- Lässt sich das Archiv entpacken?
- Testweise eine Datei aus dem Backup wiederherstellen


## Schritt 14: Updates und Wartung

Regelmäßige Updates sind kritisch für die Sicherheit, da sie Sicherheitslücken schließen.[^55][^56][^57][^54]

### Update-Methoden

**Option 1: Web-Updater (einfach, aber langsam)**[^57][^54]

1. Als Administrator einloggen
2. **Einstellungen → Übersicht**
3. Bei verfügbarem Update auf "Updater öffnen" klicken
4. Anweisungen folgen

**Nachteil:** Kann bei großen Updates an Laufzeit-Limits stoßen.[^54][^2]

**Option 2: Command-Line Updater (empfohlen, ab Premium-Tarif)**[^56][^57][^54]

```bash
# 1. Backup durchführen (siehe Schritt 13)

# 2. SSH-Verbindung aufbauen
ssh ssh-[login]@[login].kasserver.com

# 3. In Updater-Verzeichnis wechseln
cd /www/htdocs/w123456/cloud.doebbelin.net/updater

# 4. Update durchführen
php updater.phar --no-backup

# 5. Upgrade-Routinen ausführen
cd /www/htdocs/w123456/cloud.doebbelin.net
php occ upgrade

# 6. Apps aktualisieren
php occ app:update --all

# 7. Datenbank-Optimierungen
php occ db:add-missing-indices
php occ db:add-missing-columns
```

Der Parameter `--no-backup` wird empfohlen, da das eigene Backup zuverlässiger ist und Zeit spart.[^54]

### Update-Automatisierung

Updates können mit einem Cronjob automatisiert werden, jedoch ist Vorsicht geboten:[^56]

**Vorteile:**

- Sicherheitsupdates werden sofort eingespielt
- Kein manueller Aufwand

**Nachteile:**

- Bei Problemen kann die Nextcloud offline gehen
- Keine Möglichkeit, vor dem Update zu testen
- Kein manuelles Backup vor dem Update

**Empfehlung:** Manuelle Updates mit Backup sind für produktive Systeme vorzuziehen. Automatisierung nur für Test-Systeme.

### Post-Update-Prüfungen

Nach jedem Update:

1. **`.user.ini` prüfen:** PHP-Parameter müssen ggf. neu eingetragen werden[^2][^1]
2. **Sicherheitscheck durchführen:** Einstellungen → Übersicht → Alle Warnungen prüfen
3. **Logs prüfen:** Verwaltung → Protokollierung → Nach Fehlern suchen
4. **Funktionstest:** Login, Datei-Upload, Synchronisation testen

### Update-Zeitplan

- **Minor Updates** (z.B. 28.0.1 → 28.0.2): Zeitnah einspielen, meist nur Bugfixes
- **Major Updates** (z.B. 28 → 29): Nach 2-4 Wochen einspielen, nach Feedback der Community
- **Sicherheitsupdates:** Sofort einspielen (werden in Release Notes als Security Fix gekennzeichnet)


## Schritt 15: Sicherheitsüberwachung und -prüfung

### Nextcloud Security Scan

Nextcloud bietet einen eingebauten Sicherheitscheck:[^58]

**Verwaltung → Übersicht → Sicherheits- und Einrichtungswarnungen**

Alle angezeigten Warnungen sollten beseitigt werden. Häufige Warnungen und ihre Lösungen:


| Warnung | Lösung |
| :-- | :-- |
| PHP Memory Limit zu niedrig | `.user.ini` anpassen (siehe Schritt 3)[^1][^16] |
| Kein Memory Cache | Bei Shared Hosting akzeptabel, kann ignoriert werden[^2] |
| HSTS-Header fehlt | SSL-Einstellungen im KAS prüfen (siehe Schritt 2)[^13][^59] |
| Cron nicht konfiguriert | Webcron einrichten (siehe Schritt 4)[^1] |
| Datenverzeichnis erreichbar | `.htaccess` sollte dies verhindern, ggf. Support kontaktieren[^60] |

### Security Scan von scan.nextcloud.com

Nextcloud bietet einen externen Security Scanner:

1. https://scan.nextcloud.com aufrufen
2. URL `https://cloud.doebbelin.net` eingeben
3. Scan starten
4. Ergebnis analysieren und Empfehlungen umsetzen[^55][^58]

Der Scanner prüft:

- SSL/TLS-Konfiguration und Zertifikat
- HTTP Security Headers (HSTS, CSP, X-Frame-Options)
- Erreichbarkeit vertraulicher Dateien
- Bekannte Sicherheitslücken in der verwendeten Version

**Ziel:** A+ Rating erreichen[^55]

### Log-Monitoring

**Verwaltung → Protokollierung**

Regelmäßig (wöchentlich) die Logs auf verdächtige Aktivitäten prüfen:

- Mehrfache fehlgeschlagene Login-Versuche von unbekannten IPs
- Ungewöhnliche Zugriffe auf System-Dateien
- PHP-Fehler oder Warnungen
- Datenbankfehler

**Log-Level konfigurieren in config.php:**

```php
'loglevel' => 2, // 0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL
```

Für Produktivsysteme ist Level 2 (WARN) empfohlen.[^32][^31]

### Audit Log (Enterprise Feature)

Die Audit-Log-App protokolliert alle sicherheitsrelevanten Ereignisse. In der Community Edition nicht verfügbar, aber für geschäftliche Nutzung relevant.[^47]

### Benutzeraktivitäten überwachen

**Verwaltung → Nutzer**

Regelmäßig prüfen:

- Wann haben sich Benutzer zuletzt angemeldet?
- Gibt es inaktive Konten, die deaktiviert werden können?
- Gibt es ungewöhnliche Speichernutzung?
- Sind die Kontingente angemessen?

Inaktive Konten sollten nach 6-12 Monaten deaktiviert werden.

## Schritt 16: Erweiterte Sicherheitskonfigurationen

### Admin-IP-Beschränkung

In der `config.php` kann der Admin-Zugriff auf bestimmte IP-Bereiche beschränkt werden:[^61]

```php
'allowed_admin_ranges' => [
  '192.168.0.0/16',    // Heimnetzwerk
  '87.123.45.67/32',   // Feste externe IP
],
```

Benutzer können weiterhin von überall zugreifen, aber administrative Funktionen sind nur von vertrauenswürdigen IPs aus verfügbar.

### Token-basierte Authentifizierung erzwingen

Für höhere Sicherheit kann die Verwendung von Passwörtern für Clients komplett deaktiviert werden:[^19][^32]

```php
'token_auth_enforced' => true,
```

Dies erzwingt, dass alle Clients App-Passwörter verwenden müssen. Erhöht die Sicherheit, kann aber die Benutzerfreundlichkeit beeinträchtigen.

### Security Headers prüfen

Die `.htaccess` im Nextcloud-Verzeichnis enthält bereits Security Headers. Diese können mit curl geprüft werden:

```bash
curl -I https://cloud.doebbelin.net
```

**Erwartete Header:**[^62][^8]

- `Strict-Transport-Security: max-age=15552000; includeSubDomains`
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: SAMEORIGIN`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: no-referrer`
- `Content-Security-Policy: ...` (komplexe CSP 3.0-Richtlinie)

Falls Header fehlen, `.htaccess` prüfen und ggf. mit einer frischen Installation vergleichen.

### PHP-Sicherheitsfunktionen

In der `.user.ini` können zusätzlich PHP-Sicherheitsmaßnahmen konfiguriert werden:[^63][^64]

```ini
; Gefährliche Funktionen deaktivieren (falls von Nextcloud nicht benötigt)
disable_functions = exec,passthru,shell_exec,system,proc_open,popen

; open_basedir beschränken (Pfad anpassen)
open_basedir = /www/htdocs/w123456/cloud.doebbelin.net/:/tmp/
```

**Achtung:** Die Deaktivierung von Funktionen kann bestimmte Nextcloud-Features beeinträchtigen. Vor Produktiveinsatz testen!

### Externe Speicher deaktivieren

Wenn externe Speicher (External Storage) nicht benötigt werden, sollte die App deaktiviert werden:[^65][^39]

1. Apps → "External storage support" deaktivieren

Dies reduziert die Angriffsfläche und verhindert versehentliche Datenlecks durch Fehlkonfigurationen.

## Zusammenfassung der kritischen Sicherheitsmaßnahmen

Die folgende Checkliste fasst die wichtigsten Sicherheitsschritte zusammen:

### Must-Have (Unverzichtbar)

✅ **SSL/TLS mit HSTS** - Let's Encrypt-Zertifikat mit HSTS (max-age=15552000)[^8][^9][^1]
✅ **Starkes Admin-Passwort** - Mindestens 20 Zeichen, keine Standardnamen[^11][^25][^1]
✅ **Zwei-Faktor-Authentifizierung** - TOTP für alle Administratoren[^23][^24][^25]
✅ **Trusted Domains** - Nur cloud.doebbelin.net in config.php[^21][^20][^32]
✅ **Brute-Force-Schutz aktiviert** - Standardmäßig an, niemals deaktivieren[^31][^29][^30]
✅ **Regelmäßige Backups** - Täglich/wöchentlich, Datenbank + Dateien + Config[^50][^52][^51]
✅ **Aktuelle Version** - Sicherheitsupdates zeitnah einspielen[^57][^56][^55]
✅ **PHP-Limits angepasst** - Memory 512MB+, Execution Time 7200s[^16][^17][^1]
✅ **Cronjob konfiguriert** - Webcron alle 5 Minuten[^2][^1]

### Should-Have (Dringend empfohlen)

🔸 **App-Passwörter für Clients** - Separate Tokens für jedes Gerät[^27][^28][^24]
🔸 **Session-Timeouts** - Angemessene Werte in config.php[^42][^43][^41]
🔸 **Security Scan durchgeführt** - scan.nextcloud.com nutzen[^58][^55]
🔸 **Log-Monitoring** - Wöchentliche Prüfung der Logs[^31]
🔸 **Passwort-Policy** - Mindestlänge für Benutzer erzwingen[^35][^25]
🔸 **Deaktivierte Benutzer entfernen** - Inaktive Konten regelmäßig prüfen
🔸 **DSGVO-Compliance** - Datenschutzerklärung, Impressum, AVV[^49][^47]
🔸 **`.user.ini` nach Updates prüfen** - Wird überschrieben[^17][^1][^2]

### Nice-to-Have (Optional, erhöht Sicherheit)

⭐ **File Access Control** - IP-basierte oder regelbasierte Zugriffsbeschränkungen[^46][^44][^45]
⭐ **Admin-IP-Beschränkung** - allowed_admin_ranges in config.php[^61]
⭐ **Token-Auth erzwingen** - token_auth_enforced für maximale Sicherheit[^32]
⭐ **External Storage deaktivieren** - Falls nicht benötigt[^39][^65]
⭐ **End-to-End-Encryption** - Für besonders sensible Ordner[^37][^36]
⭐ **Automatisierte Backups** - Mit lokalem Skript und Benachrichtigungen[^51][^2]

## Performance-Optimierung vs. Sicherheit

Einige Sicherheitsmaßnahmen können die Performance beeinträchtigen. Die folgende Tabelle zeigt typische Trade-offs:


| Maßnahme | Sicherheitsgewinn | Performance-Impact | Empfehlung |
| :-- | :-- | :-- | :-- |
| SSL/TLS | Hoch | Minimal | Immer aktivieren |
| 2FA | Hoch | Keiner (nur Login) | Immer aktivieren |
| Server-Side Encryption | Mittel | Hoch (10-20%) | Nur bei Bedarf |
| Brute-Force-Schutz | Hoch | Minimal | Immer aktiviert |
| File Access Control | Mittel | Gering | Bei Bedarf |
| Strenge Session-Timeouts | Mittel | Keiner | Empfohlen |
| Log-Level DEBUG | Keiner (Diagnose) | Gering | Nur temporär |

## Einschränkungen von All-Inkl.com Shared Hosting

Trotz aller Optimierungen gibt es technische Grenzen beim Shared Hosting:

**Nicht möglich:**

- ClamAV Antivirus-Integration (Root-Rechte erforderlich)[^5][^66][^4]
- Fail2Ban auf System-Ebene (Root-Rechte erforderlich)[^33][^29]
- Redis oder Memcached als distributed cache (nur Managed Server)[^2]
- Nextcloud Talk (zusätzliche Dienste erforderlich)[^1][^2]
- OnlyOffice/Collabora Online (zusätzliche Dienste erforderlich)[^1][^2]
- Voller OPcache-Zugriff (nur Filecache verfügbar)[^2]

**Workarounds:**

- Integrierter Nextcloud Brute-Force-Schutz statt Fail2Ban[^29][^30]
- Nextcloud Security Scan statt Antivirus[^58][^55]
- Eingebaute Office-Vorschau statt OnlyOffice
- APCu als Memory Cache bei Managed Servern[^2]

Diese Einschränkungen sind für private und kleine geschäftliche Nutzung in der Regel akzeptabel.

## Troubleshooting häufiger Probleme

### Problem: Sicherheitswarnungen nach Installation

**Lösung:** Systematisch durch die Sicherheits- und Einrichtungswarnungen gehen (Verwaltung → Übersicht) und jeden Punkt abarbeiten:[^58]

- PHP Memory Limit: `.user.ini` anpassen[^16][^1]
- HSTS: SSL-Einstellungen im KAS prüfen[^59][^13]
- Cron: Webcron einrichten[^1]


### Problem: `.user.ini` wird nach Update überschrieben

**Lösung:** Nach jedem Update die `.user.ini` überprüfen und fehlende Zeilen wieder eintragen. Alternativ ein Cronjob-gestütztes PHP-Skript erstellen, das die Einträge automatisch ergänzt.[^17][^1][^2]

### Problem: Upload von großen Dateien schlägt fehl

**Lösung:**

1. `upload_max_filesize` und `post_max_size` in `.user.ini` erhöhen[^18][^17]
2. Paketlimits von All-Inkl.com beachten (max. 1GB bei Smartphone-Sync)[^2]
3. Größere Uploads über Browser statt Mobile App durchführen[^2]

### Problem: "Trusted Domain"-Fehler

**Lösung:** Die Subdomain cloud.doebbelin.net in der `config.php` unter `trusted_domains` hinzufügen.[^6][^20][^21]

### Problem: 2FA-Code wird nicht akzeptiert

**Lösungen:**

- Zeiteinstellungen auf Smartphone prüfen (muss mit Server synchron sein)[^23][^24]
- Backup-Codes verwenden[^23]
- Als Admin: 2FA für betroffenen Benutzer temporär deaktivieren via occ-Befehl (SSH erforderlich)[^67]


### Problem: Nextcloud lädt nach Update nicht mehr

**Lösungen:**

1. Wartungsmodus manuell deaktivieren: In `config.php` den Eintrag `'maintenance' => false,` setzen[^57][^54]
2. PHP Memory Limit erhöhen (nach Updates oft zu niedrig)[^2]
3. Logs prüfen: `data/nextcloud.log` auf Fehlermeldungen untersuchen
4. Im Notfall: Backup zurückspielen und Update erneut durchführen[^54][^2]

## Langfristige Wartung und Best Practices

### Monatliche Aufgaben

- Sicherheits- und Einrichtungswarnungen prüfen[^58]
- Logs auf Auffälligkeiten untersuchen[^31]
- Speicherplatznutzung überwachen
- Inaktive Benutzer identifizieren
- Verfügbare Updates prüfen (aber nicht sofort einspielen)[^56][^57]


### Vierteljährliche Aufgaben

- Backup-Restore-Test durchführen[^52][^50]
- Passwörter ändern (Admin + wichtige Accounts)
- Benutzerberechtigungen überprüfen
- Security Scan durchführen[^55][^58]
- Nicht verwendete Apps deaktivieren/entfernen


### Jährliche Aufgaben

- Vollständige Sicherheitsaudit durchführen
- Alle Benutzer zu Passwortwechsel auffordern
- AVV mit All-Inkl.com aktualisieren (falls geschäftlich)[^47]
- Backup-Strategie überprüfen und ggf. anpassen
- Dokumentation aktualisieren (Verarbeitungsverzeichnis)[^49][^47]


### Dokumentation führen

Eine übersichtliche Dokumentation erleichtert die Wartung erheblich:

**Zu dokumentieren:**

- Installationsdatum und Version
- Administrator-Kontaktdaten
- Backup-Zeitplan und -Speicherorte
- Durchgeführte Sicherheitsmaßnahmen
- Besonderheiten der Konfiguration
- Update-Historie mit Datum und aufgetretenen Problemen
- Benutzer und deren Rollen/Gruppenzugehörigkeiten

Ein einfaches Markdown- oder Text-Dokument im Backup-Ordner ist ausreichend.

## Fazit und Empfehlung

Die Installation und Absicherung von Nextcloud auf All-Inkl.com ist eine praktikable Lösung für private Nutzer und kleine Organisationen, die Kontrolle über ihre Daten behalten möchten. Die wichtigsten Erkenntnisse:

**Sicherheitsniveau:** Mit konsequenter Umsetzung aller "Must-Have" und "Should-Have" Maßnahmen erreicht die Installation ein hohes Sicherheitsniveau, das für persönliche und geschäftliche Daten geeignet ist.[^8][^55][^47]

**Aufwand:** Die Ersteinrichtung erfordert 2-4 Stunden konzentrierte Arbeit. Die laufende Wartung benötigt etwa 1-2 Stunden pro Monat.[^1][^2]

**Kosten:** Ab 4,95 €/Monat (PrivatPlus-Tarif) für grundlegende Funktionen, empfohlen 9,95 €/Monat (Premium-Tarif) für SSH-Zugang und größere Ressourcen.[^3][^16]

**Eignung:**

- ✅ **Geeignet für:** Privatpersonen, Familien, kleine Vereine, Freiberufler, kleine Unternehmen (bis ca. 10-15 Nutzer)
- ⚠️ **Bedingt geeignet:** Mittlere Unternehmen (Managed Server erwägen), Organisationen mit höchsten Compliance-Anforderungen
- ❌ **Nicht geeignet:** Große Unternehmen, Organisationen mit intensiver Kollaborationsanforderung (Talk, OnlyOffice), sehr hohe Nutzerzahlen (>50)

**Alternativen für höhere Anforderungen:**

- All-Inkl.com Managed Server (volle Kontrolle, mehr Ressourcen)
- Hetzner Nextcloud Managed Hosting (automatische Updates, Backups)[^2]
- Eigener VPS/dedizierter Server (maximale Kontrolle und Flexibilität)

**Kritische Erfolgsfaktoren:**

1. **Konsequente Umsetzung** aller Sicherheitsmaßnahmen (nicht "später")
2. **Regelmäßige Backups** mit Test-Restores
3. **Zeitnahe Updates**, besonders bei Sicherheitslücken
4. **Aktive Überwachung** statt "Set and Forget"
5. **Benutzerschulung** zu sicheren Passwörtern und Phishing

Mit dieser umfassenden Anleitung ist eine sichere und DSGVO-konforme Nextcloud-Installation auf cloud.doebbelin.net realisierbar. Die persönlichen Daten sind durch mehrere Sicherheitsebenen geschützt: Transportverschlüsselung (HTTPS), Zugangsschutz (2FA), Brute-Force-Schutz, regelmäßige Updates und Backups. Der Betrieb auf deutschen Servern unter vollständiger eigener Kontrolle bietet ein deutlich höheres Datenschutzniveau als kommerzielle Cloud-Dienste in Drittländern.

Die wichtigste Empfehlung: **Sicherheit ist ein Prozess, kein Zustand.** Die initiale Absicherung ist erst der Anfang. Nur durch kontinuierliche Wartung, Überwachung und Anpassung an neue Bedrohungen bleibt die Nextcloud-Installation langfristig sicher.
<span style="display:none">[^100][^101][^102][^103][^104][^105][^106][^107][^108][^109][^110][^111][^112][^68][^69][^70][^71][^72][^73][^74][^75][^76][^77][^78][^79][^80][^81][^82][^83][^84][^85][^86][^87][^88][^89][^90][^91][^92][^93][^94][^95][^96][^97][^98][^99]</span>

<div align="center">⁂</div>

[^1]: https://intux.de/2023/06/10/nextcloud-bei-all-inkl-com-installieren/

[^2]: https://www.andysblog.de/nextcloud-bei-all-inkl-com-installieren

[^3]: https://all-inkl.com/wichtig/anleitungen/kas/ssh/dateiverwaltung/aktivierung-von-ssh-nur-im-hauptaccount-moeglich_395.html

[^4]: https://www.inmotionhosting.com/support/website/antivirus-for-files-nextcloud-clamav/

[^5]: https://www.schroeter-edv.de/?Dokumentation___Cloud_...___NextCloud_-_Installieren_und_stellen_Sie_eine_Antivirus_Loesung_auf_ClamAV_Basis_ein

[^6]: https://help.nextcloud.com/t/nextcloud-mit-subdomain/41591

[^7]: https://www.synology-forum.de/threads/subdomain-fuer-websites-nextcloud-security.102685/

[^8]: https://www.edv2.com/nxt/core/doc/admin/configuration_server/harden_server.html

[^9]: https://all-inkl.com/en/webhosting/ssl-certificates/

[^10]: https://all-inkl.com/en/support/tutorials/kas/ssl-protection/ssl-certificate/how-to-install-a-lets-encrypt-certificate_470.html

[^11]: https://docs.nextcloud.com/server/20/admin_manual/installation/harden_server.html

[^12]: https://all-inkl.com/wichtig/anleitungen/providerwechsel/einrichtung/ssl/einbindung-lets-encrypt-zertifikat_470.html

[^13]: https://help.nextcloud.com/t/help-me-to-enable-hsts-http-strict-transport-security-on-my-nc22-instance-please/121552

[^14]: https://info.eisenach.schule/knowledge-base/nextcloud-und-all-inkl-com/

[^15]: https://infrastructure.punkt.de/de/faq-list/was-bedeutet-die-warnung-the-strict-transport-security-http-header-is-not-configured-to-at-least-15552000-seconds-in-den-server-settings.html

[^16]: https://gefunden-auf.de/all-inkl-php-memory-limit-erhoehen/

[^17]: https://wiki.leralf.de/wiki/nextcloud-all-inkl.com-php-memory-limit-512mb/

[^18]: https://digitalfahrschule.de/wordpress-php-memory-limit-erhoehen/

[^19]: https://docs.nextcloud.com/server/19/admin_manual/configuration_server/config_sample_php_parameters.html?highlight=theme

[^20]: https://www.vpsbg.eu/docs/what-are-nextcloud-trusted-domains-how-to-add-add-them

[^21]: https://help.nextcloud.com/t/howto-add-a-new-trusted-domain/26

[^22]: https://en.nextberry.de/2024/08/17/nextcloud-and-internet-security-tips-and-best-practices/

[^23]: https://nws.netways.de/blog/2025/02/17/nextcloud-zwei-faktor-authentifizierung/

[^24]: https://www.hosting.de/helpdesk/produkte/nextcloud/nextcloud-2fa/

[^25]: https://nextberry.de/nextcloud-und-cloud-sicherheit-best-practices/

[^26]: https://knowledgebase.hkn.de/nextcloud-mit-2fa/

[^27]: https://docs.nextcloud.com/server/latest/user_manual/de/files/access_webdav.html

[^28]: https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html

[^29]: https://nextberry.de/ratelimiting/

[^30]: https://docs.nextcloud.com/server/stable/admin_manual/configuration_server/bruteforce_configuration.html

[^31]: https://docs.nextcloud.com/server/stable/admin_manual/configuration_server/config_sample_php_parameters.html

[^32]: https://docs.nextcloud.com/server/28/admin_manual/configuration_server/config_sample_php_parameters.html

[^33]: https://www.reddit.com/r/NextCloud/comments/1dguas2/is_fail2ban_redundantunnecessary_when_using/

[^34]: https://www.my-it-brain.de/wordpress/nextcloud-im-container-teil-3-mit-reverse-proxy/

[^35]: https://nextberry.de/maximiere-deine-datensicherheit-mit-nextcloud-cert-anleitung-zur-nutzung-von-nextcloud-fuer-effizienz-und-schutz/

[^36]: https://www.linuxfabrik.ch/de/blog/nextcloud-server-side-und-end-to-end-encryption

[^37]: https://www.kuketz-blog.de/verschluesselung-der-nextcloud-eine-grundlegende-entscheidung-nextcloud-teil-2/

[^38]: https://docs.nextcloud.com/server/stable/admin_manual/configuration_files/encryption_configuration.html

[^39]: https://docs.nextcloud.com/server/25/user_manual/de/files/encrypting_files.html

[^40]: https://nextberry.de/nextcloud-verschluesselung-einfach-erklaert-mehr-sicherheit-fuer-ihre-cloud-daten/

[^41]: https://nextberry.de/nextcloud-und-session-timeouts/

[^42]: https://community.nethserver.org/t/nextcloud-and-timeout-session/21586

[^43]: https://docs.nextcloud.com/server/19/admin_manual/configuration_server/config_sample_php_parameters.html?highlight=lifetime

[^44]: https://nextberry.de/komplette-anleitung-zur-dateizugriffskontrolle-in-nextcloud/

[^45]: https://nextberry.de/nextcloud-und-die-files-access-control-app-ein-umfassender-leitfaden/

[^46]: https://portal.nextcloud.com/article/Security/Files-Access-Control

[^47]: https://nextcloud.com/de/compliance/

[^48]: https://www.hosting.de/blog/deine-private-europa-cloud/

[^49]: https://nextberry.de/nextcloud-und-datenschutz-ein-blick-auf-die-dsgvo-konformitaet/

[^50]: https://help.nextcloud.com/t/what-s-the-cleanest-backup-strategy-for-nextcloud-just-files-and-db-or-should-i-include-config-files-too/233939

[^51]: https://portal.nextcloud.com/article/Operations/Backup-Strategies

[^52]: https://mangolassi.it/topic/17168/best-backup-strategy-for-nextcloud

[^53]: https://help.nextcloud.com/t/101-backup-what-and-why-not-how/217496

[^54]: https://decatec.de/home-server/nextcloud-updates-richtig-durchfuehren/

[^55]: https://nextcloud.com/de/secure/

[^56]: https://sysadms.de/2020/08/19/nextcloud-updates-automatisieren/

[^57]: https://www.ionos.de/digitalguide/server/tools/nextcloud-update/

[^58]: https://www.youtube.com/watch?v=qmD1iXTQw_s

[^59]: https://help.nextcloud.com/t/hsts-header-not-detected-by-nextcloud/209797

[^60]: https://help.nextcloud.com/t/how-can-i-handle-htaccess-security-warning/2624

[^61]: https://docs.nextcloud.com/server/32/admin_manual/installation/harden_server.html

[^62]: https://nextcloud.com/secure/

[^63]: https://nextberry.de/sicherhosting/

[^64]: https://nextberry.de/nextcloud-php-einstellungen-optimierung-ihrer-cloud-umgebung/

[^65]: https://www.ionos.de/digitalguide/server/konfiguration/nextcloud-external-storage/

[^66]: https://markus-blog.de/index.php/2018/02/09/nextcloud-und-antivirus-mit-clamav/

[^67]: https://doc.owncloud.com/server/next/admin_manual/configuration/server/occ_command.html

[^68]: https://help.nextcloud.com/t/sicherheitswarnungen-all-inkl-com/148370

[^69]: https://www.youtube.com/watch?v=WWGPhTFJl5E

[^70]: https://www.youtube.com/watch?v=h5l2y00yeOY

[^71]: https://protostern.de/nextcloud-all-inkl-hosten/

[^72]: https://help.nextcloud.com/t/how-to-setup-subdomain-to-nextcloud-at-home-step-by-step/51057

[^73]: https://help.nextcloud.com/t/nextcloud-auf-all-inkl-server/26017

[^74]: https://www.c-rieger.de/nextcloud-installationsanleitung/

[^75]: https://wiggert.net/nextcloud-onlyoffice-bei-all-inkl-de/

[^76]: https://help.dogado.de/hc/de/articles/18706049690129-So-installieren-Sie-Nextcloud-auf-Ihrem-Webspace

[^77]: https://all-inkl.com/webhosting/software-installer/

[^78]: https://forums.unraid.net/topic/121676-nextcloud-mit-ssl-über-all-inklcom/

[^79]: https://www.cloudcomputing-insider.de/anleitung-nextcloud-all-in-one-einrichtung-tipps-a-2d39c18db8e62ce1cea34de4cb046ed9/

[^80]: https://www.gutefrage.net/frage/subdomain-und-weiterleitung-auf-nextcloud-klappt-nicht-so-ganz

[^81]: https://webgo.de/faq/tipps-um-nextcloud-zu-sichern-version-14

[^82]: https://nextcloud.com/de/blog/how-to-install-the-nextcloud-all-in-one-on-linux/

[^83]: https://help.nextcloud.com/t/is-the-default-configuration-of-nextcloud-secure-enough/123129

[^84]: https://www.reddit.com/r/selfhosted/comments/p74vqe/best_way_to_secure_my_nextcloud_server/

[^85]: https://www.youtube.com/watch?v=0-hxlvR6f9g

[^86]: https://github.com/nextcloud-snap/nextcloud-snap/wiki/Configure-config.php

[^87]: https://www.mariusmüller.de/php-version-und-memory_limit-fuer-ssh-bei-all-inkl-einstellen/

[^88]: https://docs.nextcloud.com/server/19/benutzerhandbuch/user_2fa.html

[^89]: https://github.com/nextcloud/helm/issues/41

[^90]: https://help.nextcloud.com/t/need-to-know-how-to-setup-nextcloud-to-use-ssl/121144

[^91]: https://help.nextcloud.com/t/trusted-domain-konfigurieren/10195

[^92]: https://www.youtube.com/watch?v=_FlH9jWoxyo

[^93]: https://www.synology-forum.de/threads/benutzerrechte-fuer-nextcloud-lassen-sich-nicht-setzen.81447/page-2

[^94]: https://docs.nextcloud.com/server/stable/admin_manual/occ_command.html

[^95]: https://help.nextcloud.com/t/frage-zu-verzeichnis-und-datei-berechtigungen/154921

[^96]: https://docs.nextcloud.com/server/28/admin_manual/configuration_server/occ_command.html

[^97]: https://help.nextcloud.com/t/warning-about-hsts-but-headers-are-set/220646

[^98]: https://frank-hilft.de/knowledge-base/zugriffsrechte-nextcloud-anpassen/

[^99]: https://help.nextcloud.com/t/nextcloud-umzug-berechtigungsproblem/171872

[^100]: https://help.nextcloud.com/t/get-security-setup-warnings-with-command-line/45486

[^101]: https://docs.nextcloud.com/server/latest/user_manual/de/desktop/autoupdate.html

[^102]: https://all-inkl.com/wichtig/anleitungen/kas/ssh/dateiverwaltung/verbindung-mit-putty-aufbauen-public-key-verfahren_430.html

[^103]: https://www.rrz.uni-hamburg.de/services/kollaboration/uhhcloud/nextcloud-anleitungen/nextcloud-webdav.html

[^104]: https://all-inkl.com/wichtig/anleitungen/kas/ssh/dateiverwaltung/verbindung-mit-terminal-auf-mac-aufbauen-public-key-verfahren_432.html

[^105]: https://docs.nextcloud.com/server/20/user_manual/de/files/access_webdav.html

[^106]: https://all-inkl.com/wichtig/anleitungen/kas/ssh/dateiverwaltung/verbindung-mit-putty-aufbauen-passwort-verfahren_242.html

[^107]: https://nextberry.de/session-timeout-probleme-2/

[^108]: https://www.synology-forum.de/threads/zugriff-ueber-nextcloud-auf-externe-speicher-funktioniert-nicht.109150/

[^109]: https://nextcloud.com/de/funktionen/

[^110]: https://hilfe.udmedia.de/tipps-tricks/warnungen-fehler-bei-nextcloud-installation/

[^111]: https://help.univention.com/t/sicherheits-einrichtungswarnungen-nextcloud/20803

[^112]: https://lehrerfortbildung-bw.de/st_digital/nextcloud/fb1/3_datenschutz/

