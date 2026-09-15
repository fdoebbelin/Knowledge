---
title: Paragraphs-Modul als Book-Alternative
aliases:
  - Drupal Paragraphs Module for Structured Content
  - Erstellung strukturierter Inhalte mit dem Paragraphs-Modul in Drupal
  - Paragraphs-Modul
tags:
  - drupal
  - paragraphs
  - cms
created: 2025-04-14
updated: 2026-09-15
sources:
  - Claude-Chat (2025-04-14)
  - Recherchebericht "Erstellung strukturierter Inhalte mit dem Paragraphs-Modul" (2025-04-14)
  - Schritt-für-Schritt-Anleitung "Paragraphs-Modul" (2025-04-15)
  - "[[Strukturierte Artikel mit dem Paragraphs Modul für Drupal 8]]" (Novatrend-Blog, 2016)
---

# Paragraphs-Modul als Book-Alternative

> [!abstract] Ziel
> Mit dem Paragraphs-Modul in Drupal 10/11 einen hierarchischen, mehrseitigen Inhalt („Buch“ mit Kapiteln und Unterabschnitten) aufbauen, wie er bis Drupal 10 mit dem Core-Modul **Book** möglich war. Diese Notiz fasst drei frühere Fassungen (Claude-Chat, Recherchebericht, Schritt-für-Schritt-Anleitung) zusammen.

## 1 · Hintergrund

Das Book-Modul organisierte Nodes in einer Buchgliederung, erzeugte automatisch Navigationslinks (vorherige, nächste, übergeordnete Seite) und einen Block „Buchnavigation“. Es ist starr im Aufbau und schwer zu gestalten; in neueren Drupal-Versionen ist es aus dem Core entfernt. Paragraphs zerlegt Inhalte in wiederverwendbare, feldbasierte Komponenten (Paragraph-Typen) und bildet die Hierarchie über verschachtelte Paragraph-Felder ab. Navigation und Inhaltsverzeichnis müssen dafür nachgebaut werden.

## 2 · Voraussetzungen und Installation

- Drupal 10 oder 11, Composer, vorher ein Backup.
- Paragraphs hängt von **Entity Reference Revisions** ab.

```bash
composer require drupal/paragraphs drupal/entity_reference_revisions
drush en paragraphs entity_reference_revisions -y
# optional: Pathauto für automatische URL-Aliase
composer require drupal/pathauto
```

Alternativ unter **Erweiterungen** (`/admin/modules`) aktivieren. Nützliche Submodule: **Paragraphs Library** (wiederverwendbare Paragraphs) und **Paragraphs Type Permissions** (Rollenrechte je Paragraph-Typ).

## 3 · Datenmodell: Paragraph-Typen und Inhaltstyp

Zwei Modellierungen sind gängig. Für den Einstieg reicht die einfache.

### 3.1 Einfaches Modell (zwei Ebenen)

Unter **Struktur → Paragraph-Typen → Hinzufügen** (`/admin/structure/paragraphs_type/add`):

| Paragraph-Typ | Felder |
|---|---|
| **Kapitel** | Kapiteltitel (Text, einzeilig) · Inhalt (Text, formatiert, lang) · Unterabschnitte (Paragraph-Feld → „Unterabschnitt“, unbegrenzt) · optional Bild, Zusammenfassung |
| **Unterabschnitt** | Titel (Text, einzeilig) · Inhalt (Text, formatiert, lang) |

### 3.2 Rekursives Modell (beliebig tief)

Ein einziger Paragraph-Typ **Buch-Kapitel** mit den Feldern Titel, Inhalt und **Unterkapitel** (Paragraph-Feld, das auf **denselben** Typ „Buch-Kapitel“ verweist, unbegrenzt). Damit lassen sich beliebig tiefe Hierarchien abbilden. Der Recherchebericht schlägt alternativ vier Typen vor (Buch → Kapitel → Unterkapitel → Seite); das lohnt sich nur, wenn die Ebenen unterschiedliche Felder brauchen.

### 3.3 Inhaltstyp „Buch“

1. **Struktur → Inhaltstypen → Inhaltstyp hinzufügen**, Name „Buch“, optional Beschreibung (Text, formatiert), Autor, Titelbild.
2. Feld **Buchinhalt** hinzufügen: Typ **Paragraph** (unter „Referenz-Revisionen“), erlaubte Typen „Kapitel“ bzw. „Buch-Kapitel“, **Anzahl der Werte: unbegrenzt**.
3. Unter **Formular-Anzeige verwalten** für „Buchinhalt“ das Widget **Paragraphs (EXPERIMENTAL)** wählen. Nur damit gibt es Drag-and-Drop für die Reihenfolge.
4. Unter **Anzeige verwalten** das Feld auf **Gerenderte Entität** stellen, sonst werden die Paragraphs nicht ausgegeben.

Beim Hinzufügen der Felder darauf achten, dass die Feldbezeichnungen sprechend sind („Kapiteltitel“ statt „Titel“), damit Redakteure die Verschachtelung im Formular erkennen.

## 4 · Praxisbeispiel: Handbuch „Einführung in Drupal“

1. **Inhalt → Inhalt hinzufügen → Buch**, Titel „Einführung in Drupal“.
2. Im Feld „Buchinhalt“ → **Paragraph hinzufügen → Kapitel**:
   - „1. Installation von Drupal“ mit Inhalt, keine Unterabschnitte.
