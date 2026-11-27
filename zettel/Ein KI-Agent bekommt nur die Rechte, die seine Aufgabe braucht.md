---
id: 202611271304
title: Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht
type: zettel
tags:
  - ki/sicherheit
created: 2026-11-27
herkunft: 01-Courses/AI
---

Das **Prinzip des minimalen Privilegs** (*least privilege*) gilt für jedes Programm. Bei KI-Agenten wiegt es schwerer, weil ihr Verhalten nicht vollständig vorhersagbar ist: Klassische Software tut genau, was im Code steht; ein Agent deutet die Lage und entscheidet. Er kann sich irren oder manipuliert werden – und dann bestimmen seine Rechte, wie groß der Schaden wird.

Ein Agent, der Logs auswerten soll, läuft deshalb nicht als `root`, sondern unter einem eigenen Benutzer:

- Lesezugriff auf `/var/log/`, sonst nichts
- keine Schreibrechte, kein `sudo`
- kein Netzzugang nach außen

So kann er alles analysieren, aber nichts kaputtmachen. Entsprechend bekommt ein Agent für Code-Reviews Lesezugriff aufs Repository, aber kein Push-Recht; einer für die Testumgebung kommt nicht an die Produktion.

Rechte sind die Sicherung, die auch dann hält, wenn alle anderen versagen: Eine Anweisung im Prompt kann der Agent missachten, eine fehlende Berechtigung nicht.

## Verbindungen

- [[Indirekte Prompt Injection versteckt Anweisungen in Daten, die der Agent liest]] – der Fall, in dem knappe Rechte den Angriff ins Leere laufen lassen
- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – Freigabe als organisatorische, Rechte als technische Grenze
- [[Toolbx ist keine Sandbox]] – ein Container allein trennt den Agenten nicht vom eigenen Home-Verzeichnis
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema
