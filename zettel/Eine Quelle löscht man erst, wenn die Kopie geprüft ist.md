---
id: 202611281417
title: Eine Quelle löscht man erst, wenn die Kopie geprüft ist
type: zettel
tags:
  - dateiablage
created: 2026-11-28
---

Beim Verschieben von Dateien an einen anderen Ort – in ein anderes Repository, auf einen anderen Datenträger – sollte man den Schritt zerlegen, statt blind zu verschieben:

1. **Prüfen, ob am Ziel schon etwas liegt.** Dann nichts überschreiben, sondern nachfragen.
2. **Kopieren.**
3. **Vergleichen**, bei Ordnern jede einzelne Datei. Bei einer Abweichung verwirft man die Kopie und lässt die Quelle liegen.
4. **Protokollieren**, was wann wohin ging.
5. **Erst dann die Quelle löschen.**

So bleibt bei jedem Abbruch mindestens eine unversehrte Fassung übrig.

Für den Vergleich taugt `git hash-object`: Der Befehl läuft überall, wo Git installiert ist, unabhängig von Shell und Betriebssystem. Mit `--no-filters` vergleicht man die Dateien, wie sie auf der Platte liegen. Ohne die Option wendet Git je nach `.gitattributes` und Konfiguration Umwandlungen an, etwa der Zeilenenden.

```sh
git hash-object --no-filters quelle/scan.pdf ziel/scan.pdf
```

Zwei gleiche Zeilen in der Ausgabe bedeuten gleichen Inhalt.

Liegt die Quelle in einem Git-Repository, gehört der letzte Commit vor dem Löschen mit ins Protokoll. Damit findet man die Datei später wieder.

## Verbindungen

- [[Git speichert gleichen Inhalt nur einmal]] – woher die Prüfsumme stammt
- [[Ein Austausch-Repository stellt Dateien zu, ohne sie zu bearbeiten]] – ein Verfahren, das so arbeitet
- [[Eine gelöschte Datei bleibt in der Git-Historie]] – so holt man eine protokollierte Datei zurück
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
