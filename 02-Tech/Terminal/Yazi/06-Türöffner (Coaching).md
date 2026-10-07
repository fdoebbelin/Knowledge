---
title: "Yazi als Türöffner – Coaching-Leitfaden"
aliases: [Yazi-Coaching, Coaching Yazi, "Yazi als Türöffner"]
tags: [coaching, vorbereitungsmassnahme, linux, terminal, yazi]
zielgruppe: Einzelcoaching Vorbereitungsmaßnahme
yazi_version: "26.9.1"
created: 2026-10-05
updated: 2026-10-07
status: draft
type: leitfaden
---

# Yazi als Türöffner – Coaching-Leitfaden

## Intention für den Einsatz

> [!abstract] Worum es geht
> Dieser Leitfaden nutzt den Terminal-Dateimanager **Yazi** als Aufhänger, um Konzepte erlebbar zu machen, die in der Fachinformatiker-Ausbildung zu kurz kommen oder gar nicht vermittelt werden. Yazi selbst ist **nicht** das Lernziel. Es ist das Werkzeug, an dem sich Fragen entzünden: *Warum bin ich nach dem Beenden wieder im alten Ordner? Warum friert nichts ein? Woher kommt die Suche?*

**Einsatzrahmen:** Einzelcoaching in einer Vorbereitungsmaßnahme. Die Teilnehmenden haben Grundkenntnisse in der Linux-Shell (`cd`, `ls`, `cp`, `mv`, Pfade, Rechte) oder erwerben sie parallel.

**Haltung:** Erleben vor Erklären. Jedes Konzept wird erst dann benannt, wenn die Person beim Benutzen über das Phänomen gestolpert ist. Der Coach stellt Fragen und liefert die Erklärung erst nach eigenen Vermutungen der Person.

**Was dieser Leitfaden nicht ist:**

- kein Yazi-Kurs und kein Plädoyer, Yazi überall einzusetzen,
- kein Prüfungsstoff im engeren Sinn,
- kein Ersatz für sichere Shell-Grundlagen. Auf fremden Servern zählen weiterhin die Bordmittel, und dort ist eher der Midnight Commander (`mc`) anzutreffen.

**Ziele:** Nach den Stationen kann die Person

1. erklären, warum ein Programm das Arbeitsverzeichnis seiner Shell nicht ändern kann,
2. blockierende und nicht blockierende Ein-/Ausgabe an einem Alltagsbeispiel unterscheiden,
3. das Prinzip „kleine Werkzeuge kombinieren" an einem konkreten Programm nachweisen,
4. Konfiguration als versionierbaren Text begreifen,
5. das Muster „eingebettete Skriptsprache" in anderen Programmen wiedererkennen,
6. Terminalemulator, Shell und Programm auseinanderhalten,
7. ein Open-Source-Werkzeug nach nachvollziehbaren Kriterien bewerten.

**Modularität:** Die sieben Stationen sind unabhängig voneinander. Für eine Sitzung von etwa 90 Minuten eignen sich zwei bis drei Stationen. Station 1 (Prozessmodell) ist der stärkste Einstieg und sollte zuerst kommen.

---

## Hintergrund für den Coach

> [!info]- Name, Aussprache, Herkunft
> - **Name:** chinesisch 鸭子 (*yāzi*) = „Ente", daher die Ente im Logo.
> - **Aussprache:** etwa „JAA-dse". Erste Silbe lang und gleichbleibend hoch, zweite kurz und unbetont. Das „z" ist ein weiches, nicht behauchtes „ds".
> - **Entwickler:** sxyazi, Projektstart um 2023, geschrieben in Rust, asynchrone Laufzeitumgebung Tokio.
> - **Lizenz:** MIT.
> - **Versionierung:** Inzwischen kalenderbasiert (Stand Oktober 2026: 26.9.1), früher 0.x-Versionen. Die Dokumentation ist versioniert, mit getrenntem Zweig für Nightly-Builds.
> - **Doku:** https://yazi-rs.github.io

