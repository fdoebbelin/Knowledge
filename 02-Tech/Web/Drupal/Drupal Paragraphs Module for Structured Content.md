---
title: "Drupal Paragraphs Module for Structured Content"
source: "https://claude.ai/chat/c398761a-d428-4ce0-8d93-3659d47cbd47"
author:
published:
created: 2025-04-14
description: "Talk with Claude, an AI assistant from Anthropic"
tags:
  - "clippings"
---
für eine Drupal-Übung eine ausführliche Handlungsanweisung an einem konkreten Beispiel erarbeiten, wie mit dem Paragraphen-Modul strukturierter Inhalt erzeugt werden kann, der funktional dem entspricht, was bis drupal 10 mit dem im core enthaltenen book modul gemacht werden konnte

---

## Drupal: Strukturierte Inhalte mit dem Paragraphen-Modul als Alternative zum Book-Modul

Gerne erstelle ich eine ausführliche Handlungsanweisung, wie Sie mit dem Paragraphen-Modul in Drupal 10 strukturierte Inhalte erzeugen können, die funktional dem früheren Book-Modul entsprechen.

## Hintergrund

Das Book-Modul, das im Drupal Core bis einschließlich Drupal 10 enthalten war, ermöglichte es, hierarchisch strukturierte Inhalte zu erstellen - ideal für Dokumentationen, Handbücher oder andere strukturierte Inhaltssammlungen. Mit dem Paragraphen-Modul können wir eine ähnliche Funktionalität erreichen, jedoch mit mehr Flexibilität.

## Voraussetzungen

- Drupal 10 Installation
- Folgende Module (über Composer installieren):
	- Paragraphs (`composer require drupal/paragraphs`)
	- Entity Reference Revisions (`composer require drupal/entity_reference_revisions`)
	- Optional: Pathauto (`composer require drupal/pathauto`) für automatische URL-Aliase

## Schritt-für-Schritt Anleitung

### 1\. Module installieren und aktivieren

```bash
composer require drupal/paragraphs drupal/entity_reference_revisions
drush en paragraphs entity_reference_revisions -y
```

### 2\. Paragraphen-Typen erstellen

1. Navigieren Sie zu "Struktur" > "Paragraphen-Typen" > "Hinzufügen"
2. Erstellen Sie einen Paragraphen-Typ "Buch-Kapitel":
	- Name: Buch-Kapitel
	- Beschreibung: Repräsentiert ein Kapitel in einem Buch
	- Felder hinzufügen:
		- Titel (Textfeld)
		- Inhalt (Text mit Editor)
		- Unterkapitel (Paragraphen-Referenz, die auf denselben Paragraphen-Typ verweist)
3. Klicken Sie auf "Paragraphentyp speichern"
4. Bearbeiten Sie den erstellten Paragraphen-Typ, um die Felder hinzuzufügen:
	- Klicken Sie auf "Felder" > "Feld hinzufügen"
	- Fügen Sie ein Textfeld "Titel" hinzu
	- Fügen Sie ein Textfeld mit formatiertem Text "Inhalt" hinzu
	- Fügen Sie ein Paragraphen-Referenzfeld "Unterkapitel" hinzu:
		- Typ: Paragraph
		- Beschreibung: Untergeordnete Kapitel
		- Referenzierter Typ: Buch-Kapitel (derselbe Typ für Rekursion)
		- Unbegrenzte Anzahl
		- Widget: Paragraphen Klassisch

### 3\. Inhaltstyp "Buch" erstellen

1. Navigieren Sie zu "Struktur" > "Inhaltstypen" > "Hinzufügen"
2. Erstellen Sie einen Inhaltstyp "Buch":
	- Name: Buch
	- Beschreibung: Ein Buch mit hierarchisch strukturierten Kapiteln
	- Veröffentlichungseinstellungen anpassen nach Bedarf
3. Fügen Sie dem Inhaltstyp folgende Felder hinzu:
	- Titel (bereits vorhanden)
	- Beschreibung (Text mit Editor)
	- Kapitel (Paragraphen-Referenzfeld)
		- Typ: Paragraph
		- Beschreibung: Hauptkapitel des Buches
		- Referenzierter Typ: Buch-Kapitel
		- Unbegrenzte Anzahl
		- Widget: Paragraphen Klassisch

