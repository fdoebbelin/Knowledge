---
title: Monitoranordnung unter Fedora Sway Atomic konfigurieren
created: 2026-09-23
type: chat-protokoll
source: claude.ai
model: Claude Opus 5
tags:
  - chat-protokoll
  - fedora-atomic
  - kanshi
  - nwg-displays
  - sway
  - wayland
status: active
system: Fedora Sway Atomic
---

# Monitoranordnung unter Fedora Sway Atomic konfigurieren

> [!summary] Zusammenfassung
> Ziel war, die Reihenfolge der erkannten Bildschirme unter [[Fedora Sway Atomic]] zu ändern, zunächst mit der Frage nach einem grafischen Werkzeug. Ergebnis: `nwg-displays` als GUI mit persistenter Speicherung, alternativ die direkte Konfiguration über `output`-Direktiven, deren Koordinaten sich mit `swaymsg -t get_outputs` ermitteln lassen. Zwei Konfigurationen wurden erarbeitet und vom Nutzer als funktionierend bestätigt: das Tauschen der beiden äußeren von drei gleich breiten HP-Monitoren und eine vertikale Anordnung aus Dell P1911 oben und Notebook-Display darunter. Zentrale Erkenntnis ist, dass Sway mit **logischen** Koordinaten rechnet, also nach Skalierung, weshalb `rect` und nicht `current_mode` die Grundlage der Positionsberechnung ist. Im Anschluss wurde [[kanshi]] mit zwei Profilen für den Notebook-Betrieb eingerichtet, wobei eine abweichende Syntax für Positionsangaben zum Stolperstein wurde. Ob die kanshi-Profile nach der Korrektur greifen, ist im Chat nicht mehr bestätigt.

> [!warning] Hinweise zur Vollständigkeit
> Seriennummern der Monitore stehen unverändert in der Notiz, da sie für die Identifikation über Hersteller/Modell/Serie fachlich relevant sind. Falls das im Vault nicht gewünscht ist, durch `<SERIAL>` ersetzen.

## Ausgangslage

Fedora Sway Atomic als rpm-ostree-basiertes System, Sway als Compositor. Der Nutzer wollte die Reihenfolge mehrerer erkannter Bildschirme anpassen und zunächst wissen, ob es dafür eine grafische Möglichkeit gibt oder ob die Sway-Config direkt editiert werden muss.

Im Verlauf wurden zwei unterschiedliche Hardware-Konstellationen genannt:

1. drei HP 24fh, alle mit `scale 1.5`, also logisch je 1280x720, horizontal bei X 0, 1280 und 2560
2. ein Dell P1911 (1440x900, `scale 1`) an HDMI-A-1 plus internes Panel `eDP-1` (1920x1080, `scale 1.3`)

Ob es sich um zwei verschiedene Rechner oder einen Wechsel der Peripherie handelt, wurde nicht geklärt. Beide Konfigurationen wurden vom Nutzer als korrekt arbeitend bestätigt.

## Problemlösungen

### 1. Grafische Konfiguration gesucht, Persistenz aber gefordert

**Symptom**

```text
Grafische Werkzeuge für Wayland/Sway wenden Änderungen teils nur
zur Laufzeit an; nach Neustart ist die Anordnung wieder wie vorher.
```

**Ursache:** Sway kennt keine eigene Speicherung von Output-Zuständen. Was nicht in der Config steht, ist beim nächsten Start weg.

**Lösung**

`nwg-displays` verwenden, weil es die Anordnung nicht nur anwendet, sondern auch als `output`-Direktiven in eine Datei schreibt (standardmäßig `~/.config/sway/outputs`).

```bash
rpm-ostree install nwg-displays
systemctl reboot
# oder ohne Neustart:
rpm-ostree install --apply-live nwg-displays
```

Einmalig in die Sway-Config aufnehmen, damit die generierte Datei gelesen wird:

```bash
include ~/.config/sway/outputs
```

Die `include`-Zeile muss **nach** bestehenden Output-Einstellungen stehen, sonst überschreiben die alten Werte die generierten.

> [!failure]- Verworfene Ansätze
> - `wdisplays` – schlanker und gut zum Ausprobieren, wendet Änderungen aber nur zur Laufzeit an; die Werte müssen anschließend manuell in die Config übertragen werden.