> [!warning] Versionsstand prüfen
> Yazi ändert Konfiguration und Plugin-Schnittstelle zwischen Releases. Vor jeder Sitzung kurz mit `yazi --version` und der Quick-Start-Seite abgleichen, ob Tastenbelegung und Konfigurationssyntax noch stimmen.

---

## Vorbereitung

### Voraussetzungen auf dem Übungsrechner

- `yazi` (Distribution, Flatpak oder `cargo install --locked yazi-fm yazi-cli`)
- optional, aber für Station 3 nötig: `fd`, `ripgrep`, `fzf`, `zoxide`
- für Station 6 ein Terminal mit Grafikprotokoll, z. B. Kitty, Ghostty, WezTerm, Konsole oder foot

### Übungsumgebung anlegen

```bash
#!/usr/bin/env bash
# legt ~/yazi-uebung als Spielwiese an
set -euo pipefail
basis="$HOME/yazi-uebung"

mkdir -p "$basis"/{projekt/{src,docs,logs},bilder,archiv,ziel}

for i in $(seq -w 1 200); do
  echo "Eintrag $i – Status OK" > "$basis/projekt/logs/log-$i.txt"
done
echo "Eintrag 137 – Status FEHLER" > "$basis/projekt/logs/log-137.txt"

printf '# Notiz\n\nTODO: Fehler in Log 137 prüfen\n' > "$basis/projekt/docs/notiz.md"
printf 'def hallo():\n    print("Hallo")\n' > "$basis/projekt/src/hallo.py"
printf 'cd /etc\npwd\n' > "$basis/wechsel.sh"

# große Datei für die Kopier-Station (Station 2)
dd if=/dev/urandom of="$basis/archiv/gross.bin" bs=1M count=4096 status=progress
```

> [!tip] Kopiervorgang sichtbar machen
> Auf einer schnellen NVMe-SSD ist selbst eine 4-GB-Datei in Sekunden kopiert. Für Station 2 besser auf einen USB-Stick oder eine Netzwerkfreigabe kopieren lassen.

Einige Bilder (Bildschirmfotos, Fotos) in `bilder/` legen.

---

## Einstieg (ca. 10 Minuten)

> [!question] Leitfragen
> - Wie arbeitest du normalerweise mit Dateien? Explorer, Shell, IDE?
> - Was nervt dich dabei?
> - Wann hast du zuletzt auf einem Rechner ohne grafische Oberfläche gearbeitet?

Danach: Yazi mit `yazi` starten (noch **nicht** mit dem Wrapper) und zehn Minuten frei erkunden lassen. Der Spickzettel am Ende dieser Notiz liegt daneben. Auftrag: „Finde die Logdatei mit dem Fehler und kopiere sie nach `ziel/`."

---

## Station 1 – Prozessmodell und Arbeitsverzeichnis

**Auslöser:** Die Person navigiert in Yazi tief in `projekt/logs`, beendet mit `q` und steht in der Shell wieder im Ausgangsverzeichnis.

> [!question] Leitfragen
> - Was hast du erwartet?
> - Wer „besitzt" das Arbeitsverzeichnis: die Shell oder Yazi?
> - Kann ein Programm seinem Elternprozess etwas vorschreiben?

**Übung 1 – Das Phänomen ohne Yazi:**

```bash
cd ~/yazi-uebung
bash -c 'cd /etc; pwd'   # zeigt /etc
pwd                      # immer noch ~/yazi-uebung
bash wechsel.sh          # zeigt /etc
pwd                      # immer noch ~/yazi-uebung
source wechsel.sh        # zeigt /etc
pwd                      # jetzt /etc!
type cd                  # cd is a shell builtin
```

**Übung 2 – Prozessbaum ansehen:**

```bash
pstree -p $$       # oder: ps -o pid,ppid,comm
```

In einem zweiten Terminal ausführen, während Yazi läuft: Yazi erscheint als Kind der Shell.

