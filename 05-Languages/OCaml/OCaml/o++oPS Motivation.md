---
title: "o++o Systeme"
source: "https://ottops.de/motivation.html"
author:
published:
created: 2025-03-13
description:
tags:
  - "clippings"
---
o++o bzw. ottoPS (ottoProgrammier Sprache) ist im Wesentlichen eine einfache aber leistungsfähige Anfragesprache, ermöglicht aber auch Berechnungen in einem weiten Anwendungsbereich.  
  
o++oPS verwendet Wiederholgruppen (Hierarchien) und verfügt über mächtige, jedoch einfach anwendbare Operatoren für Auswahl, Restrukturierung, Berechnung und Kombination von Tabellen und Dokumenten.***

### Eigenschaften von o++oPS

- kurze Programme, einfache Syntax; Operationsnamen kann man sich leicht merken; bereits Kochrezeptprogramme (sequentielle Abarbeitung) sind sehr ausdrucksstark
- Bedingungen müssen nicht verknüpft werden; sie können nacheinander angewandt werden; zwei aufeinanderfolgende Bedingungen sind nicht immer gleichbedeutend mit ihrer Konjunktion (erhöhte Ausdruckskraft)
- leistungsfähige Operationen für Auswahl, Restrukturierung, Berechnung, Kombination und Lösung von Stücklistenproblemen, ...   kompakte (hsq) und einfache (tab) Darstellung von Tabmenten (Tabellen und Dokumente)
- Aggregationen ohne GROUPBY; GROUPBY kann bei Datenströmen nicht angewandt werden.
- kein kartesisches Produkt (Kreuzprodukt); beim Kreuzprodukt wird stets jedes Element der einen Tabelle mit jedem Element der anderen Tabelle verschmolzen. Dadurch entstehen auch im Kopf des Nutzer sehr große Zwischentabellen. Joinbedingungen sind stets erforderlich.
- Anwenderfunktionalität kann in o++o-Programme integriert werden; dadurch verlieren Einbettungen von o++o in herkömmliche Programmiersprachen wie JAVA, C,... an Bedeutung.
- bei o++o steht Programmiermethodik über Computereffizienz; letztere wird durch verbesserte Hardware weitgehend garantiert.
- Die Grundoperationen sind leichter zu verstehen als der Algorithmus der Dezimalzahlmultiplikation.
- Implementierung in `OCaml` (INRIA Paris); damit ist o++o ein rein europäisches Produkt.
- Suchbäume konnten in Tabmente integriert werden; damit ergibt sich eine wesentlich bessere Effizienz für viele Problemklassen.

### Ziele von o++oPS
- hinter jedem Klick sollte ein lesbares Programm stehen; falls der Endnutzer dann ein Problem mit dem Computerresultat hat, kann er das Programm solange selbst modifizieren bis er das gewünschte Ergebnis erzielt hat.
- erweiterte Anfragen an die Wikipedia; zur Zeit können viele Informationen aus der Wikipedia nur mit großem manuellen Aufwand extrahiert werden.
- o++o soll ein universelles Interface für Tabellen und Dokumente werden; d.h. der Nutzer soll mit einheitlichen Mitteln beliebige Datenbanken, Dateien, Retrievalsysteme und das Internet abfragen können.