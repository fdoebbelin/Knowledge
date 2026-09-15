---
title: "ubuntu server"
source: "https://gemini.google.com/app/58c53f7c798358e8?hl=de"
author:
published:
created: 2026-06-09
description: "Gemini conversation with 22 messages"
tags:
  - "clippings"
---
**You**

wie heißt die weboberfläche zum administrieren von ubuntu server

---

**Gemini**

Für Ubuntu Server gibt es keine standardmäßig vorinstallierte Weboberfläche, aber die mit Abstand am häufigsten genutzte und offiziell unterstützte Lösung heißt **Cockpit**.

Hier sind die wichtigsten Details dazu:

### Cockpit (Der Quasi-Standard)

Cockpit ist eine leichtgewichtige, moderne und sehr stabile Weboberfläche, die direkt in den offiziellen Ubuntu-Paketquellen enthalten ist. Sie läuft über den Browser (standardmäßig auf Port `9090`) und ermöglicht es dir, den Server ohne tiefgehende Terminal-Kenntnisse zu verwalten.

- **Vorteile:** Sehr ressourcenschonend, nutzt die System-eigenen APIs (ändert also keine Konfigurationsdateien auf "magische" Weise), bietet ein integriertes Terminal, Leistungsüberwachung (CPU, RAM, Netzwerk), Festplattenverwaltung und Benutzeradministration.
- **Installation:** Ist mit einem einzigen Befehl erledigt:
	```
	sudo apt update && sudo apt install cockpit -y
	```
	Danach erreichst du sie unter `https://Deine-Server-IP:9090`.

### Alternativen (je nach Einsatzzweck)

Falls du spezielle Anforderungen hast, gibt es noch andere bekannte Oberflächen:

- **Webmin:** Der "Klassiker". Bietet extrem viele und detaillierte Einstellungsmöglichkeiten für fast jeden Systemdienst (Apache, BIND, SSH). Die Oberfläche wirkt im Vergleich zu Cockpit etwas überladen und altbacken, ist aber mächtig.
- **Ajenti:** Eine optisch modernere Alternative zu Webmin, die sich gut für das Verwalten von Webservern und kleineren Diensten eignet.
- **Portainer:** Wenn du Ubuntu Server primär nutzt, um Docker-Container zu betreiben, ist Portainer die absolut beste Weboberfläche, um diese Container, Images und Volumes grafisch zu verwalten.
- **Plesk / CyberPanel / aaPanel:** Falls du den Server als reinen Webhosting-Server (für Websites, E-Mail-Server, Datenbanken) betreiben willst.

Suchst du eine Oberfläche für die allgemeine Systempflege (wie Updates und Auslastung), ist **Cockpit** die beste Wahl.

---

**You**

wie kann ich den cockpit server starten

---

**Gemini**

Den Cockpit-Server startest du unter Ubuntu am saubersten über das System-Management-Tool `systemctl`. In der Regel nutzt Cockpit eine sogenannte „Socket-Activation“ – das bedeutet, der Dienst wird erst dann wirklich aktiv, wenn du die Weboberfläche im Browser aufrufst.

Hier sind die Befehle für dein Terminal:

### 1\. Dienst starten und aktivieren

Damit Cockpit sofort läuft und auch nach einem Neustart des Servers automatisch mit startet, nutzt du diesen kombinierten Befehl:

```
sudo systemctl enable --now cockpit.socket
```

- `enable`: Sorgt für den automatischen Start nach einem Reboot.
- `--now`: Startet den Dienst sofort im aktuellen Betrieb.

### 2\. Status überprüfen

Um sicherzugehen, dass alles korrekt läuft, kannst du den Status abfragen:

```
sudo systemctl status cockpit.socket
```

Hier sollte im Idealfall `active (listening)` stehen.

### 3\. Firewall freischalten (Wichtig!)

Falls du die Ubuntu-Firewall (`ufw`) aktiv hast, musst du den Port `9090` explizit erlauben, da du sonst keine Verbindung bekommst:

```
sudo ufw allow 9090/tcp
```

### 4\. Zugriff über den Browser

Sobald der Dienst läuft, erreichst du die Oberfläche auf deinem PC/Laptop über: `https://[IP-DEINES-SERVERS]:9090`

> **Hinweis:** Da Cockpit standardmäßig ein selbstsigniertes SSL-Zertifikat nutzt, wird dein Browser eine Sicherheitswarnung anzeigen („Dies ist keine sichere Verbindung“). Das ist normal. Du kannst auf „Erweitert“ und dann auf „Risiko akzeptieren und fortfahren“ klicken.

### Falls es Probleme gibt

Sollte die Weboberfläche nicht laden, prüfe mit folgendem Befehl, ob der Port wirklich „hört“:

```
ss -antlp | grep 9090
```

Wenn dort kein Ergebnis kommt, ist der Dienst (`cockpit.socket`) nicht korrekt gestartet.

---

**You**

sudo systemctl status cockpit.socket

× cockpit.socket - Cockpit Web Service Socket

Loaded: loaded (/usr/lib/systemd/system/cockpit.socket; enabled; preset: enabled)

Active: failed (Result: resources) since Tue 2026-06-09 08:50:16 UTC; 1min 53s ago

Invocation: c4b122fec0014308a146a27bca5914b7

Triggers: ● cockpit.service

Docs: man:cockpit-ws(8)

Listen: \[::\]:9090 (Stream)

Process: 66223 ExecStopPost=/bin/ln -snf inactive.issue /run/cockpit/issue (code=exited, status=0/SUCCESS)

Mem peak: 1.9M

CPU: 8ms

Jun 09 08:50:16 macmini (sd-listen)\[66222\]: cockpit.socket: Failed to create listening socket (\[::\]:9090): Address alre>

Jun 09 08:50:16 macmini systemd\[1\]: cockpit.socket: Failed to receive listening socket (\[::\]:9090): Input/output error

Jun 09 08:50:16 macmini systemd\[1\]: cockpit.socket: Failed to listen on sockets: Input/output error

Jun 09 08:50:16 macmini systemd\[1\]: Starting cockpit.socket - Cockpit Web Service Socket...

Jun 09 08:50:16 macmini systemd\[1\]: cockpit.socket: Failed with result 'resources'.

Jun 09 08:50:16 macmini systemd\[1\]: Failed to listen on cockpit.socket - Cockpit Web Service Socket.

---

**Gemini**

Das Problem lässt sich direkt aus dem Log ablesen:

> `cockpit.socket: Failed to create listening socket ([::]:9090): Address already in use`

Der Standard-Port von Cockpit (**9090**) ist auf deinem Server bereits von einem anderen Dienst belegt. Da zwei Dienste nicht gleichzeitig denselben Port beanspruchen können, bricht systemd den Start mit dem Fehler `Result: resources` ab.

Hier sind die zwei Wege, wie du das lösen kannst:

### Schritt 1: Herausfinden, wer Port 9090 blockiert

Gib folgenden Befehl ein, um den Übeltäter zu identifizieren:

```
sudo ss -tulpn | grep 9090
```

*(Alternativ, falls `ss` nichts liefert: `sudo lsof -i :9090`)*

In der Ausgabe siehst du ganz rechts den Prozessnamen (z. B. `docker`, `node`, `java` oder ein anderes Tool).

- **Option A:** Wenn der blockierende Dienst unwichtig ist oder auf einen anderen Port umziehen kann, beende/konfiguriere ihn um.
- **Option B (Empfohlen):** Du lässt dem anderen Dienst den Vortritt und legst Cockpit einfach auf einen anderen Port (z. B. `9095`).

### Schritt 2: Den Port von Cockpit ändern

Da Cockpit über systemd-Sockets gesteuert wird, ändern wir den Port nicht in einer klassischen Konfigurationsdatei, sondern über ein systemd-Override. das ist sauber und übersteht auch zukünftige Updates.