**Übung 3 – Der Wrapper:** Die Funktion aus der offiziellen Doku in `~/.bashrc` eintragen, neu laden, mit `y` statt `yazi` starten.

```bash
function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}
```

Zeile für Zeile gemeinsam lesen. Dann mit `q` beenden (Verzeichnis wechselt) und mit `Q` beenden (Verzeichnis bleibt).

> [!note]- Erklärung für den Coach
> Jeder Prozess hat sein eigenes Arbeitsverzeichnis und seine eigenen Umgebungsvariablen. Ein Kindprozess erhält beim Start eine **Kopie**. Was er daran ändert, sieht der Elternprozess nie. Deshalb muss `cd` ein Builtin sein: Ein externes Programm `cd` würde nur sein eigenes Verzeichnis wechseln und sich dann beenden.
>
> Der Wrapper umgeht das mit der einfachsten Form der Interprozesskommunikation, einer Datei. Yazi schreibt beim Beenden das letzte Verzeichnis hinein, und die **Shell-Funktion**, die ja im Shell-Prozess selbst läuft, liest es und führt `cd` aus.
>
> Dasselbe Prinzip erklärt: warum `export` in einem Skript nach dem Skriptende verpufft, warum man Python-venvs mit `source` aktiviert, warum `sudo cd` keinen Sinn ergibt.

> [!tip] Bonus für Nushell
> In Nushell muss eine eigene Funktion ausdrücklich mit `def --env` deklariert werden, damit sie die Umgebung des Aufrufers ändern darf. Das Konzept steht dort also sogar in der Syntax:
> ```nu
> def --env y [...args] {
> 	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
> 	^yazi ...$args --cwd-file $tmp
> 	let cwd = (open $tmp)
> 	if $cwd != $env.PWD and ($cwd | path exists) {
> 		cd $cwd
> 	}
> 	rm -fp $tmp
> }
> ```

**Transfer:** Wo begegnet dir das noch? (venv, `export`, `.bashrc` neu laden, Docker-Container und Umgebungsvariablen)

---

## Station 2 – Blockierend vs. asynchron

**Auslöser:** Große Datei kopieren und währenddessen weiterarbeiten.

**Übung 1 – Yazi:** `archiv/gross.bin` mit `y` kopieren, im Ziel (USB-Stick) mit `p` einfügen. Sofort weiter navigieren, Vorschauen ansehen. Mit `w` den Taskmanager öffnen: Fortschritt sichtbar, Aufgabe abbrechbar.

**Übung 2 – Shell:**

```bash
cp archiv/gross.bin /run/media/$USER/STICK/   # Prompt ist blockiert
cp archiv/gross.bin /run/media/$USER/STICK/ & # Prompt sofort zurück
jobs
fg
```

> [!question] Leitfragen
> - Wann hast du zuletzt ein Fenster „(Keine Rückmeldung)" gesehen?
> - Was macht das Programm in dieser Zeit eigentlich?
> - Welche Lösung hatte die Shell schon immer? (`&`, `jobs`, `fg`, `bg`)

> [!note]- Erklärung für den Coach
> Ein blockierendes Programm wartet bei jeder Lese- oder Schreiboperation, bis sie fertig ist. Läuft das im selben Thread wie die Oberfläche, steht die Oberfläche still. Yazi nutzt die asynchrone Laufzeitumgebung Tokio: Die Ein-/Ausgabe wird angestoßen, die Ereignisschleife bedient in der Zwischenzeit Tastatur und Bildschirm, und rechenintensive Aufgaben wie Bilddekodierung laufen auf weiteren Threads.
>
> Das Prinzip ist universell: Webserver (nginx vs. ein Prozess pro Anfrage), JavaScript im Browser (`async`/`await`), Python `asyncio`, GUI-Frameworks mit Hauptthread. Für Anwendungsentwickler ist das eine der wichtigsten Ideen überhaupt und kommt in der Ausbildung meist nur als Randnotiz vor.

