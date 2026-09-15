## Container starten

### Alpine-Linux-Container starten und benennen
```bash
docker run -it --name alpine alpine sh
```
- **`docker run`**: Startet einen neuen Container.
- **`-it`**: Interaktiver Modus mit Terminal.
- **`--name alpine`**: Verleiht dem Container den Namen `alpine`.
- **`alpine`**: Das offizielle Alpine-Linux-Image.
- **`sh`**: Startet die Shell in Alpine.

---

## Container verwalten

### Gestoppten Container neu starten
```bash
docker start -ai alpine
```
- **`docker start`**: Startet einen gestoppten Container.
- **`-a`**: Attached Modus (zeigt die Ausgabe an).
- **`-i`**: Interaktiver Modus.

### Alle Container anzeigen
```bash
docker ps -a
```
- **`docker ps -a`**: Zeigt alle Container (laufend und gestoppt) an.

---

## Mit einem laufenden Container verbinden

### Verbindung zu einem laufenden Container herstellen
```bash
docker exec -it alpine sh
```
- **`docker exec`**: Führt einen Befehl in einem laufenden Container aus.
- **`-it`**: Interaktiver Modus mit Terminal.
- **`alpine`**: Name des Containers.
- **`sh`**: Startet die Shell in Alpine.

---

## Überprüfen, ob man in Alpine Linux ist

### Betriebssystem-Info anzeigen
```bash
cat /etc/os-release
```
- Zeigt die Betriebssystem-Informationen an. In Alpine siehst du `NAME="Alpine Linux"`.

### Kernel- und Systeminfo anzeigen
```bash
uname -a
```
- Zeigt Kernel-Informationen an.

### Alpine-spezifische Paketverwaltung prüfen
```bash
apk --version
```
- Zeigt die Version des Alpine-Paketmanagers `apk` an.

### Aktuelle Shell anzeigen
```bash
echo $SHELL
```
- Zeigt die aktuelle Shell an (standardmäßig `/bin/sh` in Alpine).