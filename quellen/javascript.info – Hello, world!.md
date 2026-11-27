---
id: 202611270937
title: "javascript.info – Hello, world!"
type: quelle
tags:
  - web/html
created: 2026-11-27
herkunft: 01-Courses/Programming/JavaScript-STEM
autor: Ilya Kantor
url: https://javascript.info/hello-world
art: doku
---

## Worum es geht

Das erste Kapitel des frei lesbaren Tutorials *The Modern JavaScript Tutorial*. Es zeigt, wie JavaScript mit dem `<script>`-Tag in eine HTML-Seite kommt – direkt im Tag oder als externe Datei. Im Archiv lag eine Kopie des Kapitels samt dem Auszeichnungsformat des Tutorials.

## Kernaussagen

- Der Browser führt den Inhalt eines `<script>`-Tags aus, sobald er beim Lesen der Seite darauf trifft.
- Die Attribute `type="text/javascript"` und `language` sind überflüssig; `type` dient heute vor allem dazu, Module zu kennzeichnen.
- HTML-Kommentare um Skriptcode stammen aus der Zeit, als Browser `<script>` noch nicht kannten, und verraten sehr alten Code.
- Externe Skripte bindet `src` ein; der Browser kann sie zwischenspeichern und auf mehreren Seiten wiederverwenden.
- Ist `src` gesetzt, wird der Inhalt des Tags ignoriert.

## Daraus entstandene Zettel

- [[Ein script-Tag mit src ignoriert seinen Inhalt]]
