---
title: systemd-User-Timer für git fetch
tags:
  - linux
  - systemd
  - git
  - shell
created: 2026-09-10
---
## Ziel

Ein User-Timer holt in festen Abständen im Hintergrund den Stand eines Repos vom Server. Dadurch sind die Remote-Tracking-Refs (`origin/main` &c.) aktuell, und `git status` bzw. der Starship-Prompt können ohne Netzwerkzugriff anzeigen, wie viele Commits man vorne oder hinten liegt.

> [!info] Warum überhaupt?
> `git status` geht **nie** ins Netz. Es vergleicht nur mit dem lokal gespeicherten Zustand des Remotes. Ohne Fetch meldet es „up to date", obwohl auf dem Server längst neue Commits liegen. Der Timer schließt genau diese Lücke.

Zwei Vorteile gegenüber einem Prompt-Hook: der Prompt kann nie blockieren, und der Fetch läuft auch dann, wenn gerade kein Terminal in dem Repo offen ist.

---

## Das Konzept: Template-Units

Statt für jedes Repo ein eigenes Unit-Paar anzulegen, nutzen wir **Template-Units**. Ein Dateiname mit `@` vor der Endung macht ein Unit zur Vorlage; der Teil zwischen `@` und `.service` ist der *Instanzname*.

Der Trick: wir schieben den Repo-Pfad als Instanzname hinein. Dafür braucht es `systemd-escape`, denn Slashes sind in Unit-Namen nicht erlaubt:

```bash
systemd-escape --path /home/fr/src/schulungsflotte
# → home-fr-src-schulungsflotte
```

Im Unit holt der Specifier `%I` daraus wieder den ursprünglichen Pfad. (Merkhilfe: kleines `%i` = escaped, großes `%I` = entschärft/lesbar.)

---

## Die Service-Unit

`~/.config/systemd/user/git-fetch@.service`

```ini
[Unit]
Description=git fetch für %I
Documentation=man:git-fetch(1)

# Läuft das Unit ins Leere, weil das Repo verschoben oder gelöscht wurde,
# wird es sauber übersprungen statt als "failed" im Journal zu landen.
# ConditionPathExists (nicht ...IsDirectory), weil .git bei Worktrees
# und Submodulen eine Datei ist, kein Verzeichnis.
ConditionPathExists=%I/.git

[Service]
# oneshot = läuft, macht seine Arbeit, ist fertig. Kein Daemon.
Type=oneshot

# Der Pfad kommt aus dem Instanznamen. Damit braucht git kein -C.
WorkingDirectory=%I

# Absoluter Pfad ist in ExecStart Pflicht — systemd hat kein $PATH-Rätselraten.
ExecStart=/usr/bin/git fetch --prune --quiet

# Ohne das hängt der Job stumm an einer Passwortabfrage, falls ein Remote
# per HTTPS eingebunden ist und keine Credentials gecacht sind.
Environment=GIT_TERMINAL_PROMPT=0

# Nach einer Minute abbrechen. Verhindert, dass ein hängender Fetch
# den nächsten Timer-Durchlauf blockiert.
TimeoutStartSec=60

# Hintergrundarbeit soll interaktives Arbeiten nicht ausbremsen.
Nice=10
IOSchedulingClass=idle
```

> [!warning] SSH-Remotes brauchen den Agent-Socket
> Ein Timer läuft außerhalb deiner Shell und kennt `SSH_AUTH_SOCK` nicht. Bei per SSH eingebundenen Remotes mit passphrase-geschütztem Key scheitert der Fetch deshalb still. Abhilfe, je nach Setup:
> ```ini
> Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
> ```
> `%t` ist `$XDG_RUNTIME_DIR`, also üblicherweise `/run/user/1000`. Der Pfad muss zu dem passen, was dein Agent tatsächlich anlegt (`echo $SSH_AUTH_SOCK` in der Shell verrät ihn). Alternativ einen dedizierten Deploy-Key ohne Passphrase verwenden.

---

## Die Timer-Unit

`~/.config/systemd/user/git-fetch@.timer`

```ini
[Unit]
Description=Alle 15 Minuten git fetch für %I

[Timer]
# Kalender-Ausdruck: zur Minute 0, 15, 30, 45 jeder Stunde.
# Prüfen lässt sich so ein Ausdruck mit: systemd-analyze calendar '*:0/15'
OnCalendar=*:0/15

# Bis zu 2 Minuten Zufallsversatz. Bei vielen Repo-Instanzen laufen
# sonst alle Fetches gleichzeitig los.
RandomizedDelaySec=2m

# Verpasste Durchläufe (Rechner war aus/suspendiert) einmalig nachholen.
# Wirkt NUR zusammen mit OnCalendar, nicht mit OnUnitActiveSec.
Persistent=true

[Install]
WantedBy=timers.target
```

