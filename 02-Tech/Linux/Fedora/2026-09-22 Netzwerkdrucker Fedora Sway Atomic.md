---
title: Netzwerkdrucker unter Fedora Sway Atomic einbinden
created: 2026-09-22
type: chat-protokoll
source: claude.ai
model: Claude Opus 5
tags:
  - chat-protokoll
  - cups
  - drucker
  - fedora-atomic
  - nushell
status: active
---

# Netzwerkdrucker unter Fedora Sway Atomic einbinden

> [!summary] Zusammenfassung
> Ziel war, zwei Kyocera-Netzwerkdrucker unter [[Fedora Sway Atomic]] in [[CUPS]] einzubinden. Gewählt wurde der treiberlose Weg über IPP Everywhere (`lpadmin -m everywhere`), weil Herstellertreiber auf einem Atomic-System einen `rpm-ostree`-Layer erfordern würden. Die Drucker wurden per `nmap`-Portscan (Ports 631/9100) im Subnetz gefunden; das Modell des zweiten Druckers wurde schließlich unter Windows ermittelt. Am Ende stand ein fertiger `lpadmin`-Befehl in [[Nushell]]-Syntax für die TASKalfa 3554ci. Ob die Einrichtung erfolgreich war, wurde im Chat nicht mehr zurückgemeldet.

> [!warning] Hinweise zur Vollständigkeit
> Die privaten IP-Adressen der Drucker und das Subnetz sind durch Platzhalter ersetzt:
> `<IP-3554ci>` (TASKalfa 3554ci), `<IP-308ci>` (TASKalfa 308ci), `<SUBNETZ>/24`.

## Ausgangslage

- System: [[Fedora Sway Atomic]], Shell: [[Nushell]]
- Drucker 1: Kyocera TASKalfa 308ci KX unter `<IP-308ci>` (IP bekannt)
- Drucker 2: unbekanntes Modell im selben Subnetz, später identifiziert als Kyocera TASKalfa 3554ci unter `<IP-3554ci>`, Standort „Verwaltung“
- Ziel: Drucker in CUPS einrichten, möglichst ohne Treiberinstallation ins schreibgeschützte `/usr`

## Problemlösungen

### 1. Drucker auf Atomic-System einbinden ohne Herstellertreiber

**Symptom**

```text
Kyocera bietet Linux-Treiber als RPM mit eigenen CUPS-Filtern an;
/usr ist auf Fedora Atomic schreibgeschützt.
```

**Ursache:** Herstellertreiber müssten per `rpm-ostree install` als Layer ins Image; Filter lassen sich nicht einfach nach `/usr/lib/cups/filter` kopieren.

**Lösung:** Treiberlos über IPP Everywhere. CUPS liest die Fähigkeiten (Duplex, Farbe, Fächer, Formate) direkt vom Gerät.

```bash
rpm -q cups
systemctl status cups
sudo systemctl enable --now cups   # falls nicht aktiv

sudo lpadmin -p Kyocera308ci -E \
  -v ipp://<IP-308ci>/ipp/print \
  -m everywhere \
  -L "Büro" -D "Kyocera TASKalfa 308ci"

lpoptions -d Kyocera308ci
lpoptions -p Kyocera308ci -l
lpoptions -p Kyocera308ci -o sides=two-sided-long-edge   # Duplex als Standard
lp -d Kyocera308ci /usr/share/cups/data/testprint
```

> [!failure]- Verworfene Ansätze
> - Kyocera-Linux-Treiber per `rpm-ostree install` – nur nötig, wenn Spezialfunktionen (Kostenstellen, Benutzerkennung) fehlen; erzeugt einen dauerhaften Layer.
> - „KX“-Treiber – bezeichnet den Windows-Treiber, unter Linux nicht relevant.

**Verifikation**

```bash
ipptool -tv ipp://<IP-308ci>/ipp/print get-printer-attributes.test | head -30
# erwartet: Attribute wie printer-make-and-model
```

### 2. Drucker automatisch im Netz finden (mDNS/DNS-SD)

**Symptom**

```text
IP und Name der Drucker sollten gesucht statt manuell eingegeben werden.
```

**Ursache:** Netzwerkdrucker kündigen sich per Bonjour/mDNS an; die Suche funktioniert aber nur im selben Subnetz und bei freigegebener Firewall.

**Lösung**

```bash
ippfind                                  # liefert fertige IPP-URIs
lpinfo -v                                # CUPS-Backends inkl. SNMP
avahi-browse -rt _ipp._tcp               # Name, Hostname, IP
sudo systemctl enable --now cups-browsed # automatisches Anlegen von Warteschlangen
```

Checkliste, wenn nichts gefunden wird:

```bash
systemctl status avahi-daemon
firewall-cmd --list-services
sudo firewall-cmd --permanent --add-service=mdns && sudo firewall-cmd --reload
```

Weitere Ursachen: anderes Subnetz (mDNS geht nicht über Router), Bonjour am Drucker im Kyocera Command Center deaktiviert.

**Verifikation:** nicht im Chat zurückgemeldet.

### 3. Unbekannte Drucker-IP ermitteln

**Symptom**

```text
IP-Adresse eines Druckers unbekannt, mDNS-Suche liefert nicht zuverlässig.
```