### 2. Zuordnung von Connector-Namen zu physischen Monitoren unklar

**Symptom**

```text
swaymsg -t get_outputs liefert Namen wie DVI-I-1, HDMI-A-1, VGA-1 –
welcher davon ist der linke, mittlere, rechte Bildschirm?
```

**Ursache:** Die Connector-Bezeichnung sagt nichts über die physische Aufstellung.

**Lösung**

Einen Ausgang kurz dunkel schalten und beobachten, welcher Monitor reagiert:

```bash
swaymsg output DP-2 dpms off; sleep 3; swaymsg output DP-2 dpms on
```

### 3. Skalierung verfälscht die Positionsberechnung

**Symptom**

```text
Position 2560 für einen 3840 px breiten Monitor wirkt zu klein –
die Monitore überlappen oder es entsteht eine Lücke, ohne dass Sway
eine Fehlermeldung ausgibt. Der Mauszeiger hängt an der Kante fest.
```

**Ursache:** Sway ordnet alle Ausgänge in ein gemeinsames Koordinatensystem ein und rechnet dort mit **logischen** Werten, also Auflösung geteilt durch `scale`. Ein 3840er Panel mit `scale 1.5` belegt logisch nur 2560 px.

**Lösung**

Immer `rect` aus `get_outputs` als Grundlage nehmen, nicht `current_mode`:

```bash
swaymsg -t get_outputs | jq -r '.[] | "\(.name)\t\(.rect.x),\(.rect.y)\t\(.rect.width)x\(.rect.height)\tscale \(.scale)\t\(.make) \(.model) \(.serial)"'
```

**Verifikation**

```bash
swaymsg -t get_outputs | jq -r '.[] | "\(.name)\t\(.rect.x),\(.rect.y)\t\(.rect.width)x\(.rect.height)"'
# erwartet: lückenlos aneinandergrenzende Rechtecke,
# also x_nächster == x_vorheriger + width_vorheriger
```

### 4. Zwei äußere von drei Monitoren tauschen

**Symptom**

```text
Die Reihenfolge der drei erkannten Bildschirme soll geändert werden,
indem nur die beiden äußeren die Plätze wechseln.
```

**Ursache:** Kein Fehler, sondern eine Rechenaufgabe. Bei links = A, Mitte = M, rechts = B:

```text
vorher:   A bei 0        M bei wA        B bei wA+wM
nachher:  B bei 0        M bei wB        A bei wB+wM
```

**Lösung**

Sind A und B gleich breit, bleiben die drei X-Werte unverändert und es werden nur die Namen getauscht. Genau das war beim Nutzer der Fall, alle drei HP 24fh waren logisch 1280 px breit:

```bash
swaymsg output VGA-1 position 0 0
swaymsg output DVI-I-1 position 2560 0
```

Bei unterschiedlicher Breite muss die Mitte mitwandern, sonst entsteht Lücke oder Überlappung. Während des Umsetzens überlappen sich zwei Ausgänge kurzzeitig, das stört Sway nicht.

### 5. Identifikation über Seriennummer bei identischen Modellen

**Symptom**

```text
HP Inc. HP 24fh 3CM9440NRX
HP Inc. HP 24fh 3CM9440NRV
```

**Ursache:** Die empfohlene stabile Identifikation über `"Hersteller Modell Serie"` ist bei drei baugleichen Geräten fehleranfällig, weil sich die Seriennummern nur im letzten Zeichen unterscheiden.

**Lösung**

In diesem Fall bei den Connector-Namen bleiben. Sie sind stabil, solange die Kabel nicht umgesteckt werden.

### 6. Fraktionale Skalierung 1.3 ergibt krumme logische Werte

**Symptom**

```text
1920 / 1.3 = 1476,9  ->  1477
1080 / 1.3 =  830,8  ->   831
```

**Ursache:** `scale 1.3` geht nicht glatt auf, Sway rundet die logische Größe. Die berechnete Y-Position kann dadurch um ein Pixel neben dem tatsächlichen `rect` liegen. Zusätzlich erzeugt fraktionale Skalierung bei XWayland-Anwendungen unscharfe Kanten.

**Lösung**

