---
id: 202611281418
title: Ein Austausch-Repository stellt Dateien zu, ohne sie zu bearbeiten
type: zettel
tags:
  - git
  - dateiablage
created: 2026-11-28
---

Chatprotokolle, Scans und Exporte entstehen oft nicht dort, wo man sie braucht, sondern in einem anderen Projekt oder auf einem anderen Rechner. Ein privates Git-Repository als **Poststelle** gibt ihnen einen festen Weg: Es nimmt Sendungen an, sortiert sie nach Empfänger und stellt sie zu. Den Inhalt bearbeitet es nicht – das tut das Zielprojekt.

```text
eingang/  →  ausgang/<ziel>/  →  <Zielprojekt>/<Eingangsordner>/
```

- **Zwei Stufen:** Annehmen und Zustellen dürfen auf verschiedenen Rechnern geschehen. Der Ausgang wartet, über den Git-Server synchronisiert, bis ein Rechner das Zielprojekt ausgecheckt hat.
- **Verteiler:** Eine Datei listet die Ziele auf. Liegen die Projekte als Nachbarordner nebeneinander, genügt je Ziel der Ordnername (`../<ordner>`), ohne absoluten Pfad. So gilt dieselbe Datei unter Linux und Windows.
- **Namensregel:** `JJJJ-MM-TT_<ziel>_<titel>` – die Sendung trägt Datum und Adresse bei sich, auch nach dem Kopieren.
- **Enge Befugnis:** Im Zielprojekt wird nur in dessen Eingang geschrieben, nichts überschrieben, gelöscht oder committet. Das Zielprojekt verarbeitet seine Post selbst.
- **Durchgang statt Archiv:** Zugestellte Sendungen verlassen den Ausgang; ein Journal hält jede Zustellung fest.

Nicht hinein gehören Zugangsdaten, weil sie in der Historie bleiben, und sehr große Dateien.

## Verbindungen

- [[Eine Quelle löscht man erst, wenn die Kopie geprüft ist]] – die Regel für den Zustellschritt
- [[Ein Ziffernpräfix sortiert Namen vor die Buchstaben]] – damit die Poststelle vor den Projekten steht und die Sendungen nach Datum
- [[Ein Geheimnis-Check sucht nach echten Werten statt nach Wörtern]] – die Eingangskontrolle
- [[Binärdateien lassen ein Git-Repository schnell wachsen]] – die Grenze bei vielen oder großen Sendungen
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