**Ursache:** –

**Lösung:** Portscan auf IPP (631) und RAW/JetDirect (9100) in einer [[Toolbx]], da `nmap` nicht im Atomic-Image ist.

```bash
toolbox create net && toolbox enter net
sudo dnf install -y arp-scan nmap
nmap -p 631,9100 --open <SUBNETZ>/24
```

Alternativen: Statusseite am Drucker drucken, DHCP-Liste im Router, `avahi-resolve -n <name>.local`, ARP-Scan mit Herstellerfilter (`sudo arp-scan --localnet | grep -i kyocera`), Ping-Sweep plus `ip neigh`.

**Verifikation**

```text
Nmap scan report for <IP-3554ci>
631/tcp  open  ipp
9100/tcp open  jetdirect

Nmap scan report for <IP-308ci>
631/tcp  open  ipp
9100/tcp open  jetdirect
```

### 4. Name und Modell eines gefundenen Druckers ermitteln

**Symptom**

```text
Drucker unter <IP-3554ci> gefunden, Modell unbekannt.
```

**Ursache:** –

**Lösung:** Drucker per IPP abfragen; `document-format-supported` zeigt, ob treiberlos möglich ist (`image/pwg-raster` oder `image/urf`).

```bash
ipptool -tv ipp://<IP-3554ci>/ipp/print get-printer-attributes.test \
  | grep -E 'printer-(make-and-model|name|info|location)|document-format-supported'
```

Alternativen: Weboberfläche `http://<IP-3554ci>`, `nmap -sV -p 631,9100 <IP-3554ci>`. Tatsächlich wurde das Modell schließlich **unter Windows** ermittelt: Kyocera TASKalfa 3554ci.

**Verifikation:** Modell unter Windows bestätigt.

### 5. Missverständnis: Suche in der CUPS-Weboberfläche

**Symptom**

```text
Frage, ob über http://localhost:631/printers/ nach Druckern gesucht werden kann.
```

**Ursache:** Das Suchfeld unter `/printers/` durchsucht nur **bereits eingerichtete** Warteschlangen (Name, Beschreibung, Standort, Modell, URI), nicht das Netzwerk.

**Lösung:** Neue Drucker über `http://localhost:631/admin` → „Drucker hinzufügen“ (Anmeldung mit Benutzer in Gruppe `wheel`) → „Gefundene Netzwerkdrucker“. Fehlt ein Gerät: „Andere Netzwerkdrucker“ → „Internet Printing Protocol (ipp)“ → URI von Hand → Modell „IPP Everywhere“.

**Verifikation:** nicht im Chat zurückgemeldet.

### 6. `lpadmin`-Befehl in Nushell-Syntax

**Symptom**

```text
Mehrzeiliger Bash-Befehl mit Backslash-Fortsetzung funktioniert in Nushell nicht.
```

**Ursache:** [[Nushell]] kennt keine Zeilenfortsetzung per `\`; mehrzeilige Befehle werden in runde Klammern gesetzt.

**Lösung**

```nu
(sudo lpadmin -p TASKalfa3554ci -E
    -v ipp://<IP-3554ci>/ipp/print
    -m everywhere
    -L Verwaltung
    -D "Kyocera TASKalfa 3554ci")

lpstat -v TASKalfa3554ci
lp -d TASKalfa3554ci /usr/share/cups/data/testprint
lpoptions -d TASKalfa3554ci   # optional als Standard
```

Falls „Unable to get printer attributes“: Pfad `/ipp/print` durch `/ipp` ersetzen oder weglassen.

**Verifikation:** nicht im Chat zurückgemeldet.

## Artefakte & Prompts

Keine Artefakte erzeugt.

## Entscheidungen

- Treiberlos über IPP Everywhere statt Kyocera-Treiber – kein `rpm-ostree`-Layer nötig, Fähigkeiten kommen direkt vom Gerät.
- Netzwerk-Tools (`nmap`, `arp-scan`) in einer Toolbx statt im Host-Image – hält das Atomic-System schlank.
- Warteschlangennamen ohne Leerzeichen (`Kyocera308ci`, `TASKalfa3554ci`), Klartext in `-D` und Standort in `-L`.

## Nützliche Befehle & Snippets

```bash
ippfind                                            # IPP-Drucker per mDNS finden
avahi-browse -rt _ipp._tcp                         # Drucker mit IP anzeigen
lpinfo -v                                          # CUPS-Backends/gefundene Geräte
nmap -p 631,9100 --open <SUBNETZ>/24               # Drucker per Portscan finden
ipptool -tv ipp://<IP>/ipp/print get-printer-attributes.test  # Modell/Fähigkeiten
lpstat -v                                          # eingerichtete Warteschlangen
lpoptions -p <QUEUE> -l                            # Druckoptionen anzeigen
```

## Offene Punkte

- [ ] Erfolg von `lpadmin` für TASKalfa 3554ci prüfen (Testseite, richtiger IPP-Pfad)
- [ ] TASKalfa 308ci tatsächlich einrichten bzw. Einrichtung bestätigen
- [ ] Standarddrucker festlegen
- [ ] Standardoptionen (Duplex, Farbe/SW) je Drucker setzen