1. Öffne die Override-Konfiguration für den Cockpit-Socket:
	```
	sudo systemctl edit cockpit.socket
	```
2. Es öffnet sich ein Editor (meistens `nano`). Füge dort zwischen den Kommentarzeilen (oder in die leere Datei) exakt folgende Zeilen ein, um den alten Port zu löschen und einen neuen (z. B. **9095**) zu definieren:
	```
	[Socket]
	ListenStream=
	ListenStream=9095
	```
	*(Der erste leere `ListenStream=` Befehl ist zwingend notwendig, um den alten Port 9090 zu löschen!)*
3. Speichere die Datei (`Strg+O`, `Enter`) und verlasse den Editor (`Strg+X`).

### Schritt 3: Socket neu starten

Jetzt musst du systemd mitteilen, dass sich die Konfiguration geändert hat, und den Socket neu starten:

```
sudo systemctl daemon-reload
sudo systemctl restart cockpit.socket
```

Wenn du jetzt `sudo systemctl status cockpit.socket` aufrufst, sollte der Status auf `active (listening)` springen.

### Nicht vergessen: Firewall anpassen

Falls du die `ufw` -Firewall nutzt, musst du nun natürlich den neuen Port freigeben:

```
sudo ufw allow 9095/tcp
```

Deine Weboberfläche ist danach unter `https://[IP-DEINES-SERVERS]:9095` erreichbar.

---

**You**

sudo systemctl edit cockpit.socket startet mit nano, ich möchte aber vi nutzen

---

**Gemini**

Das lässt sich zum Glück sehr schnell umbiegen. `systemctl edit` richtet sich standardmäßig nach den systemweiten Umgebungsvariablen für den Standard-Editor.

Du hast zwei Möglichkeiten: Entweder du erzwingst `vi` nur für diesen einen Befehl, oder du stellst es dauerhaft um.

### Methode 1: Einmalig mit vi öffnen (Quick & Dirty)

Du kannst die Variable `SYSTEMD_EDITOR` einfach direkt vor den Befehl hängen. Das gilt dann nur für diesen Aufruf:

```
sudo SYSTEMD_EDITOR=vi systemctl edit cockpit.socket
```

### Methode 2: Dauerhaft auf vi umstellen

Wenn du generell lieber mit `vi` statt `nano` arbeitest, kannst du deine Shell-Konfiguration anpassen.

Da du standardmäßig wahrscheinlich als normaler Benutzer arbeitest und `sudo` nutzt, ist es am sichersten, die `EDITOR` -Variable systemweit oder für den Root-Kontext zu setzen. Für den aktuellen Benutzer (der `sudo` aufruft) reicht meist ein Eintrag in der Konfigurationsdatei deiner Shell.

Falls du die **Standard-Bash** nutzt, öffne deine `~/.bashrc`:

```
vi ~/.bashrc
```

Füge am Ende folgende Zeile hinzu:

```
export EDITOR=vi
```

Danach die Konfiguration neu laden mit `source ~/.bashrc`.

> 💡 **Hinweis zu `sudo`:** Standardmäßig setzt `sudo` aus Sicherheitsgründen die Umgebungsvariablen des Benutzers zurück. Damit `sudo systemctl edit` deinen gesetzten Editor erkennt, musst du das Flag `-E` (Preserve Environment) mitgeben:
> 
> ```
> sudo -E systemctl edit cockpit.socket
> ```

### Methode 3: Der Ubuntu-Weg (update-alternatives)

Ubuntu verwaltet Standard-Editoren über ein zentrales System. Du kannst `vi` (oder `vim`, falls installiert) als systemweiten Standard für alle Benutzer festlegen:

```
sudo update-alternatives --config editor
```

Es erscheint eine Liste aller installierten Editoren. Tippe einfach die **Nummer** ein, die vor `/usr/bin/vim.basic` oder `/usr/bin/nvi` steht, und drücke `Enter`.

