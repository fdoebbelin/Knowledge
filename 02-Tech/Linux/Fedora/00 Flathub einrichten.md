- **system-weit** (`--system`, Standard mit `sudo`) 
- **pro Benutzer** (`--user`). 

Beides ist auf Sway Atomic gleichermaßen möglich, weil Flatpak grundsätzlich nichts am ostree-Root anfasst:

```bash
# system-weit
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# oder pro Benutzer
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

**System-weit** (`/var/lib/flatpak`)

Vorteile: Runtimes werden einmal vorgehalten und von allen Konten geteilt — bei mehreren Schulungsaccounts auf einer Kiste spart das schnell mehrere GB. Die Einrichtung lässt sich im Image bzw. per systemd-Unit beim ersten Boot erledigen, du hast also einen definierten Auslieferungszustand. Desktop-Einträge landen unter `/var/lib/flatpak/exports/share`, das steht in jeder Session zuverlässig in `XDG_DATA_DIRS`. Und: Installieren erfordert Rechte, Kursteilnehmer können sich also nicht beliebig etwas dazuholen.

Nachteile: Es gibt nur eine Version pro App für alle. Beim Neuaufsetzen der Maschine ist alles weg, weil `/var` nicht mitwandert (bei Rebase/`bootc switch` bleibt es dagegen erhalten). Der vorinstallierte `fedora`-Remote liegt parallel daneben — gleiche App-IDs aus zwei Quellen, `flatpak install firefox` fragt dann nach. In der Praxis deaktiviert man den entweder (`sudo flatpak remote-modify --disable fedora`) oder filtert ihn.

**Pro Benutzer** (`~/.local/share/flatpak`)

Vorteile: kein root nötig, und alles hängt am Home. Wenn Home separat liegt oder gesichert wird, überlebt die komplette App-Landschaft auch ein plattgemachtes System oder einen Wechsel auf eine andere Distribution. Jeder Nutzer hat eigene Versionen, eigene Overrides und eigene Berechtigungen — praktisch, wenn du in einem Kurs mal absichtlich eine kaputte Sandbox-Konfiguration vorführst.

Nachteile: Runtimes werden pro Konto dupliziert. Vorinstallieren im Image geht nicht, du brauchst pro Account ein Skript oder eine User-Unit. Und der Sway-spezifische Stolperstein: Damit die Apps in Wofi/Rofi/Fuzzel auftauchen, muss `~/.local/share` in `XDG_DATA_DIRS` stehen. Über `systemd --user` bzw. uwsm passt das normalerweise, bei einem handgestrickten `exec sway` aus der TTY heraus aber gerne mal nicht.

**Für deine Schulungsflotte** würde ich system-weit im Image nehmen und den Fedora-Remote gleich mit deaktivieren — reproduzierbarer Zustand, geteilte Runtimes, und das Ganze passt sauber in den bootc-Buildprozess. Auf dem eigenen Arbeitsgerät ist `--user` das entspanntere Modell, weil es die Trennung zwischen unveränderlichem Image und eigenen Daten konsequent durchzieht.

Falls du eigentlich die andere Unterscheidung meintest — gefilterter Flathub über die Drittanbieter-Repos gegen den vollen Remote von Hand — sag Bescheid; auf Sway Atomic ist die aber weniger relevant, weil ohne GNOME Software der Umweg über den Toggle ohnehin entfällt.