Im Folgenden folgt eine ausführliche Anleitung, wie man mit dem Paragraphs-Modul in Drupal einen strukturierten Inhalt erstellt – also eine Art „Buch“ oder mehrseitigen Inhalt, wie er früher mit dem im Core enthaltenen Book-Modul (bis Drupal 10) realisiert wurde. In diesem Beispiel wird gezeigt, wie man einen neuen Inhaltstyp „Buch“ anlegt, der Kapitel und Unterabschnitte über Paragraphen enthält, und wie so eine hierarchische Struktur aufgebaut wird.

---

## 1. Vorbereitungen und Installation

### 1.1. Voraussetzungen

- **Drupal-Installation (idealerweise Drupal 9 oder 10):** Stelle sicher, dass du eine funktionierende Drupal-Installation hast.
- **Composer:** Die Installation von Modulen erfolgt idealerweise über Composer.
- **Sicherung:** Vor größeren Änderungen empfiehlt es sich, ein Backup der Seite zu erstellen.

### 1.2. Installation des Paragraphs-Moduls

1. **Über Composer installieren:**  
    Öffne das Terminal und führe folgendes aus:
    
```bash
composer require drupal/paragraphs
```
    
2. **Aktivierung im Admin-Interface:**  
    Wechsle zum Menü **„Erweiterungen“** oder benutze Drush:
    
```bash
drush en paragraphs -y
```
    
Damit wird das Modul aktiviert und steht in deiner Seite zur Verfügung.
    

---

## 2. Anlegen der benötigten Content- und Paragraph-Typen

### 2.1. Erstellen eines neuen Inhaltstyps „Buch“

1. Navigiere zu **Struktur > Inhaltstypen** und klicke auf **„Inhaltstyp hinzufügen“**.
    
2. Gib deinem neuen Inhaltstyp einen Titel, beispielsweise **„Buch“**.
    
3. Im nächsten Schritt kannst du optionale Felder für den Inhaltstyp definieren (z. B. Autor, Veröffentlichungsdatum). Für dieses Beispiel konzentrieren wir uns auf den strukturierten Inhaltsbereich.
    

### 2.2. Anlegen eines neuen Feldes (Paragraph-Feld) für den Inhaltstyp

1. Öffne den Bearbeitungsdialog des Inhaltstyps „Buch“ (über **Struktur > Inhaltstypen > Buch bearbeiten**).
    
2. Füge ein neues Feld hinzu: Wähle als Feldtyp **„Paragraph“** (dies ist ein Entity Reference Feld) und nenne es beispielsweise **„Buchinhalt“**.
    
3. Im Einstellungsdialog kannst du festlegen, welche Paragraph-Typen verwendet werden können (Später definieren wir mindestens zwei Typen – etwa Kapitel und Abschnitt). Lege die Mehrfachwertigkeit fest (z. B. „Mehrere Werte zulassen“), da du mehrere Kapitel hinzufügen möchtest.
    
4. Konfiguriere die Feldanzeige, damit später die Reihenfolge der Paragraphen angepasst werden kann (Drag-and-Drop).
    

### 2.3. Erstellen der Paragraph-Typen

#### a) Paragraph-Typ „Kapitel“

1. Navigiere zu **Struktur > Paragraph-Typen** und klicke auf **„Paragraph-Typ hinzufügen“**.
2. Gib dem Typ den Namen **„Kapitel“**.
3. **Felder hinzufügen:**
    - **Titel:** Füge ein Feld vom Typ **Text (einzeilig)** hinzu, um den Kapiteltitel zu erfassen.
    - **Inhalt:** Füge ein **Textbereich**-Feld (Long Text mit Formatierung) hinzu, in dem der Inhalt des Kapitels geschrieben werden kann.
4. Optional kannst du noch weitere Felder hinzufügen (z. B. ein Bildfeld für Kapitelillustrationen oder eine Zusammenfassung).

#### b) Paragraph-Typ „Unterabschnitt“ (optional)

Um eine Hierarchie zu ermöglichen, können innerhalb eines Kapitels weitere Abschnitte erzeugt werden.

1. Erstelle einen weiteren Paragraph-Typ namens **„Unterabschnitt“**.
    
2. **Felder hinzufügen:**
    
    - **Titel:** Füge erneut ein **Text (einzeilig)**-Feld hinzu.
        
    - **Inhalt:** Füge ein **Long Text**-Feld ein.
        
3. Optional lässt sich auch hier ein weiteres Feld hinzufügen (z. B. eine Kurzbeschreibung).
    

#### c) Verschachtelung der Paragraphs (innerhalb von Kapitel)

Um die hierarchische Beziehung (Kapitel -> Unterabschnitt) abzubilden, kannst du im Paragraph-Typ „Kapitel“ ein weiteres Feld vom Typ **Paragraph (Entity Reference)** hinzufügen:
1. Bearbeite den Paragraph-Typ „Kapitel“ und füge ein neues Feld hinzu, z. B. **„Unterabschnitte“**.
2. Wähle als erlaubte Paragraph-Typen **„Unterabschnitt“** aus.
3. Ermögliche Mehrfachwerte, sodass innerhalb eines Kapitels mehrere Unterabschnitte hinzugefügt werden können.

---

## 3. Inhaltserstellung: Ein konkretes Beispiel

