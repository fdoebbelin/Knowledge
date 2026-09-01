## 1. Test-E-Mail Funktion nutzen

ProjeQtOr bietet eine eingebaute Test-Funktion:

**Pfad:** Global Parameters → Tab Mailing → Test email configuration

- Geben Sie eine E-Mail-Adresse im Feld "Send email to" ein
- Klicken Sie auf den Test-Button
- ⚠️ **Wichtig:** Diese Operation speichert automatisch die globalen Parameter

## 2. E-Mail-Konfiguration überprüfen

**Pfad:** Global Parameters → Tab Mailing → Emailing

Überprüfen Sie folgende Einstellungen:

### Administrator E-Mail

- **Administrator's email:** E-Mail-Adresse des Administrators
- **From address:** Absender-Adresse (kann unterschiedlich sein)
- **Reply to address:** Antwort-Adresse
- **Display name:** Anzeigename

### SMTP-Server Konfiguration

- **SMTP server:** Server-Adresse
- **SMTP port:** Port-Nummer
- **Login name:** Benutzername
- **Password:** Passwort
- **Sendmail path:** Pfad (falls verwendet)
- **Send method:** Versandmethode

### Weitere Einstellungen

- **Maximum size:** Maximale Dateigröße für E-Mail-Anhänge (in Bytes, K, M oder G)

## 3. Gesendete E-Mails überwachen

**Pfad:** Tools → Emails sent

Hier können Sie:

- Liste aller automatisch gesendeten E-Mails einsehen
- Status überprüfen (erfolgreich gesendet oder Fehler)
- Fehlermeldungen analysieren

## 4. E-Mail-Warteschlange prüfen

Falls E-Mail-Gruppierung aktiviert ist:

**Pfad:** Tools → Emails to send

- Zeigt geplante E-Mails vor dem automatischen Versand
- Nur verfügbar wenn "Activate email grouping" in Global Parameters aktiviert ist

## 5. CRON-Status überprüfen

E-Mails werden über den CRON-Dienst versendet:

- **CRON-Button** in der Infoleiste überprüfen:
    - 🟢 Grün: CRON läuft
    - 🔴 Rot: CRON gestoppt
- Nur für Administrator-Profile sichtbar

## 6. Häufige Probleme beheben

### Gmail-Beispiel

Für Gmail IMAP-Verbindung:

```
Host: {imap.gmail.com:993/imap/ssl}INBOX
```

### Fehlerbehebung

- Prüfen Sie Firewall-Einstellungen
- Überprüfen Sie SMTP-Authentifizierung
- Kontrollieren Sie Port-Freigaben
- Testen Sie mit verschiedenen E-Mail-Adressen

## 7. Logs überprüfen

**Pfad:** Administration Console → Log files maintenance

- Überprüfen Sie die Log-Dateien auf E-Mail-bezogene Fehler
- Verschiedene Log-Level verfügbar: debug, trace, script, errors

Durch diese systematische Überprüfung können Sie feststellen, ob die E-Mail-Konfiguration korrekt funktioniert und eventuelle Probleme identifizieren.