Nach dem Setzen die tatsächlichen Werte prüfen und gegebenenfalls `rect.height` des oberen Monitors als Y-Wert übernehmen. Glatte Alternativen bei 1920x1080:

| scale | logisch |
| --- | --- |
| 1.25 | 1536x864 |
| 1.5 | 1280x720 |

Praktisch hat `scale 1.3` mit `position 0 900` funktioniert, die Umstellung auf 1.25 bleibt optional.

### 7. kanshi-Config wird nicht geparst: „missing x/y“

**Symptom**

```text
$ kanshictl reload
invalid output position: missing x/y
(on line 2)
failed to parse config file
```

**Ursache:** kanshi erwartet die Koordinaten als **ein** kommagetrenntes Argument, Sway hingegen als zwei durch Leerzeichen getrennte Werte. Die zunächst gelieferte Konfiguration hatte die Sway-Schreibweise übernommen.

| Werkzeug | Syntax |
| --- | --- |
| Sway | `position 0 900` |
| kanshi | `position 0,900` |

**Lösung**

In `~/.config/kanshi/config` alle Positionsangaben auf Kommaschreibweise umstellen:

```bash
output eDP-1 enable mode 1920x1080 scale 1.3 position 0,900
```

**Verifikation**

```bash
kanshictl reload
# erwartet: keine Ausgabe, kein Parserfehler
```

## Artefakte & Prompts

### outputs.conf – drei HP 24fh, äußere getauscht

- **Typ:** Sway-Konfigurationsschnipsel
- **Beschreibung:** Horizontale Anordnung von drei logisch gleich breiten Monitoren, bei der die beiden äußeren gegenüber dem Ausgangszustand die Plätze getauscht haben. Vom Nutzer als funktionierend bestätigt.

**Original-Prompts** (chronologisch, wörtlich)

> ich möchte bei fedora sway atomic die reihenfolge der erkannte bildschirme anpassen, gibt es eine grafische möglichkeit oder muss ich in der sway config direkt editieren

> kann ich die notwendigen koordinaten an der konsole ermitteln und dann meine 3 monitore so ko0nfigurieren das die beiden äußeren nur getauscht werden

> ich bekomme folgenden kompakte Ausgabe:
> DVI-I-1	0,0	1280x720	scale 1.5	HP Inc. HP 24fh 3CM94703TD
> HDMI-A-1	1280,0	1280x720	scale 1.5	HP Inc. HP 24fh 3CM9440NRX
> VGA-1	2560,0	1280x720	scale 1.5	HP Inc. HP 24fh 3CM9440NRV

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Unter Fedora Sway Atomic habe ich drei Monitore. swaymsg -t get_outputs liefert:
>
> DVI-I-1   0,0      1280x720  scale 1.5  HP Inc. HP 24fh 3CM94703TD
> HDMI-A-1  1280,0   1280x720  scale 1.5  HP Inc. HP 24fh 3CM9440NRX
> VGA-1     2560,0   1280x720  scale 1.5  HP Inc. HP 24fh 3CM9440NRV
>
> Ich möchte nur die beiden äußeren Monitore tauschen, der mittlere bleibt, wo er
> ist. Gib mir die output-Direktiven für eine persistente Konfiguration, die
> rpm-ostree-Upgrades übersteht, plus die swaymsg-Befehle zum Ausprobieren ohne
> Reload. Rechne mit logischen Koordinaten nach Skalierung. Sag mir außerdem, ob
> die Identifikation über Connector-Name oder über Hersteller/Modell/Serie hier
> sinnvoller ist, und begründe es.
> ```

`~/.config/sway/config.d/outputs.conf`:

```bash
output VGA-1 position 0 0
output HDMI-A-1 position 1280 0
output DVI-I-1 position 2560 0
```

### outputs.conf – Dell P1911 über Notebook-Display

- **Typ:** Sway-Konfigurationsschnipsel
- **Beschreibung:** Vertikale Anordnung: externer Dell P1911 oben, internes Notebook-Panel darunter. Vom Nutzer als funktionierend bestätigt, anschließend durch die kanshi-Profile ersetzt.

**Original-Prompts** (chronologisch, wörtlich)

> ich bekomme folgende Ausgabe:
> swaymsg -t get_outputs
> Output HDMI-A-1 'Dell Inc. DELL P1911 KY35F09U0W1U'
>   Current mode: 1440x900 @ 59.887 Hz
>   Position: 0,0
>   Scale factor: 1.000000
> […]
> Output eDP-1 'Chimei Innolux Corporation 0x15F5 Unknown' (focused)
>   Current mode: 1920x1080 @ 60.008 Hz
>   Position: 1440,0
>   Scale factor: 1.300000
> […]
> und möchte den DELL oben und den Notebookblidschirm darunter anordnen, wie sieht die Konfig aus

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Unter Fedora Sway Atomic habe ich zwei Ausgänge:
>
> HDMI-A-1  Dell P1911, 1440x900, scale 1.0,  aktuell Position 0,0
> eDP-1     Notebook-Panel, 1920x1080, scale 1.3, aktuell Position 1440,0
>
> Ich möchte den Dell oben und das Notebook-Display darunter anordnen. Gib mir
> die output-Direktiven für eine persistente Konfiguration unter
> ~/.config/sway/config.d/, die rpm-ostree-Upgrades übersteht, plus die
> swaymsg-Befehle zum Ausprobieren ohne Reload. Rechne mit logischen
> Koordinaten nach Skalierung und weise darauf hin, dass scale 1.3 nicht glatt
> aufgeht. Zeige auch, wie ich die beiden horizontal zentriere statt
> linksbündig, und ob eine andere Skalierung sinnvoller wäre.
> ```