**Transfer:** Wie würdest du eine App bauen, die beim Laden großer Daten nicht einfriert?

---

## Station 3 – Komposition statt Monolith

**Auslöser:** Mit `s` nach Dateinamen suchen, mit `S` nach Inhalt („FEHLER"), mit `z` per fzf springen, mit `Z` per zoxide.

**Übung 1 – Abhängigkeiten aufdecken:**

```bash
command -v fd rg fzf zoxide
```

Fehlt eines davon, schlägt die zugehörige Taste in Yazi fehl. Das ist der Moment für die Frage: *Wer sucht hier eigentlich?*

**Übung 2 – Dieselben Werkzeuge pur:**

```bash
fd -e txt . ~/yazi-uebung | wc -l
rg FEHLER ~/yazi-uebung
fd -e md . ~ | fzf
```

> [!question] Leitfragen
> - Warum hat der Entwickler die Suche nicht selbst geschrieben?
> - Was gewinnt man, was verliert man durch solche Abhängigkeiten?
> - Kennst du andere Programme, die so arbeiten? (Git ruft Editor und Pager auf, `make`, Shell-Pipes)

> [!note]- Erklärung für den Coach
> Die Unix-Philosophie in einem Satz: Programme sollen eine Sache gut machen und über Text zusammenarbeiten. Yazi ist dafür ein modernes Lehrbeispiel, weil es die Komposition **sichtbar** macht. Gleichzeitig zeigt es den Preis: Auf einem System ohne `fd` fehlt die Funktion. Gute Diskussion über Abhängigkeitsmanagement und darüber, warum Distributionen „optionale Abhängigkeiten" kennen.

---

## Station 4 – Konfiguration als Text

**Auslöser:** „Ich möchte versteckte Dateien immer sehen" oder „Ich brauche ständig meinen Downloads-Ordner."

**Übung:** Konfigurationsverzeichnis anlegen und ansehen:

```bash
mkdir -p ~/.config/yazi
ls ~/.config/yazi
```

`~/.config/yazi/yazi.toml`:

```toml
[mgr]
show_hidden = true
```

`~/.config/yazi/keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = [ "g", "d" ]
run  = "cd ~/Downloads"
desc = "Zu Downloads wechseln"
```

Yazi neu starten und testen.

> [!question] Leitfragen
> - Wie würdest du diese Einstellungen auf einen neuen Rechner bringen?
> - Was wäre, wenn du alle deine Programmeinstellungen in einem Git-Repository hättest?
> - Warum liegt das unter `~/.config`?

> [!note]- Erklärung für den Coach
> Anknüpfungspunkte: XDG Base Directory Specification (`~/.config`, `~/.local/share`, `~/.cache`), Dotfiles-Repositories, GNU Stow oder chezmoi, „Infrastructure as Code" im Kleinen. In der Ausbildung wird die Arbeitsumgebung meist als etwas behandelt, das man einmal zusammenklickt. Die Idee einer reproduzierbaren, versionierten Arbeitsumgebung ist für beide Fachrichtungen wertvoll.

---

## Station 5 – Eingebettete Skriptsprache

**Auslöser:** „Kann Yazi auch X?" Antwort: „Wenn nicht, kann man es ihm beibringen."

**Übung:**

1. Das offizielle Plugin-Repository ansehen: https://github.com/yazi-rs/plugins
2. Ein Plugin auswählen (z. B. `git.yazi`) und dessen `main.lua` gemeinsam lesen, ohne den Anspruch, alles zu verstehen.
3. Optional installieren mit dem Begleitwerkzeug `ya`:

```bash
ya pkg add yazi-rs/plugins:git
```

> [!warning] Befehl prüfen
> Der Paketbefehl hat sich in der Vergangenheit geändert. Vorher in der Plugin-Doku der installierten Version nachsehen.

> [!question] Leitfragen
> - Warum Lua und nicht Rust für Plugins?
> - Wo hast du schon Programme gesehen, die eine Skriptsprache mitbringen?

> [!note]- Erklärung für den Coach
> Muster: Ein Programm in einer kompilierten Sprache bietet eine kleine, sichere, schnell ladbare Skriptsprache für Erweiterungen an. Nutzer müssen nichts kompilieren, der Kern bleibt stabil. Lua ist dafür der Klassiker: Neovim, Redis (`EVAL`), OpenResty/nginx, Wireshark-Dissektoren, viele Spiele (z. B. Addons in World of Warcraft). Weitere Beispiele mit anderen Sprachen: Python in Blender und GIMP, JavaScript in Browsern und Office-Paketen, VBA in Excel.

---

## Station 6 – Das Terminal ist mehr als Text

**Auslöser:** Bildvorschau in `bilder/` funktioniert in einem Terminal, im anderen nicht (oder nur als Blockgrafik).

**Übung 1 – Vergleich:** Yazi in zwei Terminals öffnen, z. B. Kitty oder Ghostty und xterm.

```bash
echo $TERM
echo $TERM_PROGRAM
```

**Übung 2 – Escape-Sequenzen selbst schreiben:**

```bash
printf '\e[1;31mRot und fett\e[0m\n'
printf '\e]52;c;%s\a' "$(printf 'Hallo aus dem Terminal' | base64)"
```

Die zweite Zeile legt Text in die **lokale** Zwischenablage, sofern das Terminal OSC 52 unterstützt, und das funktioniert auch innerhalb einer SSH-Sitzung. In Yazi kopiert `c` ⇒ `c` den Dateipfad auf dieselbe Weise.

> [!question] Leitfragen
> - Wer zeichnet eigentlich die Buchstaben auf den Bildschirm: die Shell oder das Terminal?
> - Was passiert zwischen Tastendruck und Anzeige?
> - Wie kann ein Programm auf einem entfernten Server ein Bild auf meinem Bildschirm anzeigen?

> [!note]- Erklärung für den Coach
> Schichtenmodell: **Terminalemulator** (zeichnet, wertet Escape-Sequenzen aus) → **Pseudo-Terminal (PTY)** → **Shell** (interpretiert Befehle) → **Programm**. Die Shell zeichnet nichts, sie schreibt nur Text und Steuersequenzen in einen Datenstrom. Bilder kommen über Grafikprotokolle (Kitty Graphics Protocol, Sixel) in diesen Strom. Deshalb funktioniert die Vorschau auch über SSH, wenn das lokale Terminal das Protokoll beherrscht. Fehlt die Unterstützung, weicht Yazi auf Hilfsprogramme oder Zeichengrafik aus.
>
> Die Verwechslung „Terminal = Shell = Konsole" ist weit verbreitet und erschwert später die Fehlersuche (falsche Farben, kaputte Tastenkombinationen, Probleme in tmux).

---

## Station 7 – Open-Source-Realität und Werkzeugbewertung

**Auslöser:** „Sollte ich das bei einem Kunden einsetzen?"

**Übung:** Gemeinsam das GitHub-Repository und die Dokumentation untersuchen und eine kleine Bewertung ausfüllen.

| Kriterium | Beobachtung bei Yazi | Bedeutung |
|---|---|---|
| Lizenz | | Darf ich es einsetzen und verändern? |
| Versionierung | | Was sagt das Versionsschema aus? |
| Changelog / Breaking Changes | | Wie viel Pflegeaufwand entsteht bei Updates? |
| Anzahl aktiver Maintainer | | Bus-Faktor |
| Paketierung in Distributionen | | Wie komme ich auf Servern daran? |
| Dokumentation | | Ist sie versioniert und aktuell? |
| Alternative | Midnight Commander | Was ist überall verfügbar? |

> [!question] Leitfragen
> - Für deinen eigenen Arbeitsplatz: ja oder nein? Für einen Kundenserver?
> - Was passiert, wenn der Hauptentwickler morgen aufhört?
> - Woran erkennst du ein gesundes Projekt?

> [!note]- Erklärung für den Coach
> Ziel ist nicht ein Urteil über Yazi, sondern ein Bewertungsschema, das die Person auf jedes Werkzeug anwenden kann. In der Ausbildung lernt man Werkzeuge zu benutzen, aber selten, sie auszuwählen. Gerade im Betrieb ist die Frage „Was holen wir uns da ins Haus?" wichtiger als die Bedienung.

---

## Abschluss (ca. 10 Minuten)

> [!question] Reflexion
> - Welches Konzept war neu für dich?
> - Wo wirst du ihm in den nächsten Wochen wiederbegegnen?
> - Was würdest du einem anderen Azubi in zwei Sätzen darüber erzählen?

Die Person formuliert für jede bearbeitete Station einen Satz in eigenen Worten. Diese Sätze sind das eigentliche Ergebnis der Sitzung.

---

## Optionale Vertiefungen

- **Shell-Befehle auf Auswahl:** Mehrere Logdateien markieren, mit `:` einen blockierenden Befehl absetzen, z. B. `wc -l "$@"`. Zeigt, dass der Dateimanager nur eine Oberfläche über bekannten Befehlen ist. (Platzhalter für die Auswahl in der Doku der installierten Version prüfen.)
- **Yazi als Dateiauswahl im Editor:** Einbindung in Helix oder Neovim, interessant für Anwendungsentwickler.
- **Vergleich mit `mc`:** Dieselbe Aufgabe in Midnight Commander lösen und Unterschiede benennen.
- **Signale:** Yazi mit `Strg+Z` anhalten, in der Shell `jobs` und `fg`. Verbindung zu Station 1 und 2.

---

## Spickzettel Yazi

| Taste | Aktion |
|---|---|
| `h` `j` `k` `l` / Pfeiltasten | Navigation |
| `g` ⇒ `g` / `G` | Anfang / Ende der Liste |
| `Enter` / `o` | Öffnen |
| `Leertaste` | Auswahl umschalten |
| `v` | Visueller Modus (Bereich auswählen) |
| `y` / `x` / `p` | Kopieren / Ausschneiden / Einfügen |
| `d` / `D` | In den Papierkorb / endgültig löschen |
| `a` | Anlegen (mit `/` am Ende: Verzeichnis) |
| `r` | Umbenennen |
| `.` | Versteckte Dateien ein/aus |
| `f` | Filtern |
| `/` `?` `n` `N` | Im Verzeichnis finden |
| `s` / `S` | Suche nach Name (fd) / Inhalt (ripgrep) |
| `z` / `Z` | Springen per fzf / zoxide |
| `Tab` | Dateiinformationen |
| `c` ⇒ `c` | Dateipfad kopieren |
| `;` / `:` | Shell-Befehl / Shell-Befehl blockierend |
| `t` ⇒ `t`, `1`–`9` | Neuer Tab, Tab wechseln |
| `w` | Taskmanager |
| `F1` oder `~` | Hilfe |
| `q` / `Q` | Beenden mit / ohne Verzeichniswechsel (Wrapper) |

---

## Quellen

- Offizielle Dokumentation: https://yazi-rs.github.io
- Quick Start mit Shell-Wrappern für alle Shells: https://yazi-rs.github.io/docs/quick-start
- Repository: https://github.com/sxyazi/yazi
- Plugins: https://github.com/yazi-rs/plugins
- Vollständige Standardbelegung: `keymap-default.toml` im Repository

---

## Verwandt

- [[01-Installation und Plugins]] – Installation mit brew, Hilfsprogramme, Plugin-System
- [[02-Leitfaden zum Spickzettel]] – Bedienung Block für Block, mit Grafiken
- [[03-kommentierter Leitfaden]] – Bedienung und Konfiguration im Detail
- [[yazi-spickzettel.pdf]] – zweiseitiger Spickzettel zum Austeilen
