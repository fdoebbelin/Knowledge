OpenClaw ist ein quelloffener, selbst gehosteter KI-Agent, den du über Chat-Apps wie WhatsApp, Telegram oder Discord steuerst. Seine Besonderheit liegt darin, dass er nicht nur antwortet, sondern auf deinem System Aktionen wie das Ausführen von Skripts oder Dateiverwaltung durchführen kann. Hier sind die wichtigsten Fakten im Überblick:

| Aspekt | Beschreibung |
| :--- | :--- |
| **Entwickler** | Peter Steinberger, Gründer von PSPDFKit. |
| **Status** | Quelloffen und kostenlos, Kosten entstehen nur für verwendete KI-Modelle und Server. |
| **Aufstieg** | Über 60.000 GitHub-Sterne in 72 Stunden; eines der am schnellsten wachsenden Open-Source-Projekte. |
| **Name** | Ursprünglich *ClawdBot*, dann *Moltbot*, jetzt **OpenClaw**. |
| **Besonderheit** | Proaktiver, lokaler Agent mit Langzeitgedächtnis und Ausführungsfähigkeiten auf deinem System. |
| **Hauptkritik** | Erhebliche Sicherheitsbedenken durch erforderliche tiefe Systemzugriffe. |

### 🤔 Was genau ist OpenClaw?
OpenClaw ist eine lokal laufende Software (Mac, Windows, Linux), die eine Brücke zwischen KI-Modellen und deinen Systemwerkzeugen schlägt.
*   **Agent, nicht Chatbot**: Er wartet nicht auf Befehle, sondern läuft als **persistenter Hintergrunddienst** (24/7). Du kannst ihn z.B. bitten, abends automatisch deinen Download-Ordner aufzuräumen.
*   **Konnektor zwischen Chat, KI und System**: Die Architektur verbindet drei Ebenen:
    1.  **Chat-Interface**: Interaktion über WhatsApp, Telegram, Discord usw..
    2.  **KI-Modell**: Nutzt Modelle wie GPT-4, Claude, Gemini oder lokale Modelle.
    3.  **System-Aktionen**: Über **„AgentSkills“** kann er Dateien, Browser, Smart-Home-Geräte, APIs und mehr steuern.

### ⚙️ Technische Umsetzung und Vergleich
OpenClaw kombiniert bestehende Technologien zu einem neuen Konzept und unterscheidet sich von klassischen Automatisierungstools.

*   **So funktioniert es**: Du beschreibst deine Aufgabe in einer Chat-App. OpenClaw interpretiert die Absicht, greift bei Bedarf über Skills auf Tools zu, führt die Aufgabe aus und meldet das Ergebnis zurück.
*   **Unterschied zu n8n**: Beide automatisieren, verfolgen aber grundlegend andere Ansätze:

| Funktion | **OpenClaw** | **n8n** |
| :--- | :--- | :--- |
| **Primäre Steuerung** | Konversation (natürliche Sprache) | Visueller Workflow-Builder |
| **Ausführungslogik** | Autonomer Agent (entscheidet selbst) | Vordefinierte, schrittweise Abläufe |
| **Gedächtnis** | Langzeitkontext über mehrere Chats | Statusfrei (pro Ausführung) |
| **Typischer Anwendungsfall** | Dynamische, unvorhersehbare Aufgaben | Strukturierte, wiederholbare Prozesse |

### 🔧 Installation und Nutzung
Der Einstieg ist technisch, aber gut dokumentiert.

1.  **Setup**: Der einfachste Start ist der Einzeiler im Terminal: `curl -fsSL https://openclaw.ai/install.sh | bash`. Für mehr Sicherheit wird die Installation auf einer separaten Maschine oder einem virtuellen Server (VPS, z.B. ab ca. 5 €/Monat) empfohlen.
2.  **Nutzung**: Nach der Einrichtung interagierst du direkt in deiner Chat-App. Die Community teilt tausende Anwendungsfälle, z.B.:
    *   **Produktivität**: E-Mails sortieren, Kalender verwalten, Aufgaben in Notion/ Obsidian organisieren.
    *   **Entwicklung**: Code-Tests automatisieren, GitHub Issues verwalten, Fehler überwachen.
    *   **Privat**: Smart Home steuern, Gesundheitsdaten von Wearables auswerten, Websuche automatisieren.
    *   **Kreativ**: KI-generierte Bilder erstellen, Social-Media-Beiträge planen.

### ⚠️ Wichtige Sicherheitshinweise
Die große Stärke von OpenClaw – der tiefe Systemzugriff – ist gleichzeitig sein größtes Risiko. Unabhängige Sicherheitstests bewerten ihn als sehr anfällig.

*   **Kritische Schwachstellen**: Tests zeigten eine **Extraktionsrate von 84%** für interne Konfigurationen und eine **Erfolgsrate von 91%** für Prompt-Injection-Angriffe. Das bedeutet, dass Angreifer potenziell Kontrolle über den Agenten erlangen könnten.
*   **Sicherheitsprobleme in der Praxis**: Viele Instanzen sind unsicher im Internet erreichbar, was zu Datenlecks führt. Das Projekt lockte auch Betrüger an, die gefälschte Versionen mit Schadcode verbreiten.
*   **Empfohlene Vorsichtsmaßnahmen**:
    *   Nutze OpenClaw **niemals** auf einem Rechner mit sensiblen Daten.
    *   Starte in einer **abgeschotteten Umgebung** (virtuelle Maschine, isolierter VPS).
    *   Verwende starke **Authentifizierung** für das Web-Interface und halte es aus dem offenen Internet fern.
    *   Arbeite mit **minimalen Berechtigungen** und niemals als Administrator-User.

### 🔄 Der Weg zu „OpenClaw“: Mehrfache Umbenennung
Das Projekt erlebte einen turbulenten Start mit mehreren Namensänderungen, die für Verwirrung und zusätzliche Sicherheitsrisiken sorgten:
1.  **ClawdBot**: Der ursprüngliche Name nach dem Start Ende 2025.
2.  **Moltbot**: Erste Umbenennung nach einer Markenanfrage von Anthropic (Hersteller von Claude AI).
3.  **OpenClaw**: Der aktuelle Name seit Ende Januar 2026.

### 💎 Fazit
OpenClaw ist ein faszinierendes Projekt, das zeigt, wohin die Reise mit persönlichen KI-Agenten gehen kann – als **leistungsstarker, kontextbewusster und proaktiver Helfer**. Es ist aber auch ein **Werkzeug für erfahrene Techniknutzer**. Für Einsteiger, die sich nicht mit Systemadministration und Sicherheitshärtung auskennen, sind die Risiken aktuell zu hoch.

Wenn du tiefer in die technische Architektur einsteigen oder konkrete Use Cases für deinen Arbeitsalltag diskutieren möchtest, kann ich dir gerne weitere Informationen geben.