`~/.config/sway/config.d/outputs.conf`:

```bash
output HDMI-A-1 scale 1 position 0 0
output eDP-1 scale 1.3 position 0 900
```

Zentriert statt linksbündig, da das Notebook logisch etwa 37 px breiter ist:

```bash
output HDMI-A-1 scale 1 position 18 0
output eDP-1 scale 1.3 position 0 900
```

### kanshi/config – Profile „mobil“ und „schreibtisch“

- **Typ:** kanshi-Konfiguration
- **Beschreibung:** Zwei Profile für den Notebook-Betrieb, die beim An- und Abstecken des Dell automatisch umschalten. Ersetzt die statische Sway-Variante für dieses Gerät.

**Original-Prompts** (chronologisch, wörtlich)

> beide Konfigurationen arbeiten korrekt, richten wir die Notebook profile ein

> kanshi reload
> invalid output position: missing x/y
> (on line 2)
> failed to parse config file

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Unter Fedora Sway Atomic möchte ich kanshi für ein Notebook einrichten, mit
> zwei Profilen: nur internes Panel, und internes Panel plus externer Monitor
> darüber.
>
> eDP-1     Notebook-Panel, 1920x1080, scale 1.3
> HDMI-A-1  Dell P1911, 1440x900, scale 1  – soll oben sitzen, eDP-1 darunter
>           (Hersteller/Modell/Serie: Dell Inc. DELL P1911 KY35F09U0W1U)
>
> Beachte, dass kanshi Positionen kommagetrennt erwartet (position 0,900), nicht
> wie Sway mit Leerzeichen. Sprich den externen Monitor über
> Hersteller/Modell/Serie an, weil er je nach Dock an einem anderen Connector
> landen kann. Sag mir außerdem, wie ich die bestehenden statischen
> output-Direktiven in der Sway-Config loswerde, wie ich kanshi unter Sway
> starte, und welche Fallstricke es bei Profilauswahl und Arbeitsflächen gibt.
> ```

`~/.config/kanshi/config`:

```bash
profile mobil {
    output eDP-1 enable mode 1920x1080 scale 1.3 position 0,0
}

