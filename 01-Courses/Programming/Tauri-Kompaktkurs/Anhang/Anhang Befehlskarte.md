---
typ: anhang
title: Befehlskarte für Teilnehmende
tags: [tauri/kompaktkurs/anhang, nushell]
status: draft
---

# Anhang – Befehlskarte für Teilnehmende

> [!tip] Zum Ausdrucken
> Eine Seite, liegt während des gesamten Kurses auf dem Tisch. Nichts davon muss auswendig gelernt werden.

## Jeden Morgen

```nu
toolbox enter tauri-dev
cd ~/Projekte/lernkarten
cargo tauri dev
```

Beenden: im Terminal `Strg` + `C`, dann `exit`.

## Fenster nebeneinander (Sway)

```nu
swaymsg splith
```

## Konsole öffnen

Im Anwendungsfenster: Rechtsklick, dann „Element untersuchen", Reiter „Konsole".

## Woran erkenne ich, wo ich bin?

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

Der Eingabezeile sieht man es auch an: Im Container steht ein Sechseck davor.

## Dateien ansehen

```nu
ls
open index.html
ls ~/.local/share/de.metarow.Lernkarten
```

## Nur am letzten Tag

```nu
exit                                    # zuerst raus aus dem Container

cd ~/Projekte/lernkarten
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.Lernkarten.yml
flatpak remote-add --user --no-gpg-verify --if-not-exists lernkarten-lokal $"($env.PWD)/repo"
flatpak install --user lernkarten-lokal de.metarow.Lernkarten
flatpak run de.metarow.Lernkarten
flatpak info --show-permissions de.metarow.Lernkarten
```

## Wenn etwas nicht geht

| Was Sie sehen | Was Sie tun |
|---|---|
| Fenster bleibt weiß | Kursleitung ansprechen |
| Änderung erscheint nicht | Gespeichert? Richtige Datei? |
| Rote Meldung in der Konsole | Erste Zeile vorlesen, dann gemeinsam schauen |
| Terminal reagiert nicht | `Strg` + `C` |
| Gar nichts geht mehr | Terminal schließen, neu anfangen. Es geht nichts verloren. |

## Die drei Dateien

| Datei | Zuständig für |
|---|---|
| `index.html` | was da ist |
| `style.css` | wie es aussieht |
| `app.js` | was passiert |

## Verknüpfung

[[00 Kompaktkonzept Tauri Grundlagen]]