Danach öffnet sich `sudo systemctl edit` abgeleitet davon automatisch immer im Editor deiner Wahl.

---

**You**

sudo SYSTEMD\_EDITOR=vi systemctl edit cockpit.socket

Found modifications outside of the staging area, which would be discarded.

/etc/systemd/system/cockpit.socket.d/override.conf: after editing, new contents are empty, not writing file.

---

**Gemini**

Dieser Fehler tritt bei `vi` (oder `vim`) in Kombination mit `systemctl edit` häufig auf. Er hat zwei Ursachen:

1. **Die leere Datei:** `systemctl edit` öffnet eine temporäre Datei, die komplett aus auskommentierten Zeilen (mit `#` am Anfang) besteht. Wenn du `vi` einfach schließt, ohne Text einzufügen, erkennt `systemd` das als „leere Datei“ und bricht ab (`not writing file`).
2. **Die Swap- bzw. Backup-Dateien von `vi`:** Manchmal hinterlässt `vi` im temporären Verzeichnis versteckte Dateien (z. B. `.override.conf.swp`), die `systemd` verwirren und zu der Meldung `Found modifications outside of the staging area` führen.

Hier ist der saubere Weg, wie du das umgehst und den Port erfolgreich änderst:

### Die Lösung: Den Inhalt direkt übergeben (Ohne Editor-Frust)

Wenn der Editor zickt, kannst du die Konfiguration komplett ohne interaktiven Editor direkt in die Datei schreiben. Das ist schneller und absolut fehlerfrei.

Führe einfach diese drei Befehle nacheinander aus:

```
# 1. Erstelle das notwendige Verzeichnis für den Override
sudo mkdir -p /etc/systemd/system/cockpit.socket.d/

# 2. Schreibe die Port-Änderung (z.B. auf 9095) direkt in die Konfigurationsdatei
sudo tee /etc/systemd/system/cockpit.socket.d/override.conf <<EOF
[Socket]
ListenStream=
ListenStream=9095
EOF

# 3. Systemd die neue Konfiguration einlesen lassen
sudo systemctl daemon-reload
```

### Jetzt den Socket starten

Nachdem die Datei nun sauber liegt, kannst du den Socket direkt starten:

```
sudo systemctl restart cockpit.socket
```

Prüfe den Status:

```
sudo systemctl status cockpit.socket
```

Jetzt sollte dort `active (listening)` stehen und in den Zeilen darunter siehst du, dass er auf Port `9095` (oder deinem gewählten Port) lauscht.

*(Hinweis: Falls du den Port in der Firewall noch nicht freigegeben hast, denk an `sudo ufw allow 9095/tcp`).*

---

**You**

ubuntu server bietet auch prometheus als weboberfläche zur administration

---

**Gemini**

Hier liegt ein kleines Missverständnis vor, was die Aufgaben der beiden Tools angeht: **Prometheus ist keine Weboberfläche zur Administration** von Ubuntu Server, sondern ein reines **Monitoring- und Alarmierungs-Werkzeug**.

Du kannst mit Prometheus den Server also nicht steuern (z. B. keine Benutzer anlegen, Dienste neustarten oder Netzwerke konfigurieren), sondern nur seinen Zustand überwachen.

Hier ist der genaue Unterschied und wie die beiden Welten oft kombiniert werden:

### Was macht Prometheus?

Prometheus ist ein extrem mächtiges Werkzeug, um Metriken (wie CPU-Auslastung, RAM-Verbrauch, Festplattenplatz oder Netzwerkdurchsatz) über die Zeit hinweg aufzuzeichnen.

- Es funktioniert nach dem **Pull-Prinzip**: Prometheus holt sich in regelmäßigen Abständen Daten von deinem Server ab.
- Damit das auf Ubuntu Server klappt, installiert man dort meistens ein kleines Zusatzprogramm namens **Node Exporter**. Dieser liest die Systemdaten aus und stellt sie Prometheus bereit.

