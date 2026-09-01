---
titel: Deckelkontakt – Suspend konfigurieren
tags: [hyprland, systemd, logind, power, lenovo-yoga, fedora]
erstellt: 2026-06-29
system: Fedora 44 / Hyprland
status: erledigt
---

# Deckelkontakt – Suspend konfigurieren

Unter einem nackten Hyprland gibt es keinen GNOME-/KDE-Power-Daemon. Für das Deckelverhalten ist direkt **systemd-logind** zuständig, also greifen die `HandleLidSwitch*`-Direktiven.

> [!info] Gilt für: Lenovo Yoga 920-13IKB
> Der Deckelkontakt ist ein magnetischer **Hall-Sensor** (kein mechanischer Schalter). Der Kernel meldet ihn als ACPI-Lid-Button bzw. als Input-Switch `SW_LID`.

## 1 – Deckelkontakt erkennen

```nu
# Existiert der Lid-Button überhaupt?
ls /proc/acpi/button/lid/
```

```nu
# Aktueller Zustand (open / closed)
ls /proc/acpi/button/lid/*/state | get name | each { |f| open --raw $f | str trim }
```

```nu
# Als Input-Switch sichtbar? (zeigt die "Lid Switch"-Zeile)
open --raw /proc/bus/input/devices | lines | where ($it | str contains --ignore-case "lid")
```

> [!check] Erfolgskriterium
> Erste Abfrage liefert ein Verzeichnis (z. B. `LID0`), dritte Abfrage zeigt eine `Name="Lid Switch"`-Zeile → Kontakt sauber erkannt.

## 2 – Konfigurieren (Drop-in)

Empfohlen über ein Drop-in, nicht durch direktes Editieren der `logind.conf`:

```nu
sudo mkdir -p /etc/systemd/logind.conf.d
```

```nu
"[Login]
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
" | sudo tee /etc/systemd/logind.conf.d/10-deckel.conf
```

```nu
sudo systemctl restart systemd-logind
```

> [!warning] Neustart von logind
> In den meisten aktuellen systemd-Versionen bleibt die laufende Grafiksitzung erhalten. In Einzelfällen kann es zum Logout kommen. Wer auf Nummer sicher gehen will, übernimmt die Einstellung erst beim nächsten Reboot.

Mögliche Werte für `HandleLidSwitch`: `ignore`, `poweroff`, `reboot`, `halt`, `suspend`, `hibernate`, `hybrid-sleep`, `suspend-then-hibernate`, `lock`.

## 3 – Wirksamkeit prüfen

```nu
# Effektive Konfiguration nach Zusammenführen aller Drop-ins
systemd-analyze cat-config systemd/logind.conf | lines | where ($it | str contains "LidSwitch")
```

Erwartete Ausgabe: die drei oben gesetzten `HandleLidSwitch*`-Zeilen.

## 4 – Yoga-Stolperstein: Tablet-Modus

Klappt man das Yoga in den Tablet-Modus, liegt der Bildschirm physisch auf der Rückseite — der Hall-Sensor meldet dann „closed". Ohne Gegenmaßnahme würde das Gerät im Tablet-Modus suspendieren.

```nu
# Existiert ein "Tablet Mode Switch"?
open --raw /proc/bus/input/devices | lines | where ($it | str contains --ignore-case "tablet")
```

> [!tip] Maskierung
> Aktuelle Kernel maskieren `SW_LID` automatisch, sobald `SW_TABLET_MODE` aktiv ist (über `intel-vbtn`). Erscheint oben ein „Tablet Mode Switch", ist die Maskierung in der Regel aktiv. `iio-sensor-proxy` ist hierfür **nicht** zuständig — der macht nur die Bildschirmrotation (siehe [[iio-sensor-proxy einrichten]]).

## 5 – Schlafzustand prüfen (relevant für Akku-Drain)

```nu
# Welcher Sleep-Modus ist aktiv? [deep] = S3, geringer Verbrauch
open --raw /sys/power/mem_sleep | str trim
```

> [!note] Bedeutung
> Steht `deep` in eckigen Klammern, nutzt das Gerät echtes **S3** → sehr geringer Verbrauch im Suspend, über Nacht unkritisch. Nur `s2idle` verfügbar → höherer Verbrauch, dann lohnt ein Blick auf [[Hibernate einrichten]].

## Verwandte Notizen

- [[Flip to Boot konfigurieren]] – Einschalten beim Aufklappen (auf dem 920 vermutlich nicht vorhanden)
- [[Hibernate einrichten]] – gezielter Ruhezustand, erfordert Disk-Swap (auf Fedora **nicht** ab Werk aktiv)
- [[Hyprland Konfiguration]]

## Erledigt

- [x] Deckelkontakt erkannt
- [x] Drop-in `10-deckel.conf` angelegt
- [x] Wirksamkeit geprüft
- [ ] Schlafzustand (`mem_sleep`) notiert