Ein Timer-Template zieht automatisch den Service mit demselben Instanznamen. `Unit=git-fetch@%i.service` ist also implizit und muss nicht hingeschrieben werden.

> [!tip] Alternative Taktung
> `OnUnitActiveSec=15min` in Kombination mit `OnBootSec=2min` taktet relativ zum letzten Lauf statt zur Uhrzeit. Das ist schonender, wenn der Rechner unregelmäßig läuft — dann greift allerdings `Persistent=` nicht.

---

## Aktivieren

```bash
# Nach jedem Anlegen oder Ändern einer Unit-Datei:
systemctl --user daemon-reload

# Timer für ein konkretes Repo scharf schalten:
systemctl --user enable --now "git-fetch@$(systemd-escape --path ~/src/schulungsflotte).timer"
```

`enable` sorgt für Start beim Login, `--now` startet zusätzlich sofort.

Für Nushell eine kleine Hilfsfunktion, die das für das *aktuelle* Repo übernimmt — inklusive Sprung zum Repo-Wurzelverzeichnis, damit es auch aus einem Unterordner heraus funktioniert:

```nushell
# Timer für das Repo im aktuellen Verzeichnis einschalten
def git-timer-on [] {
    let r = (do -i { ^git rev-parse --show-toplevel } | complete)
    if $r.exit_code != 0 {
        error make { msg: "kein Git-Repository" }
    }
    let inst = (^systemd-escape --path ($r.stdout | str trim) | str trim)
    ^systemctl --user enable --now $"git-fetch@($inst).timer"
    print $"Timer aktiv: git-fetch@($inst)"
}

# ... und wieder aus
def git-timer-off [] {
    let root = (^git rev-parse --show-toplevel | str trim)
    let inst = (^systemd-escape --path $root | str trim)
    ^systemctl --user disable --now $"git-fetch@($inst).timer"
}
```

> [!warning] Ohne Login-Session kein Timer
> User-Units laufen normalerweise nur, solange eine Session offen ist. Damit die Timer unabhängig davon ticken:
> ```bash
> loginctl enable-linger $USER
> ```

---

## Kontrollieren

```bash
# Wann lief was, wann läuft es das nächste Mal?
systemctl --user list-timers

# Status einer Instanz
systemctl --user status "git-fetch@$(systemd-escape --path ~/src/schulungsflotte).service"

# Log — hier landen auch die Fehlermeldungen von git
journalctl --user -u "git-fetch@$(systemd-escape --path ~/src/schulungsflotte).service" -n 20

# Einmal manuell auslösen, ohne auf den Timer zu warten
systemctl --user start "git-fetch@$(systemd-escape --path ~/src/schulungsflotte).service"
```

Der manuelle Start ist der schnellste Weg zum Debuggen: schlägt er fehl, steht der Grund direkt im Journal.

---

## Anzeige im Prompt

Damit die frischen Refs auch sichtbar werden, in `starship.toml`:

```toml
[git_status]
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
```

Ergebnis im Prompt z. B. `⇕⇡1⇣3` — ein eigener Commit lokal, drei neue auf dem Server.

Auf der Kommandozeile dasselbe zu Fuß:

```bash
git status -sb                    # ## main...origin/main [ahead 1, behind 3]
git log --oneline HEAD..@{u}      # welche Commits kämen rein
```

---

## Fallstricke

| Symptom | Ursache |
|---|---|
| Unit ist `activating` und läuft in den Timeout | Passphrase-Abfrage oder fehlender Agent-Socket |
| `status` zeigt „condition failed" | `%I` zeigt nicht auf das Repo — Escaping oder Pfad prüfen |
| Timer taucht nicht in `list-timers` auf | `daemon-reload` vergessen oder `[Install]`-Sektion fehlt |
| Timer läuft nur bei offenem Terminal | `enable-linger` fehlt |
| `git maintenance` reicht doch, oder? | Nein: dessen Prefetch schreibt absichtlich nach `refs/prefetch/*` und lässt die Remote-Tracking-Refs unangetastet, ahead/behind ändert sich also nicht. Nützlich bleibt es trotzdem — die Objekte liegen dann schon lokal und ein echtes `git fetch` ist fast instantan. |

`--prune` löscht lokale Remote-Tracking-Refs zu Branches, die auf dem Server verschwunden sind. Das ist gewollt, betrifft aber nur `refs/remotes/*` — eigene lokale Branches und der Arbeitsbaum bleiben in jedem Fall unberührt. Ein Fetch ist immer eine reine Leseoperation.

---

## Siehe auch

- [[Git]]
- [[Starship]]
- `man systemd.timer`, `man systemd.unit`, `man systemd.exec`
- `man systemd-escape`