### Der Haken bei Prometheus: Die Weboberfläche

Prometheus hat zwar eine eigene, integrierte Weboberfläche, aber diese ist extrem minimalistisch. Sie ist eigentlich nur dazu da, um Rohdaten abzufragen (mittels einer eigenen Abfragesprache namens PromQL) oder den Status der Datenquellen zu prüfen. Hübsch oder übersichtlich ist sie nicht.

Deshalb wird Prometheus in der Praxis fast **nie alleine** betrieben, sondern immer im Team mit **Grafana**.

### Der direkte Vergleich: Cockpit vs. Prometheus + Grafana

| Feature | Cockpit | Prometheus + Grafana |
| --- | --- | --- |
| **Hauptzweck** | **Administration & Steuerung** (Aktionen ausführen) | **Überwachung & Analyse** (Zustand beobachten) |
| **Interaktion** | Bidirektional (Du liest Daten *und* änderst das System) | Unidirektional (Du schaust dir *nur* historische Daten an) |
| **Features** | Terminal, Paket-Updates, Container-Start, HDD-Formatierung | Langzeit-Diagramme, Alarmierung bei Ausfällen (z.B. per Mail/Slack) |
| **Ressourcen** | Extrem leichtgewichtig (läuft nur, wenn du eingeloggt bist) | Braucht permanent etwas RAM und CPU für die Datenbank |

### Fazit

- Wenn du deinen Ubuntu Server **verwalten** willst (Dienste stoppen, Logs live lesen, Updates einspielen), bleibt **Cockpit** deine erste Wahl.
- Wenn du historisch auswerten willst, wie stark dein Server in den letzten drei Monaten ausgelastet war, oder eine Warnung erhalten möchtest, wenn die Festplatte zu 90 % voll ist, dann ist **Prometheus** (zusammen mit Grafana) das richtige Werkzeug.

---

**You**

wie kann ich auf ubuntu server die grafische oberfläche starten

---

**Gemini**

Wenn wir von der „grafischen Oberfläche“ bei Ubuntu Server sprechen, müssen wir zwischen zwei Dingen unterscheiden:

1. **Die Cockpit-Weboberfläche** (die wir gerade konfiguriert haben), auf die du von einem anderen PC aus über den Browser zugreifst.
2. **Einen echten Desktop (GUI)** (wie Ubuntu Desktop mit Fenstern, Taskleiste und Maus), der direkt auf dem Server installiert und gestartet wird.

Hier ist die Anleitung für beide Szenarien:

## Szenario 1: Du meinst die Cockpit-Weboberfläche

Da wir den Port vorhin auf **9095** geändert haben, musst du den Dienst nur starten (falls noch nicht geschehen) und im Browser aufrufen.

1. **Status prüfen:**
	```
	sudo systemctl status cockpit.socket
	```
2. **Starten (falls inaktiv):**
	```
	sudo systemctl enable --now cockpit.socket
	```
3. **Aufrufen:** Öffne an deinem normalen PC oder Laptop den Browser und tippe in die Adresszeile: `https://[IP-DEINES-SERVERS]:9095`

## Szenario 2: Du willst einen echten Linux-Desktop auf dem Server installieren

Standardmäßig hat Ubuntu Server **überhaupt keine** grafische Oberfläche installiert, um Ressourcen zu sparen und die Stabilität zu maximieren. Du siehst am Monitor also nur die Textkonsole (TTY).

Wenn du dort eine echte Desktop-Umgebung (GUI) haben möchtest, musst du sie zuerst nachinstallieren.

### 1\. Minimalistischen Desktop installieren (Empfohlen)

Ein kompletter Ubuntu-Desktop zieht hunderte Megabyte an Software und Hintergrunddiensten nach sich. Für Server empfiehlt sich daher meist eine schlanke Oberfläche wie **XFCE** oder der offizielle, aber abgespeckte Ubuntu-Server-Desktop.

