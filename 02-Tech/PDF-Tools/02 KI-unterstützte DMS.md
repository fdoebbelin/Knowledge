1. **Paperless-ngx**
   - **Beschreibung:** Ein Open-Source-Dokumentenmanagement-System, das eine OCR (Optical Character Recognition) Funktion integriert hat, um Text in gescannten Dokumenten zu erkennen und zu indizieren. Es bietet Funktionen zur automatischen Kategorisierung und Tagging.
   - **Funktionen:**
     - OCR zur Texterkennung
     - Automatische Indizierung und Kategorisierung
     - Web-basierte Benutzeroberfläche
   - **Link:** [Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)

2. **Docspell**
   - **Beschreibung:** Ein weiteres Open-Source-Dokumentenmanagement-System, das KI-gestützte Funktionen für die Dokumentenerkennung und -kategorisierung bietet. Es kann automatisch Inhalte extrahieren und Dokumente basierend auf vordefinierten Regeln organisieren.
   - **Funktionen:**
     - KI-gestützte Dokumentenerkennung
     - Automatisches Tagging und Kategorisierung
     - Web-basierte Benutzeroberfläche
   - **Link:** [Docspell](https://docspell.org/)

3. **Mayan EDMS**
   - **Beschreibung:** Ein leistungsstarkes, Open-Source-Dokumentenmanagement-System, das umfangreiche Funktionen für die Dokumentenverwaltung bietet. Es nutzt OCR und KI zur automatischen Indizierung und Kategorisierung von Dokumenten.
   - **Funktionen:**
     - OCR zur Texterkennung
     - Automatische Indizierung und Kategorisierung
     - Web-basierte Benutzeroberfläche
   - **Link:** [Mayan EDMS](https://www.mayan-edms.com/)

### Nutzung von Paperless-ngx unter Docker

1. **DMS installieren und konfigurieren:**
   - Laden Sie das gewünschte DMS herunter und starten Sie es in Docker. Beispiel für Paperless-ngx:
     ```bash
     docker run -d \
       -v /pfad/zu/daten:/usr/src/paperless/data \
       -v /pfad/zu/medien:/usr/src/paperless/media \
       -e PUID=1000 \
       -e PGID=1000 \
       -p 8000:8000 \
       ghcr.io/paperless-ngx/paperless:latest
     ```
   - Passen Sie die Pfade und Umgebungsvariablen nach Ihren Bedürfnissen an.

5. **Zugriff auf die Web-Oberfläche:**
   - Öffnen Sie Ihren Webbrowser und greifen Sie auf die Weboberfläche des DMS zu (z.B. `http://localhost:8000`).

6. **Dokumente hinzufügen und verwalten:**
   - Fügen Sie Dokumente hinzu und nutzen Sie die KI-gestützten Funktionen zur Indizierung und Kategorisierung.

### Vorteile der Nutzung von KI-unterstützten DMS

- **Automatisierung:** Reduziert manuellen Aufwand durch automatische Erkennung und Kategorisierung von Dokumenten.
- **Effizienz:** Verbesserte Suchfunktionen und schnelle Indizierung ermöglichen einen effizienten Zugriff auf Dokumente.
- **Präzision:** OCR und KI-Technologien erhöhen die Genauigkeit der Dokumentenverarbeitung und -verwaltung.

Diese Lösungen bieten eine leistungsfähige Möglichkeit, Ihre PDF-Dokumente und andere Dateien effektiv zu verwalten und zu organisieren, indem sie die Vorteile von KI und OCR nutzen.