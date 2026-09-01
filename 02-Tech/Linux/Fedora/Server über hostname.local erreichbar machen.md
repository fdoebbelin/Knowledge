**mDNS / Avahi (der „richtige" Weg für `.local`)** Die Endung `.local` ist per RFC 6762 für **Multicast DNS** reserviert. Das heißt: Ein Rechner kann seinen Namen selbst im lokalen Netz announcen, ohne dass du irgendwo eine IP einträgst. Auf dem macmini installierst du dazu Avahi:

bash

```bash
sudo apt install avahi-daemon -y
sudo hostnamectl set-hostname macmini   # falls noch nicht gesetzt
```

Danach ist der Server automatisch als `macmini.local` erreichbar — und zwar **mit seiner jeweils aktuellen IP**. Der große Vorteil: Das folgt DHCP-Änderungen von allein, du brauchst dafür also nicht einmal eine feste IP (das verbindet sich mit deiner früheren DHCP-Frage). Auf der Client-Seite funktioniert das je nach System unterschiedlich gut out of the box: macOS (Bonjour) und Windows 10/11 (nativer mDNS-Resolver) können `.local` direkt auflösen. Auf Linux-Clients brauchst du ggf. `sudo apt install libnss-mdns` (oder ebenfalls `avahi-daemon`), damit der Name-Service-Switch `.local`-Namen über mDNS auflöst.