### 4\. Anzeige und Darstellung konfigurieren

1. Navigieren Sie zu "Struktur" > "Inhaltstypen" > "Buch" > "Anzeige verwalten"
2. Konfigurieren Sie die Darstellung der Felder nach Ihren Wünschen
3. Für den Paragraphen-Typ "Buch-Kapitel":
	- Navigieren Sie zu "Struktur" > "Paragraphentypen" > "Buch-Kapitel" > "Anzeige verwalten"
	- Stellen Sie sicher, dass Titel, Inhalt und Unterkapitel sichtbar sind
	- Wählen Sie passende Formatierungen für jedes Feld

### 5\. Navigation und Menüoptionen einrichten

1. Nutzen Sie die Drupal Menüsysteme, um eine Navigation für Ihre Bücher zu erstellen
2. Alternativ können Sie einen View erstellen, der alle Bücher auflistet

### 6\. Praxisbeispiel: Ein Buch erstellen

Lassen Sie uns nun ein konkretes Beispiel durcharbeiten - ein kurzes Handbuch zum Thema "Einführung in Drupal":

1. Navigieren Sie zu "Inhalt" > "Hinzufügen" > "Buch"
2. Geben Sie folgende Informationen ein:
	- Titel: Einführung in Drupal
	- Beschreibung: Ein Handbuch für Drupal-Anfänger
3. Im Feld "Kapitel" klicken Sie auf "Paragraph hinzufügen":
	- Titel: 1. Installation von Drupal
	- Inhalt: Hier beschreiben wir den Installationsprozess von Drupal...
	- Keine Unterkapitel vorerst
4. Fügen Sie ein weiteres Kapitel hinzu:
	- Titel: 2. Grundlegende Konfiguration
	- Inhalt: Nach der Installation müssen einige grundlegende Einstellungen vorgenommen werden...
	- Fügen Sie nun Unterkapitel hinzu:
		- Klicken Sie auf "Paragraph hinzufügen" im Feld "Unterkapitel"
		- Titel: 2.1 Benutzer und Berechtigungen
		- Inhalt: In diesem Kapitel lernen Sie, wie Benutzerrollen und Berechtigungen verwaltet werden...
		- Fügen Sie ein weiteres Unterkapitel hinzu:
		- Titel: 2.2 Module installieren
		- Inhalt: Drupal kann durch Module erweitert werden...
5. Speichern Sie das Buch

## Erweiterte Funktionen

### Inhaltsverzeichnis erstellen

Um ein automatisches Inhaltsverzeichnis zu erstellen, können Sie:

1. Ein benutzerdefiniertes Theme-Template für den Inhaltstyp "Buch" erstellen
2. Einen View erstellen, der die Kapitelstruktur für jedes Buch anzeigt
3. Das Modul "Table of Contents" installieren und konfigurieren

### Navigationselemente zwischen Kapiteln

Um die Navigation zwischen Kapiteln zu ermöglichen (wie im Book-Modul):

1. Erstellen Sie ein zusätzliches Template für den Paragraphen-Typ
2. Fügen Sie mit JavaScript oder im PHP-Code Verknüpfungen zum vorherigen/nächsten Kapitel ein
3. Verwenden Sie ein benutzerdefiniertes Modul, um diese Funktionalität bereitzustellen

## Gegenüberstellung: Book-Modul vs. Paragraphen-Lösung

### Vorteile der Paragraphen-Lösung

- Mehr Flexibilität bei der Strukturierung
- Möglichkeit, verschiedene Inhaltsarten in den Kapiteln zu kombinieren
- Bessere Integration mit anderen Drupal-Funktionen
- Zukunftssicher für Drupal 11+

### Nachteile

- Höherer Konfigurationsaufwand
- Manuelle Einrichtung einiger Funktionen, die im Book-Modul enthalten waren
- Etwas komplexere Benutzeroberfläche für Redakteure

Diese Anleitung gibt Ihnen einen soliden Ausgangspunkt für die Erstellung von strukturierten Inhalten mit dem Paragraphen-Modul als Alternative zum Book-Modul. Die Lösung ist flexibel und kann an spezifische Anforderungen angepasst werden.