Für den schlanken Ubuntu-Desktop gibst du ein:

```
sudo apt update
sudo apt install --no-install-recommends ubuntu-desktop -y
```

*(Das Flag `--no-install-recommends` sorgt dafür, dass kein Office-Paket, Webbrowser oder Spiele installiert werden.)*

### 2\. Die grafische Oberfläche starten

Nach der Installation startet die Oberfläche bei modernen Ubuntu-Versionen in der Regel automatisch. Falls du dich immer noch auf der Textkonsole befindest, kannst du den Display-Manager (den Anmeldebildschirm) manuell starten:

```
sudo systemctl start gdm3
```

*(Hinweis: Wenn du XFCE installiert hast, heißt der Dienst meist `lightdm`).*

### 3\. Automatischen Start beim Booten festlegen

Wenn der Server ab jetzt immer direkt in die grafische Oberfläche statt in die Textkonsole booten soll, musst du das Standard-Ziel von systemd ändern:

```
sudo systemctl set-default graphical.target
```

Möchtest du das später wieder rückgängig machen, damit der Server wieder ressourcensparend im Textmodus startet, hilft dieser Befehl:

```
sudo systemctl set-default multi-user.target
```

> ⚠️ **Wichtiger Hinweis:** Wenn dein Ubuntu-Server als virtuelle Maschine (VM) oder auf potenter Hardware läuft, ist ein Desktop kein Problem. Läuft er auf sehr schlanker Hardware (z. B. einem älteren Mini-PC oder Raspberry Pi), verbraucht eine grafische Oberfläche permanent wertvollen Arbeitsspeicher und CPU-Leistung, die deinen eigentlichen Server-Diensten dann fehlen. In 95 % der Fälle ist die Verwaltung über **Cockpit** oder die **SSH-Konsole** die bessere Wahl.

---

**You**

wie kann ich gdm3 wieder beenden, es gibt zur zeit keine Konsole als giu app

---

**Gemini**

Wenn gdm3 läuft und du keine Terminal-App (wie *Gnome Terminal* oder *Tilix*) in der Oberfläche findest oder öffnen kannst, bist du erst einmal in der GUI „gefangen“.

Du kannst gdm3 aber ganz einfach über die **virtuellen Textkonsolen (TTY)** von Linux oder über das Netzwerk beenden. Hier sind die zwei schnellsten Wege:

### Weg 1: Der Tastentrick am Server (TTY-Wechsel)

Linux stellt im Hintergrund immer mehrere reine Textkonsolen zur Verfügung, selbst wenn die grafische Oberfläche läuft.

1. Drücke auf der Tastatur, die direkt am Server anschließt, die Tastenkombination: **`Strg` + `Alt` + `F3`** (falls das nicht klappt, versuche `F4`, `F5` oder `F6`).
2. Der Bildschirm wird schwarz und es erscheint eine reine Text-Eingabeaufforderung (`login:`).
3. Melde dich dort mit deinem normalen Benutzernamen und Passwort an.
4. Schieße gdm3 mit folgendem Befehl ab:
	```
	sudo systemctl stop gdm3
	```
5. Damit der Server beim nächsten Reboot nicht wieder die GUI lädt, stelle den Standard-Startmodus direkt wieder auf Text um:
	```
	sudo systemctl set-default multi-user.target
	```

*(Hinweis: Die grafische Oberfläche lief höchstwahrscheinlich auf TTY1 oder TTY2. Mit `Strg` + `Alt` + `F2` könntest du theoretisch wieder dorthin zurückwechseln).*

### Weg 2: Über SSH von einem anderen PC

Wenn du von deinem normalen PC oder Laptop per SSH auf den Server zugreifen kannst, ist das der komfortabelste Weg.

1. Öffne das Terminal auf deinem Haupt-PC und verbinde dich:
	```
	ssh dein-benutzer@ip-des-servers
	```
2. Sobald du eingeloggt bist, beendest du den Display-Manager:
	```
	sudo systemctl stop gdm3
	```
