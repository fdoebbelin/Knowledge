## 1. Projektziele & Zielgruppe

1. Was ist das Hauptziel des MetaRow Players aus Ihrer Sicht?
	- Bereitstellung einer interaktiven Lernumgebung
	- Barrierefreies Python-Lernen
	- Interaktive Wissensvermittlung
	- Gamifizierte Lernerfahrung
2. Wer sind die konkreten Endnutzer? (z. B. Schüler:innen, Lehrkräfte)
	- Programmier-Anfänger, 
	- Studenten, 
	- Autodidakten und 
	- Bildungseinrichtungen, die eine unkomplizierte Python-Lernplattform benötigen.
3. Soll das Tool auch in Prüfungen oder Unterrichtssimulationen einsetzbar sein (z. B. ohne Internet)?
	- Ja, sehr gute Idee!!
4. Was ist aus Ihrer Sicht das absolute Minimalziel (MVP)?
	- Desktop-Version mit vollständiger Python-Unterstützung
	- Basic Code-Editor und Execution
	- Markdown-Rendering mit Code-Blöcken

## 2. Inhalt & Struktur der Lernmodule

5. Wie sind die Lerninhalte aufgebaut? (z. B. feste Verzeichnisstruktur?)
	- in einem NOSQL-Datenbankcontainer werden verlinkte MD-Dokumente gespeichert
6. Welche Typen von ausführbaren Inhalten sollen zulässig sein? (z. B. `.py`, `.sh`, `.html`, `.exe`, `.app`)
	- keine, die Interaktivität kommt nur über die Ausführung von Code-Zellen in Markdown-Dokumenten
7. Dürfen HTML-Inhalte im Tool gerendert werden?
	- nur in Markdown eingebettete Inhalte
8. Sollen externe Dateien (z. B. PDFs, Bilder) eingebettet oder nur verlinkt werden?
	- ja, aber nur zu im Datenbankcontainer vorhandenen Ressourcen

## 3. Technische Anforderungen

9. Welche Betriebssysteme müssen zwingend unterstützt werden?
	- alle Plattformen die Tauri unterstützt (macos. Linux, Windows, iOS, Android)
10. Gibt es eine bevorzugte Technologie (z. B. Electron, Tauri)?
	- Das Projekt soll die Programmiersprache Rust nutzen und das darauf aufbauende Framework Tauri.
	- Die in Tauri genutzte Frontendtechnologie ist noch offen (React oder Svelte oder Rust)
11. Soll der Player portabel sein (ohne Installation nutzbar)?
	- ja, ein wichtiger Punkt warum Rust mit Tauri eingesetzt werden soll, eine Binärdatei, die direkt ausführbar ist, keine zusätzlichen Bibliotheken
12. Muss der Player auf Schulgeräten ohne Adminrechte funktionieren?
	- ja

## 4. Sicherheit & Ausführung

13. Welche Sicherheitsmaßnahmen erwarten Sie beim Start von eingebetteten Skripten?
	- es läuft alles in einer Sandbox
14. Sollen Ausgaben (z. B. Konsolentexte) im Player sichtbar sein?
	- alle Ausgaben sind unter den Code-Zellen sichtbar und werden im Dokument gespeichert
15. Wie soll mit Fehlern umgegangen werden (z. B. fehlende Runtime)?
	- der Player selbst wird ein konfigurierbares Logging besitzen

## 5. Web-Fernsteuerung

16. Wie genau soll die Websteuerung aussehen? (z. B. Navigation, Modulstart, Anzeige)
	- der Player wird mit einer Moduldatei gestartet, alles was in einer Weboberfläche darstellbar ist wird als Funktion
17. Soll der Zugriff auf die Weboberfläche beschränkt sein (z. B. durch PIN)?
	- auf keinen Fall, hier läuft die komplette Kommunikation ab
18. Ist es in Ordnung, wenn der Webzugriff nur im lokalen Netzwerk funktioniert?
	- im Grunde läuft alles komplett lokal ab, der Player nutzt nur eine WebView zur Darstellung
19. Welche Geräte sollen die Websteuerung nutzen können? (Smartphone, Tablet, PC)
	- was bedeutet in diesem Kontext Websteuerung, alle Plattformen sollen die gleiche Bedienung haben, nur die Darstellung wird angepasst (responsive design)

## 6. Zukunft & Erweiterung

20. Gibt es langfristige Erweiterungswünsche (z. B. Plugin-System)?
	- über die Möglichkeit WASM-Module einzubinden soll es möglich sein neue Funktionen bereitzustellen
21. Soll der Player auch Import-/Exportfunktionen für Lerneinheiten erhalten?
	- nein, das gesamte Ökosystem wird aber weitere Produkte, den MetaRow Builder und den MetaRow Designer bereitstellen
22. Ist eine OpenSource-Veröffentlichung geplant? Unter welcher Lizenz?
	- ja alles wird unter einer OpenSource-Lizenz angeboten
	- die verpflichtet eigene Erweiterungen auch der Community zur Verfügung zu stellen
	- ich denke GNU General Public License v3 passt am Besten

