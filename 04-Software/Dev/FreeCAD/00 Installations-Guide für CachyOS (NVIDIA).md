Dieser Leitfaden optimiert die Installation von FreeCAD auf CachyOS unter Berücksichtigung der NVIDIA-Hardwarebeschleunigung und behebt typische Grafikfehler unter Wayland.

## 1. System-Vorbereitung & Treiber

CachyOS bietet optimierte Kernel. Stelle sicher, dass die proprietären NVIDIA-Treiber korrekt eingebunden sind.

Bash

```
# Spiegelserver aktualisieren für maximale Download-Rate
sudo cachyos-rate-mirrors

# NVIDIA-Treiber sicherstellen
sudo chwd -a pci nonfree 0300

# Video-Hardwarebeschleunigung (VA-API) für NVIDIA nachinstallieren
# Entlastet die CPU bei Video-Wiedergabe und System-Animationen
sudo pacman -S libva-nvidia-driver
```

---

## 2. Installation von FreeCAD

Um Versionskonflikte zu vermeiden, empfiehlt sich die Installation über die offiziellen Repositories bei gleichzeitiger Aktualisierung der Abhängigkeiten (behebt den `404 - Not Found` Fehler).

Bash

```
# Datenbanken auffrischen und FreeCAD installieren
sudo pacman -Syu freecad
```

---

## 3. Fehlerbehebung: Weißer/Transparenter Bildschirm

Unter **Wayland** (Standard in CachyOS/KDE) haben NVIDIA-Karten oft Probleme mit der OpenGL-Darstellung von FreeCAD. Die Lösung ist das Erzwingen des X11-Kompatibilitätsmodus.

### Test im Terminal:

Bash

```
QT_QPA_PLATFORM=xcb freecad
```

### Dauerhafte Lösung (Starter anpassen):

1. Rechtsklick auf das **FreeCAD-Icon** im Startmenü -> **Anwendung bearbeiten**.
    
2. Im Reiter **Programm** das Feld **Befehl** ändern auf:
    
    `env QT_QPA_PLATFORM=xcb freecad %f`
    
3. Speichern.
    

---

## 4. Performance-Tuning (NVIDIA Turbo)

Sobald FreeCAD startet, müssen die internen Einstellungen für die GPU optimiert werden:

|**Einstellung**|**Pfad**|**Wert**|**Grund**|
|---|---|---|---|
|**VBO verwenden**|Bearbeiten -> Einstellungen -> Anzeige -> 3D-Ansicht|**AN**|Speichert Geometrie im Grafikspeicher (massiver Speedup).|
|**Antialiasing**|Bearbeiten -> Einstellungen -> Anzeige -> 3D-Ansicht|**4x oder 8x**|Glättet Kanten ohne große Last für moderne NVIDIA-Karten.|
|**Transparenz**|Bearbeiten -> Einstellungen -> Anzeige -> 3D-Ansicht|**Scharf**|Verhindert Grafikfehler beim Rendern von überlappenden Teilen.|

---

## 5. Checkliste bei Problemen

> **Problem:** Paket `shiboken6` oder andere werden nicht gefunden (404).
> 
> **Lösung:** `sudo pacman -Syyu` (Erzwingt das Neuladen der Paketlisten).

> **Problem:** FreeCAD friert im Vollbildmodus ein.
> 
> **Lösung:** Sicherstellen, dass `QT_QPA_PLATFORM=xcb` wie in Schritt 3 beschrieben gesetzt ist.

---

**Viel Erfolg beim Konstruieren!** Möchtest du noch wissen, wie du die 3D-Maus (z.B. SpaceMouse) unter CachyOS für FreeCAD einrichtest?