3. Auch hier direkt den Standard für den nächsten Boot zurücksetzen:
	```
	sudo systemctl set-default multi-user.target
	```

Sobald du `sudo systemctl stop gdm3` ausführst, wird der X-Server bzw. Wayland-Server beendet, der Arbeitsspeicher wird sofort wieder freigegeben und der physische Monitor am Server springt zurück in den reinen Textmodus.

---

**You**

ich habe festgestellt, das der Ubuntu server vom dhcp server nicht immer die gleiche ip zugeteilt bekommt, gibt es eine lösung

---

**Gemini**

Ja, dafür gibt es zwei saubere Lösungen. Welche die bessere ist, hängt davon ab, wie du dein Netzwerk am liebsten verwaltest.

### Lösung 1: Die „Statische DHCP-Lease“ im Router (Empfohlen)

Statt am Server selbst etwas zu ändern, sagst du deinem Router (z. B. einer Fritz!Box, einem Speedport oder dem DHCP-Server deines Netzwerks), dass er diesem spezifischen Gerät anhand seiner **MAC-Adresse** (der eindeutigen Hardware-ID der Netzwerkkarte) *immer* dieselbe IP-Adresse zuweisen soll.

- **Vorteil:** Du verwaltest alle IPs zentral an einem Ort. Es kann nie zu IP-Adresskonflikten kommen, weil der Router den Überblick behält. Der Server bleibt flexibel (falls er mal in ein anderes Netzwerk umzieht).
- **So geht's (am Beispiel Fritz!Box):**
	1. Öffne die Benutzeroberfläche deines Routers im Browser.
		2. Gehe zu **Heimnetz** -> **Netzwerk**.
		3. Suche deinen Ubuntu Server (`macmini`) in der Liste und klicke auf das Stift-Symbol (Bearbeiten).
		4. Setze den Haken bei **„Diesem Netzwerkgerät immer die gleiche IPv4-Adresse zuweisen“**.
		5. Speichern – fertig.

### Lösung 2: Eine feste (statische) IP direkt in Ubuntu Server eintragen

Wenn du die Kontrolle lieber direkt auf dem Server hast, kannst du Ubuntu so konfigurieren, dass es den DHCP-Server komplett ignoriert und sich selbst eine feste IP zuweist.

Ubuntu nutzt dafür seit einigen Versionen das Tool **Netplan**. Die Konfiguration erfolgt über eine YAML-Datei.

#### 1\. Konfigurationsdatei finden

Wechsle in das Netplan-Verzeichnis:

```
cd /etc/netplan/
```

Schaue mit `ls` nach, wie die Datei dort heißt (oft `01-netcfg.yaml`, `50-cloud-init.yaml` oder ähnlich).

#### 2\. Datei bearbeiten

Öffne die Datei (da wir wissen, dass du `vi` bevorzugst, nehmen wir das direkt):

```
sudo vi /etc/netplan/01-netcfg.yaml
```

#### 3\. Inhalt anpassen

Ersetze den Inhalt durch folgendes Schema. **Wichtig:** YAML verzeiht keine Tabulatoren! Nutze ausschließlich Leerzeichen zum Einrücken.

```
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:                    # <-- HIER deinen Schnittstellen-Namen eintragen!
      dhcp4: no
      addresses:
        - 192.168.178.100/24   # <-- Deine Wunsch-IP und Subnetz (/24 ist Standard)
      routes:
        - to: default
          via: 192.168.178.1   # <-- Die IP deines Routers (Gateway)
      nameservers:
        addresses:
          - 192.168.178.1      # <-- Meistens auch der Router
          - 1.1.1.1            # Optional: Alternativer DNS (z.B. Cloudflare)
```

> 💡 **Tipp:** Wenn du den genauen Namen deiner Netzwerkschnittstelle (oben `enp3s0`) nicht weißt, tippe vorher im Terminal `ip a` ein. Such nach dem Eintrag, der aktuell deine DHCP-IP hält.