### 3.1. Erstellung einer neuen Buchseite

1. Gehe zu **Inhalt > Inhalt hinzufügen** und wähle den Inhaltstyp **„Buch“**.
2. Vergib einen Titel für dein Buch, z. B. **„Mein Beispielbuch“**.

### 3.2. Befüllen des „Buchinhalt“-Feldes mit Kapiteln und Unterabschnitten

1. Im Bearbeitungsformular findest du nun das **„Buchinhalt“**-Feld.  
    Hier kannst du **„Paragraph hinzufügen“** anklicken und zunächst einen **„Kapitel“-Paragraph** auswählen.
2. **Fülle den Kapitel-Paragraph aus:**
    
    - Gib einen Kapitel-Titel ein (z. B. „Einleitung“).
        
    - Schreibe den Hauptinhalt des Kapitels.
        
3. **Hinzufügen von Unterabschnitten im Kapitel:**  
    Falls du im Kapitel einen Unterabschnitt vorgesehen hast, klicke innerhalb des Kapitel-Paragraphs auf **„Paragraph hinzufügen“** (im Feld „Unterabschnitte“) und wähle **„Unterabschnitt“** aus.
    
    - Gib den Titel und den Inhalt des Unterabschnitts ein (z. B. „Hintergrundinformationen“).
        
4. Wiederhole diesen Vorgang, um weitere Kapitel oder zusätzliche Unterabschnitte zu erstellen.
    

### 3.3. Navigation und hierarchischer Überblick

Das frühere Book-Modul im Drupal-Core bot z. B. eine automatische Navigation (Table of Contents) und eine hierarchische Darstellung. Mit Paragraphs erhältst du folgende Möglichkeiten:

- **Manuelle Reihenfolge:** Durch Drag-and-Drop lassen sich Kapitel und Unterabschnitte sortieren.
    
- **Erstellen einer Übersichtsseite:** Mithilfe des Views-Moduls (oder benutzerdefinierten Block) lässt sich eine Liste oder ein dynamisches Inhaltsverzeichnis generieren, das alle Kapitel (und ggf. Unterabschnitte) anzeigt.
    
- **Individuelle Layouts:** Durch angepasste View-Modi oder ein eigenes Theme kannst du eine Navigation darstellen, die beispielsweise links als Inhaltsverzeichnis erscheint.
    

---

## 4. Konfiguration der Anzeige (Display Settings)

### 4.1. Anpassung der Formate

- **Anzeige im Full-Content-Modus:**  
    Navigiere zu **Struktur > Anzeige-Modi** für Inhaltstypen und Paragraphen. Passe das Layout an, sodass Kapitel und Unterabschnitte optisch differenziert werden (z. B. Überschriften-Format, Abstände).
    
- **Dynamische Navigation:**  
    Erstelle mithilfe des Views-Moduls (falls noch nicht aktiviert) eine Ansicht, die auf dem Feld „Buchinhalt“ basiert und als Block oder Seite eingebunden wird. So kannst du automatisch ein Inhaltsverzeichnis ähnlich wie beim Book-Modul generieren.
    

### 4.2. Responsive und adaptive Darstellung

- Prüfe, ob in deinem Theme – oder via Custom CSS – die Darstellung der Paragraphen auch auf mobilen Endgeräten optimal erscheint. Hierzu können zusätzliche CSS-Klassen helfen, die du in den Anzeigeeinstellungen definierst.
    

---

## 5. Erweiterungsmöglichkeiten und Hinweise

- **Automatisierte Navigation:**  
    Auch wenn Paragraphs keine eingebauten Funktionen für ein Inhaltsverzeichnis oder eine „Buch“-Navigation wie das alte Book-Modul bietet, lässt sich dies mit einer Kombination aus Views, Custom Blocks und ggf. JavaScript realisieren. So kann ein benutzerdefiniertes Inhaltsverzeichnis erstellt werden, das die Hierarchie widerspiegelt.
    
- **Mehrstufige Inhalte:**  
    Für noch tiefere Hierarchien können weitere verschachtelte Paragraph-Typen erstellt werden. Denke dabei an eine klare Namensgebung und Struktur, um die Verwaltung zu erleichtern.
    
- **Migration von bestehenden Inhalten:**  
    Falls du Inhalte aus einem alten Book-Modul migrieren möchtest, ist es hilfreich, zunächst eine Übersicht der bestehenden Hierarchie zu exportieren und dann das neue Paragraph-basierte System als Zielstruktur zu verwenden.
    

---

## Zusammenfassung

Diese Anleitung zeigt, wie mit dem Paragraphs-Modul ein flexibles, hierarchisch aufgebautes System erstellt wird, das in Funktion und Optik weitgehend an das alte Book-Modul anknüpft. Schrittweise wurde ein eigener Inhaltstyp „Buch“ angelegt, der über ein Paragraph-Feld Kapitel und Unterabschnitte enthält. Durch zusätzliche Konfiguration der Anzeige und mit Hilfe des Views-Moduls lässt sich eine ansprechende Navigation ähnlich einem Inhaltsverzeichnis erstellen.

Mit dieser Methode hast du eine moderne und modulare Alternative zum klassischen Book-Modul – eine Lösung, die sich auch gut an individuelle Anforderungen und komplexere Seitenstrukturen anpassen lässt.