3. Weiteres Kapitel „2. Grundlegende Konfiguration“, darin im Feld „Unterabschnitte“ zwei Paragraphs:
   - „2.1 Benutzer und Berechtigungen“
   - „2.2 Module installieren“
4. Reihenfolge per Drag-and-Drop ordnen, speichern.

Für die Bearbeitung verschachtelter Inhalte hilft es, in **Anzeige verwalten** des Paragraph-Typs das Format eines Feldes auf **Zusammenfassung** zu setzen. Dann zeigt das eingeklappte Paragraph im Formular den Kapiteltitel an.

## 5 · Reihenfolge und Darstellung

- **Reihenfolge:** Drag-and-Drop im experimentellen Widget oder über **Zeilengewichte anzeigen** (kleineres Gewicht = weiter oben). Die Reihenfolge im Feld „Buchinhalt“ bestimmt die Kapitelfolge, analog in den Unterabschnitten.
- **Anzeige:** Unter **Struktur → Anzeige-Modi** bzw. „Anzeige verwalten“ von Inhaltstyp und Paragraph-Typen Überschriftenformate und Abstände so einstellen, dass Kapitel und Unterabschnitte optisch unterscheidbar sind. Für mobile Darstellung ggf. eigene CSS-Klassen über die Anzeigeeinstellungen vergeben.
- **Layout Builder** kann ergänzend die Anordnung der Buchinhalte auf einer Seite steuern.

## 6 · Navigation und Inhaltsverzeichnis nachbauen

Paragraphs bringt keine Buchnavigation mit. Drei Wege:

| Weg | Aufwand | Ergebnis |
|---|---|---|
| **Views** | mittel | Ansicht auf Inhaltstyp „Buch“ mit Beziehungen zu den Kapitel-/Unterabschnitt-Paragraphs; als Block (z. B. linke Spalte) oder Seite einbinden. Erzeugt ein dynamisches Inhaltsverzeichnis. |
| **Modul `ptoc`** (Paragraphs Table of Contents) | gering | Block mit Inhaltsverzeichnis, das per Anker auf jeden Paragraph der Seite verlinkt. |
| **Eigener Paragraph-Typ „Navigation“** | gering, manuell | Redakteure pflegen Link- oder Entity-Reference-Felder von Hand. |

Vor/Zurück-Links zwischen Kapiteln (wie im Book-Modul) erfordern ein eigenes Template für den Paragraph-Typ oder ein kleines Custom-Modul. **Menu Block** eignet sich, wenn jede Seite eine eigene URL bekommt, was ein anderes Inhaltsmodell (Nodes statt Paragraphs je Seite) voraussetzt.

## 7 · Bewährte Praktiken

- **Struktur vorher planen:** Wie viele Ebenen werden gebraucht? Skizze anfertigen, dann Typen anlegen.
- **Wenige Paragraph-Typen:** Mit dem Minimum starten; zu viele Typen überfordern Redakteure.
- **Konsistente Benennung** von Typen und Feldern.
- **Zusammenfassungen** in den Paragraph-Typen konfigurieren (siehe Abschnitt 4).
- **Paragraphs Library** für wiederkehrende Elemente (Standardhinweise, Glossareinträge, Fußnoten).
- **Conditional Fields**, um Felder nur bei Bedarf einzublenden (z. B. „Autor anzeigen“).
- **Migration** aus einem bestehenden Book: zuerst die Hierarchie exportieren, dann in die neue Struktur überführen.

## 8 · Vergleich Book-Modul vs. Paragraphs

| Funktion | Book-Modul | Paragraphs |
|---|---|---|
| Hierarchie | eingebaut (Buchgliederung) | über verschachtelte Paragraph-Felder, Drag-and-Drop |
| Navigation (vor/zurück/oben) | automatisch | über Views, `ptoc` oder eigene Lösung |
| Inhaltsverzeichnis | Block „Buchnavigation“ | Views oder `ptoc`, frei gestaltbar |
| Reihenfolge | Position in der Gliederung | Drag-and-Drop oder Gewicht |
| Inhaltsarten je Seite | ein Inhaltstyp | beliebige Paragraph-Typen mit eigenen Feldern |
| Design | begrenzt, Theme-Anpassung nötig | jeder Paragraph-Typ einzeln gestaltbar |
| Wiederverwendung | ganze Seiten | einzelne Blöcke über Paragraphs Library |
| Berechtigungen | auf Buch-Ebene | je Paragraph-Typ (Type Permissions) |
| Mehrsprachigkeit | Core-Übersetzung | Core-Übersetzung für Node und Paragraphs |
| Zukunft | aus dem Core entfernt | aktiv gepflegt, Drupal 11 |

**Fazit:** Book ist die Out-of-the-box-Lösung für einfache Hierarchien mit automatischer Navigation. Paragraphs kostet mehr Konfiguration, bietet aber deutlich mehr Flexibilität bei Struktur, Inhaltsarten und Design und ist zukunftssicher.

## Siehe auch

- [[Strukturierte Artikel mit dem Paragraphs Modul für Drupal 8]] (Blog-Clipping mit Text- und Bild-Paragraph-Typen)
- [[01 Erstellen einer Buchstruktur]]
- [[Install Drupal CMS locally with DDEV]]