#### 4\. Konfiguration testen und anwenden

Netplan hat einen eingebauten Schutzmechanismus. Wenn du folgenden Befehl ausführst, testet er die Konfiguration. Drückst du innerhalb von 120 Sekunden nicht `Enter`, macht er die Änderungen rückgängig (falls du dich ausgesperrt hast):

```
sudo netplan try
```

Wenn alles passt, bestätige mit Enter. Alternativ kannst du es direkt erzwingen mit:

```
sudo netplan apply
```

Ab jetzt behält dein Server bombenfest diese IP, und du kannst Cockpit oder SSH immer unter derselben Adresse aufrufen.

---

**You**

bitte für lösung 2 eine konfiguration für folgende schnittstelle:

2: enp3s0f0: <BROADCAST,MULTICAST,UP,LOWER\_UP> mtu 1500 qdisc mq state UP group default qlen 1000

link/ether 0c:4d:e9:c5:fc:db brd ff:ff:ff:ff:ff:ff

altname enx0c4de9c5fcdb

inet 10.10.105.105/24 metric 1024 brd 10.10.105.255 scope global dynamic enp3s0f0

valid\_lft 604333sec preferred\_lft 604333sec

inet6 fe80::e4d:e9ff:fec5:fcdb/64 scope link proto kernel\_ll

valid\_lft forever preferred\_lft forever

---

**Gemini**

Hier ist die exakte Netplan-Konfiguration für deine Schnittstelle `enp3s0f0`. Ich habe die Werte (Gateway und DNS) basierend auf deinem aktuellen IP-Netzwerk (`10.10.105.0/24`) auf die in solchen Netzen übliche `.1` angepasst. Falls dein Router/Gateway eine andere IP hat, ändere die `10.10.105.1` einfach im Editor ab.

Öffne die Datei mit `vi`:

```
sudo vi /etc/netplan/01-netcfg.yaml
```

Ersetze den Inhalt vollständig durch folgende Konfiguration. Achte im `vi` penibel darauf, **keine Tabs**, sondern nur Leerzeichen für die Einrückungen zu nutzen:

```
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0f0:
      dhcp4: no
      addresses:
        - 10.10.105.105/24
      routes:
        - to: default
          via: 10.10.105.1
      nameservers:
        addresses:
          - 10.10.105.1
          - 1.1.1.1
```

### Übernehmen und Testen

Da du via Netzwerk (SSH) verbunden sein könntest, nutze unbedingt den Sicherheitsmodus von Netplan. Falls du dich vertippt hast, bricht er nach zwei Minuten ab und stellt die alte Verbindung wieder her:

```
sudo netplan try
```

Wenn alles glattläuft und deine Verbindung hält, drücke einfach **Enter**, um die Konfiguration dauerhaft zu übernehmen.

---

**You**

bitte mache aus den ergebnissen des komplettes chats ein kommentiertes Arbeitblatt als obsidian markdown

---

**Gemini**

Ich habe dir ein umfassendes, übersichtliches und fertig formatiertes Arbeitsblatt für dein Obsidian-Notebook erstellt.

Es fasst alle Themen unseres Chats zusammen – von Cockpit über Editor-Einstellungen und GUI-Management bis hin zur konkreten Netplan-Konfiguration für deine Netzwerkschnittstelle. Es nutzt auch native Obsidian-Features wie YAML-Frontmatter, Tags und Callouts (Infoboxen), damit es sich perfekt in dein persönliches Wiki einfügt.

Hier ist die Datei:

Ubuntu Server Administration Cheat Sheet

9\. Juni, 11:59

```
Ich habe alle besprochenen Lerneinheiten logisch strukturiert. Du kannst den Dateiinhalt einfach kopieren und in eine neue \`.md\`-Datei in deinem Obsidian-Vault einfügen. 

Gibt es noch einen bestimmten Bereich oder Befehl, zu dem du nähere Details ergänzt haben möchtest?
```