profile schreibtisch {
    output "Dell Inc. DELL P1911 KY35F09U0W1U" enable mode 1440x900 scale 1 position 0,0
    output eDP-1 enable mode 1920x1080 scale 1.3 position 0,900
}
```

Autostart in `~/.config/sway/config.d/kanshi.conf`:

```bash
exec kanshi
```

## Entscheidungen

- `nwg-displays` statt `wdisplays` als GUI-Empfehlung – nur Ersteres schreibt die Anordnung persistent in eine Config-Datei.
- Eigene Overrides nach `~/.config/sway/config.d/` – die mitgelieferte Config von Fedora Sway Atomic liegt unter `/usr/share/sway/config.d/` und wird bei `rpm-ostree upgrade` ersetzt.
- Identifikation über Connector-Namen bei den drei HP-Monitoren, über Hersteller/Modell/Serie beim Dell am Notebook – bei baugleichen Monitoren unterscheiden sich die Seriennummern nur minimal, beim Notebook kann derselbe Monitor je nach Dock an einem anderen Connector landen. `eDP-1` bleibt in jedem Fall beim Connector-Namen, weil fest verbaut.
- Vertikale Anordnung linksbündig mit `position 0` als Standard, Zentrierung nur als Option – der rechte Streifen ohne Nachbarn oberhalb ist unkritisch.
- Statische `output`-Direktiven für das Notebook entfernen, sobald kanshi läuft – sonst setzen Sway (beim Start und bei `swaymsg reload`) und kanshi (bei jeder Änderung der Monitorkonfiguration) gegeneinander, was zu sporadisch falscher Anordnung führt.
- kanshi über `exec kanshi` in der Sway-Config starten statt über `systemctl --user enable kanshi.service` – die `exec`-Variante hängt nicht davon ab, ob `sway-session.target` korrekt gesetzt wird.

## Nützliche Befehle & Snippets

```bash
swaymsg -t get_outputs                                   # Namen, Modi, Positionen, Skalierung
swaymsg -t get_outputs | jq -r '.[] | "\(.name)\t\(.rect.x),\(.rect.y)\t\(.rect.width)x\(.rect.height)\tscale \(.scale)\t\(.make) \(.model) \(.serial)"'
swaymsg output DP-2 dpms off; sleep 3; swaymsg output DP-2 dpms on   # Monitor identifizieren
swaymsg output HDMI-A-1 position 0 0                     # Position zur Laufzeit setzen
swaymsg reload                                           # Sway-Config neu einlesen
kanshictl reload                                         # kanshi-Config neu einlesen
kanshictl switch schreibtisch                            # Profil manuell erzwingen
command -v kanshi || rpm-ostree install kanshi           # kanshi nachinstallieren
rpm-ostree install --apply-live nwg-displays             # GUI ohne Neustart nachinstallieren
```

Untenbündige Ausrichtung bei unterschiedlichen Höhen:

```bash
# y = maxHöhe - eigeneHöhe, z. B. 1080 neben 1440:
output HDMI-A-1 position 2560 360
```

Modus mit Wiederholrate, falls kanshi den falschen Modus wählt:

```bash
output "Dell Inc. DELL P1911 KY35F09U0W1U" enable mode 1440x900@59.887Hz scale 1 position 0,0
```

## Offene Punkte

- [ ] Greifen die kanshi-Profile nach der Syntaxkorrektur? Im Chat nicht mehr bestätigt. Prüfen mit `swaymsg -t get_outputs` nach dem An- und Abstecken des Dell, erwartet im gedockten Zustand: Dell bei `0,0` mit 1440x900, eDP-1 bei `0,900` mit etwa 1477x831.
- [ ] Statische `output`-Direktiven beziehungsweise `include ~/.config/sway/outputs` für das Notebook tatsächlich entfernen, sonst Konflikt mit kanshi.
- [ ] Verhältnis der beiden Hardware-Konstellationen klären: drei HP 24fh gegenüber Dell P1911 plus Notebook – zwei Rechner oder Wechsel der Peripherie?
- [ ] `scale 1.3` auf `1.25` umstellen prüfen, ergibt glatte 1536x864 und vermeidet Rundung sowie unscharfe XWayland-Darstellung.
- [ ] `scale 1.5` auf den drei HP 24fh hinterfragen: logisch nur 1280x720 pro 24-Zoll-Panel, das kostet viel Arbeitsfläche.
- [ ] Weiteres kanshi-Profil anlegen, falls eine dritte Konstellation auftritt – kanshi wählt ein Profil nur, wenn die angeschlossenen Ausgänge **genau** passen, sonst greift keines.
- [ ] Arbeitsflächen-Zuordnung mit `workspace N output ...` in der Sway-Config, falls bestimmte Workspaces immer auf dem Dell landen sollen – kanshi kümmert sich nur um Position, Modus und Skalierung.