## 7. Zeitplan & Abnahme

23. Bis wann soll eine erste testbare Version (Prototyp) bereitstehen?
	- mein Ziel ist es innerhalb des laufenden Python-Kurses bis Ende September erste Tests mit der Code-Ausführung in einem Markdown-Dokument realiseren zu können
24. Welche konkreten Funktionen müssen zur Abnahme vorhanden sein?
	- Markdown-Rendering
	- Python-Code-Ausführung
	- laden und Speichern in einer Markdowndatei
25. Wer testet das Produkt auf Auftraggeberseite?
	- Teilnehmer eines Python-Kurses

## 8. Benutzerführung & Kommunikation

26. Bevorzugen Sie eher einfache Oberflächen oder viele Einstellmöglichkeiten?
27. Wie häufig sollen Statusberichte oder Zwischenversionen übergeben werden?

## 9. Technische Detailfragen

28. Darf der Player Schreibrechte im Projektverzeichnis nutzen?
	- in der ersten Version ja
	- wenn der Datenbankcontainer angekoppelt ist in diesen
29. Wird eine Konfigurationsdatei für Benutzereinstellungen gewünscht?
	- erst wenn der Datenbankcontainer aktiv ist
30. Soll es Auto-Updates oder Updatehinweise geben?
	- ja über die Schnittstelle des jeweiligen App-Stores
	- das Tauri-Framework
31. Sollen mehrere Projekte gleichzeitig geöffnet werden können?
	- nein
32. Ist eine Druckfunktion (z. B. Markdown als PDF) erwünscht?
	- nein

## 10. Datenschutz & Sicherheit

33. Müssen personenbezogene Daten vermieden oder besonders geschützt werden?
	- völlig anonym
34. Darf der Player Umgebungsdaten des Systems auslesen (z. B. Benutzername)?
	- da sehe ich keinen Grund für
35. Sollen Logs anonymisiert oder lokal mit Zeitstempel gespeichert werden?
	- Logs sollen nur im DEBUG-Moduls gespeichert werden und der Benutzer kann alle Einstellungen verwalten und sieht vor dem Versenden das Dokument

## 11. Pädagogik & Inhaltsstruktur

36. Gibt es empfohlene Namenskonventionen für Projekte und Dateien?
	- entsprechend den Rust-Konvetionen
	- Repositories: 
		├── metarow-player/ # Rust: metarow_player 
		├── metarow-builder/ # Rust: metarow_builder 
		├── metarow-designer/ # Rust: metarow_designer 
		└── metarow-schema/ # Rust: metarow_schema
37. Sollen bearbeitete Lösungen separat gespeichert werden?
	- im MetaRow-Schema wird eine Versionierung implementiert
38. Gibt es eine Trennung zwischen Aufgabenstellung und Lösung?
	- auf jeden Fall
39. Sollen interaktive Elemente wie Prüfblöcke oder Quiz in Markdown erlaubt sein?
	- H5P-Inhalt sollen über einen WASM-Modul abspielbar sein und mit dem MetaRow-Builder editierbar sein

## 12. Verteilung & Bereitstellung

40. Wie werden die Lerninhalte verteilt (z. B. ZIP, USB, manuell)?
	- ausschließlich über MetaRow-Dateien
41. Muss der Player auf Geräten ohne Installationsrechte laufen?
	- ja
42. Wird eine portable Version für USB oder Live-CD/DVD benötigt?
	- es gibt keine portable Version, der Player ist selbst portabel

## 13. Web-Technik & Interoperabilität

43. Soll die Websteuerung über HTTPS möglich sein?
	- der Player ist eine Desktop- oder Mobil-App
44. Gibt es Anforderungen an Barrierefreiheit?
	- Visuelle Barrierefreiheit
	- Mobile Accessibility
	- Audio/Motion Preferences
45. Sollen Web- und Desktop-Ansicht synchronisiert werden?
	- der Player ist eine selbstständige App

## 14. Externe Tools & Kompatibilität

46. Sollen externe Tools über den Player gestartet werden dürfen?
	- nein, ich wüsste auch was welche
47. Sollen Inhalte mit Systemen wie Moodle oder Nextcloud kompatibel sein?
	- nein, siehe 45.
48. Gibt es ein festes Austauschformat für Lernpakete (z. B. `.zip`, `.tar.gz`)?
	- das MetaRow-Schema wird als eigenständiges Projekt die Struktur der MetaRow-Dateien festlegen und als einziges Format zugelassen

## 15. Testbarkeit & Qualität

49. Gibt es definierte Testszenarien oder müssen diese erstellt werden?
	- nein
50. Sollen Benutzerfeedback und Fehlerberichte gesammelt werden können?
	- wäre sinnvoll

## 16. Priorisierung

51. Gibt es eine klare Feature-Priorisierung (Must-Have / Nice-to-Have)?
	- eigentlich nicht
	- alles was der komfortablen Bereitstellung und Nutzung der Lernmodule dient sollte langfristig implementiert werden, Basis ist das MVP
	- da soll das Projekt offen für die Vorschläge der Community sein
