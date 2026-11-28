---
id: 202611281422
title: Ein Geheimnis-Check sucht nach echten Werten statt nach Wörtern
type: zettel
tags:
  - sicherheit
  - ki/agenten
created: 2026-11-28
---

Soll ein Agent oder Skript verhindern, dass Zugangsdaten in ein Repository gelangen, liegt eine Regel nahe wie: „Dateien ablehnen, in denen `token` oder `password` vorkommt.“ Sie schlägt aber bei jedem Text an, der nur **über** Zugangsdaten spricht – bei Anleitungen, Chatprotokollen, Konfigurationsvorlagen und nicht zuletzt bei der Beschreibung der Regel selbst. Häufen sich Fehlalarme, gewöhnt man sich an, sie wegzuklicken.

Brauchbarer ist eine Regel, die nach **echten Werten** fragt:

- verdächtige Dateinamen: `.env`, `id_*`, `*.pem`, `*.key`
- ein privater Schlüssel **mit** Schlüsseldaten, nicht bloß die Kopfzeile als Beispiel
- ein Token mit bekanntem Präfix (etwa `ghp_`, `github_pat_`, `sk-`), **gefolgt von der Zeichenfolge**
- ein konkreter Wert, der einem Feld wie `token` oder `password` zugewiesen ist

Ausdrücklich keine Treffer sind bloße Erwähnungen und erkennbare Platzhalter wie `<token>`. Im Zweifel wird nachgefragt.

Bei einem Fund nennt die Meldung die **Fundstelle**, aber nicht den Wert. Sonst steht das Geheimnis danach auch im Protokoll.

Eine solche Prüfung ist ein Netz mit Maschen: Werte in unbekanntem Format oder in Binärdateien kann sie übersehen.

## Verbindungen

- [[Ein gepushtes Geheimnis muss man austauschen]] – was droht, wenn die Prüfung versagt
- [[Ein Agenten-Prompt nennt Ziel, Kontext, Werkzeuge, Grenzen und Stoppbedingung]] – auch eine Prüfregel für Agenten muss sagen, was nicht zählt
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
