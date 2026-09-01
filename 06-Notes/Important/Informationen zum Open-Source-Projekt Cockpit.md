
## Was ist Cockpit?

Cockpit ist eine webbasierte grafische Benutzeroberfläche zur Verwaltung von Linux-Servern. Es wurde entwickelt, um die Serveradministration einfacher zu gestalten und ist für alle Benutzer zugänglich, besonders für Systemadministratoren.

## Haupteigenschaften

Cockpit macht Linux leicht zugänglich. Man muss sich keine Befehle in der Kommandozeile merken, sondern kann den Server in einem Webbrowser sehen und Systemaufgaben mit der Maus erledigen. Zu den Hauptfunktionen gehören:

- Verwaltung von Containern
- Administration von Speicher
- Konfiguration von Netzwerken
- Inspektion von Logs
- Überwachung der CPU-, Arbeitsspeicher-, Netzwerk- und Festplatten-I/O-Leistung

## Technische Aspekte

Cockpit verwendet die bereits auf dem System vorhandenen APIs. Es erfindet keine Subsysteme neu oder fügt eine eigene Tooling-Schicht hinzu. Standardmäßig verwendet Cockpit die normalen Benutzeranmeldungen und Berechtigungen des Systems.

Es ist leicht zu bedienen und sehr leichtgewichtig. Cockpit interagiert direkt mit dem Betriebssystem aus einer echten Linux-Sitzung in einem Browser.

Interessanterweise verbraucht Cockpit selbst keine Ressourcen und läuft auch nicht im Hintergrund, wenn es nicht verwendet wird. Es wird bei Bedarf dank systemd-Socket-Aktivierung ausgeführt.

## Installation und Unterstützung

Sie können Cockpit auf vielen Linux-Betriebssystemen installieren, darunter Debian, Fedora und RHEL (Red Hat Enterprise Linux).

Je nach Distribution gibt es verschiedene Installationsmethoden:

- Für Debian wird empfohlen, die neueste Version aus den Backports zu installieren oder zu aktualisieren.
- Auf Red Hat Enterprise Linux 7 muss das Extras-Repository aktiviert werden.
- Für RHEL 8 sind keine zusätzlichen Repositories erforderlich.
- Auf RHEL- oder Fedora-basierten Systemen kann die Installation mit `dnf -y install cockpit` erfolgen, gefolgt von `systemctl enable --now cockpit.socket`

## Modulare Erweiterungen

Cockpit unterstützt eine große Anzahl optionaler und Drittanbieter-Anwendungen wie:

- cockpit-podman für die Containerverwaltung
- cockpit-machines für die Verwaltung virtueller Maschinen (ersetzt virt-manager)
- cockpit-networkmanager zur Konfiguration von Netzwerkschnittstellen
- cockpit-packagekit zum Installieren, Entfernen oder Aktualisieren von Paketen
- cockpit-storaged zur Verwaltung der Speichergeräte eines Systems

## Zugriff auf Cockpit

Der Standardport für Cockpit ist 9090. Um auf die Cockpit-Oberfläche eines Servers zuzugreifen, zeigen Sie einfach Ihren Browser auf hostname:9090. Sie können localhost:9090 für den lokalen Server verwenden, auf dem Sie angemeldet sind.

Der Zugriff erfolgt über HTTPS: https://servername:9090

## Vorteile und Einsatzbereiche

Cockpit eignet sich für Organisationen jeder Größe, selbst für kleine Büros, und ist eine großartige Möglichkeit für Heimanwender, die familiäre IT-Infrastruktur zu warten. Es ermöglicht die Verwaltung mehrerer Server von einer einzigen Oberfläche aus.

Einer der großen Vorteile von Cockpit ist die Möglichkeit, Updates durchzuführen, ohne physisch an jedem Gerät angemeldet sein zu müssen.

Wenn Sie weitere spezifische Informationen zu bestimmten Aspekten von Cockpit benötigen, lassen Sie es mich bitte wissen.