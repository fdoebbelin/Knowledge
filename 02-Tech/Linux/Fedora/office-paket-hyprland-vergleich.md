---
title: Office-Paket für Hyprland – Vergleich & LibreOffice-Installation
tags: [fedora, office, libreoffice, calligra, onlyoffice, hyprland, wayland, vergleich]
created: 2026-07-06
system: Fedora 44
status: draft
---

# Office-Paket für Hyprland – Vergleich & LibreOffice-Installation

> [!info] Fazit vorweg
> Für dieses Setup (Fedora 44 · Hyprland/wlroots · qt6ct+Kvantum · Supply-Chain-/Reproduzierbarkeitsfokus) ist **LibreOffice mit dem KF6-VCL-Plugin** der beste Allround-Fit. **Calligra** ist die Wahl für maximal KDE-native Integration ohne hohen MS-Office-Bedarf. **OnlyOffice** lohnt nur noch, wenn beste `.docx`/`.xlsx`-Treue zu MS-Office-Nutzern das oberste Kriterium ist.

## Vergleich

| Kriterium | OnlyOffice | LibreOffice (KF6-VCL) | Calligra |
|---|---|---|---|
| Natives Wayland | **nein** (nur XWayland) | ja (`kf6 cairo+wayland`) | ja (KF-nativ) |
| Fedora-Repo / nativer RPM | nein (Drittanbieter, el7/suse) | **ja, offiziell** | ja, offiziell |
| Qt/Kvantum-Theming | teils (eigene UI) | ja (Qt6/KF6-VCL) | **voll (KF-nativ)** |
| KDE-Dateidialog (Portal) | über XWayland | ja | ja |
| MS-Office-Formattreue | **★★★** | ★★ | ★ |
| Umfang/Reife | ★★★ | **★★★** | ★★ |
| aarch64 (XPS 9345) | Flatpak/3rd-party | **Fedora-Repo** | Fedora-Repo |
| Fraktionale Skalierung | XWayland-Unschärfe | Caveats (s. u.), aber Hebel vorhanden | überwiegend ok |

## Warum LibreOffice hier besser passt als OnlyOffice

- **Fedora-nativ:** aus dem offiziellen Repo → reproduzierbar, GPG-signiert im Fedora-Vertrauensraum, keine el7/suse-Abhängigkeitsbrüche (kein `dejavu-fonts`-Problem).
- **Wayland ist überhaupt möglich:** OnlyOffice kann prinzipiell nicht nach Wayland; LibreOffice läuft mit KF6-VCL nativ (`cairo+wayland`).
- **Theming greift:** Der KF6/Qt6-VCL nutzt deine qt6ct/Kvantum-Konfiguration und den KDE-Dateidialog via `xdg-desktop-portal-kde`.
- **aarch64:** direkt aus dem Fedora-Repo installierbar, kein Fork-/Drittanbieter-Umweg.

> [!warning] Betrifft dieses Setup: Skalierung 1,50 ist fraktional
> Der Monitor läuft mit `scale: 1.50` – also **fraktional**. Damit ist der bekannte, weiter offene KF6-Bug (Symbolleisten zu groß, LO-Bug 160268; verwandt 141578) ein **reales Risiko** und kein Randfall. Ob er in der LibreOffice-Version von Fedora 44 noch auftritt, entscheidet der Test unten in Sekunden. Falls ja: echte Ausweichhebel vorhanden (anders als bei OnlyOffice) – der **gtk3-Backend** ist der zuverlässige Plan B bei 1,5. Siehe [Backend-Entscheidung](#kf6-vcl--wayland-erzwingen).

## Installation (LibreOffice)

Nur die benötigten Module + KF6-Integration installieren (schlanker als das `libreoffice`-Meta):

```nu
sudo dnf install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-kf6
```

Metrisch kompatible FOSS-Schriften für Dokumenttreue (Calibri→Carlito, Cambria→Caladea; Liberation ist meist schon da):

```nu
sudo dnf install google-carlito-fonts google-caladea-fonts liberation-fonts
fc-cache -f
```

## KF6-VCL / Wayland erzwingen

Bei Skalierung 1,50 gilt dieser Entscheidungsfluss (in Nushell wird die Variable mit `with-env` gesetzt, nicht per `VAR=wert cmd`):

**Schritt 1 – KF6 testen** (beste Schrift + Kvantum-Theming + KDE-Dateidialog):

```nu
with-env { SAL_USE_VCLPLUGIN: kf6 } { libreoffice --writer }
```

Jetzt die **Symbolleisten** ansehen: normal proportioniert → KF6 behalten. Deutlich zu groß (der 160268-Bug) → **Schritt 2**.

**Schritt 2 – gtk3 als Plan B** (Skalierung/Dialoge bei 1,5 zuverlässig, Schrift minimal weniger scharf als KF6):

```nu
with-env { SAL_USE_VCLPLUGIN: gtk3 } { libreoffice --writer }
```

Das gewählte Backend anschließend dauerhaft setzen. Nur LibreOffice liest `SAL_USE_VCLPLUGIN`, ein globales Setzen ist also unkritisch.

Im Folgenden `kf6` durch `gtk3` ersetzen, falls in Schritt 2 gewählt.

> [!warning] Hyprland-`env` in Lua-Syntax validieren
> hyprlang-Form (**nicht** in die Lua-Config mischen):
> ```ini
> env = SAL_USE_VCLPLUGIN,kf6
> ```
> Wahrscheinliche Lua-Entsprechung – gegen die bestehende `hyprland.lua`-Struktur und via lua-language-server prüfen:
> ```lua
> env = {
>     "SAL_USE_VCLPLUGIN,kf6",
> }
> ```
> Danach `hyprctl reload` bzw. Session neu starten.

Alternative ohne Lua-Eingriff (pro Modul, dafür kein globaler Env):

```nu
mkdir ~/.local/share/applications
cp /usr/share/applications/libreoffice-writer.desktop ~/.local/share/applications/

open --raw ~/.local/share/applications/libreoffice-writer.desktop
| str replace "Exec=libreoffice" "Exec=env SAL_USE_VCLPLUGIN=kf6 libreoffice"
| save --force ~/.local/share/applications/libreoffice-writer.desktop
```

(Analog für `libreoffice-calc.desktop`, `libreoffice-impress.desktop`.)

## Verifizieren

In LibreOffice: **Hilfe → Über LibreOffice**. Bei korrektem Backend steht dort sinngemäß:

```
VCL: kf6 (cairo+wayland)
```

`cairo+wayland` = nativer Wayland-Renderer. Steht dort `cairo+xcb`, läuft es noch über XWayland.

## Letzte Ausweichoption (nur falls KF6 **und** gtk3 nicht überzeugen)

Als letztes Mittel XWayland erzwingen – konsistente Skalierung, aber **kein** natives Wayland mehr (Schrift kann bei 1,5 leicht unscharf werden, wie bei OnlyOffice):

```nu
with-env { SAL_USE_VCLPLUGIN: kf6, QT_QPA_PLATFORM: xcb } { libreoffice --writer }
```

In der Praxis ist das bei 1,5 selten nötig – der gtk3-Backend nativ deckt den Fall meist ab.

## Alternative: Calligra (maximal KDE-nativ)

KF-native Suite (Words/Sheets/Stage) – Wayland und Kvantum-Theming greifen ohne Zusatzkonfiguration; dafür schwächere MS-Office-Formattreue.

```nu
sudo dnf install calligra
```

## Aufgaben

- [ ] Entscheidung: LibreOffice (Allround) vs. Calligra (KDE-nativ) vs. OnlyOffice behalten (MS-Treue)
- [ ] LibreOffice-Module + `libreoffice-kf6` installieren
- [ ] FOSS-Schriften installieren, `fc-cache -f`
- [ ] Schritt 1: KF6 starten und Symbolleisten bei Skalierung 1,5 prüfen
- [ ] Falls Symbolleisten zu groß: Schritt 2 auf gtk3 wechseln
- [ ] Gewähltes Backend dauerhaft setzen (Hyprland-`env` oder `.desktop`)
- [ ] In „Über LibreOffice" Renderer prüfen (`cairo+wayland` = nativ)
- [ ] aarch64 (XPS 9345): gleiche Installation aus Fedora-Repo verifizieren

## Verwandte Notizen

- [[OnlyOffice installieren]]
- [[OnlyOffice – Schriftdarstellung verbessern]]
- [[Hyprland Lua-Konfiguration]]  <!-- ggf. Dateinamen anpassen -->
- [[Qt-Kvantum-Theming einrichten]]  <!-- ggf. Dateinamen anpassen -->
